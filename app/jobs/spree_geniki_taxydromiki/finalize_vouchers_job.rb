module SpreeGenikiTaxydromiki
  class FinalizeVouchersJob < Spree::BaseJob
    queue_as SpreeGenikiTaxydromiki.queue

    def perform
      SpreeGenikiTaxydromiki::FinalizeVouchers.new.call

      Spree::Shipment.where.not(tracking: nil, job_id: nil)
        .where(job_finalized_at: nil)
        .update_all(job_finalized_at: Time.current)
    end
  end
end
