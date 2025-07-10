module SpreeGenikiTaxydromiki
  class FinalizeVouchers
    attr_reader :client

    def initialize
      @client = GenikiTaxydromiki::SoapClient.new
    end

    def call
      result = client.call(:close_pending_jobs)

      return true if result

      raise FinalizeJobError, 'Failed to finalize voucher job'
    end

    class FinalizeJobError < StandardError; end
  end
end
