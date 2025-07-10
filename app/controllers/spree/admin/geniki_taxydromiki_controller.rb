module Spree
  module Admin
    class GenikiTaxydromikiController < Spree::Admin::BaseController
      def create
        begin
          load_order

          @order.shipments.each do |shipment|
            next unless shipment.can_create_voucher_job?

            result = SpreeGenikiTaxydromiki::CreateVoucher.new(shipment).call

            shipment.update(
              tracking: result[:voucher],
              job_id: result[:job_id]
            )
          end

          flash[:success] = Spree.t('admin.integrations.geniki_taxydromiki.voucher_successfully_created')
          redirect_to spree.admin_order_path(@order)
        rescue ActiveRecord::RecordNotFound
          order_not_found
        rescue StandardError => e
          Rails.logger.error "Geniki Taxydromiki Error: #{e.message}"

          flash[:error] = Spree.t('admin.integrations.geniki_taxydromiki.voucher_creation_failed')
          redirect_to spree.admin_order_path(@order)
        end
      end

      def print
        begin
          load_order

          voucher_numbers = @order.shipments.select(&:can_print_voucher?)
                                  .map(&:tracking).compact

          if voucher_numbers.empty?
            raise StandardError, Spree.t('admin.integrations.geniki_taxydromiki.voucher_print_failed')
          else
            pdf_url = SpreeGenikiTaxydromiki::PrintVouchers.new(voucher_numbers).call

            SpreeGenikiTaxydromiki::FinalizeVouchersJob.perform_later

            render json: {
              url: pdf_url
            }, status: 200
          end
        rescue ActiveRecord::RecordNotFound
          render json: {
            error: flash_message_for(Spree::Order.new, :not_found)
          }, status: 404
        rescue StandardError => e
          Rails.logger.error "Geniki Taxydromiki Error: #{e.message}"

          render json: {
            error: Spree.t('admin.integrations.geniki_taxydromiki.voucher_print_failed')
          }, status: 400
        end
      end

      def cancel
        begin
          load_order

          @order.shipments.each do |shipment|
            SpreeGenikiTaxydromiki::CancelVoucher.new(shipment).call

            shipment.update(
              job_canceled_at: Time.current
            )
          end

          flash[:success] = Spree.t('admin.integrations.geniki_taxydromiki.voucher_successfully_canceled')
          redirect_to spree.admin_order_path(@order)
        rescue ActiveRecord::RecordNotFound
          order_not_found
        rescue StandardError => e
          Rails.logger.error "Geniki Taxydromiki Error: #{e.message}"

          flash[:error] = Spree.t('admin.integrations.geniki_taxydromiki.voucher_cancellation_failed')
          redirect_to spree.admin_order_path(@order)
        end
      end

      def reactivate
        begin
          load_order

          @order.shipments.each do |shipment|
            SpreeGenikiTaxydromiki::ReactivateVoucher.new(shipment).call

            shipment.update(
              job_canceled_at: nil
            )
          end

          flash[:success] = Spree.t('admin.integrations.geniki_taxydromiki.voucher_successfully_reactivated')

          redirect_to spree.admin_order_path(@order)
        rescue ActiveRecord::RecordNotFound
          order_not_found
        rescue StandardError => e
          Rails.logger.error "Geniki Taxydromiki Error: #{e.message}"

          flash[:error] = Spree.t('admin.integrations.geniki_taxydromiki.voucher_reactivation_failed')

          redirect_to spree.admin_order_path(@order)
        end
      end

      private

      def load_order
        @order = current_store.orders.find(params[:order_id])
        authorize! action, @order
        @order
      end

      def order_not_found
        flash[:error] = flash_message_for(Spree::Order.new, :not_found)
        redirect_to spree.admin_orders_path
      end
    end
  end
end
