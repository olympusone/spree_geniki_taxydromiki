module SpreeGenikiTaxydromiki
  class ReactivateVoucher
    attr_reader :shipment, :client

    def initialize(shipment)
      @shipment = shipment

      @client = GenikiTaxydromiki::SoapClient.new
    end

    def call
      result = client.call(
        :cancel_job,
        {
          nJobId: shipment.job_id,
          bCancel: false
        }
      )

      return true if result

      raise CancelJobError, "Failed to reactivate voucher job: #{shipment.job_id}"
    end

    class CancelJobError < StandardError; end
  end
end
