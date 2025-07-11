module SpreeGenikiTaxydromiki
  class FinalizeVouchersJob < Spree::BaseJob
    queue_as SpreeGenikiTaxydromiki.queue

    def perform(id)
      SpreeGenikiTaxydromiki::FinalizeVouchers.new.call

      Spree::Shipment.find(id).update(job_finalized_at: Time.current)
    end
  end
end
