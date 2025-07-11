module Spree
  module ShipmentDecorator
    def self.prepended(base)
      base.state_machine.after_transition to: :shipped, do: :run_finalize_vouchers_job
    end

    # TODO: remove this method when the Spree version implementing this method
    # Returns the total quantity of all line items in the shipment
    def item_quantity
      manifest.map { |m| m.line_item.quantity }.sum
    end

    def can_create_voucher_job?
      !job_id? && ready?
    end

    def can_cancel_voucher_job?
      job_id? && !job_canceled_at? && !job_finalized_at? && ready?
    end

    def can_reactivate_voucher_job?
      job_id? && job_canceled_at? && ready?
    end

    def can_finalize_voucher_job?
      job_id? && !job_canceled_at? && !job_finalized_at? && shipped?
    end

    def can_print_voucher?
      tracked? && !job_canceled_at?
    end

    private

    def run_finalize_vouchers_job
      SpreeGenikiTaxydromiki::FinalizeVouchersJob.perform_later(id)
    end
  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator
