module Spree
  module ShipmentDecorator
    # TODO: remove this method when the Spree version implementing this method
    # Returns the total quantity of all line items in the shipment
    def item_quantity
      manifest.map { |m| m.line_item.quantity }.sum
    end

    def can_create_voucher_job?
      !job_id? && ready?
    end

    def can_cancel_voucher_job?
      job_id? && !job_canceled_at? && ready?
    end

    def can_reactivate_voucher_job?
      job_id? && job_canceled_at? && ready?
    end

    def can_finalize_voucher_job?
      job_id? && !job_canceled_at? && !job_finalized_at? && ready?
    end

    def can_print_voucher?
      job_id? && !job_canceled_at?
    end
  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator
