module Spree
  module OrderDecorator
    def can_create_voucher_job?
      shipments.any?(&:can_create_voucher_job?)
    end

    def can_cancel_voucher_job?
      shipments.any?(&:can_cancel_voucher_job?)
    end

    def can_reactivate_voucher_job?
      shipments.any?(&:can_reactivate_voucher_job?)
    end

    def can_finalize_voucher_job?
      shipments.any?(&:can_finalize_voucher_job?)
    end
  end
end

Spree::Order.prepend Spree::OrderDecorator
