module SpreeGenikiTaxydromiki
  class PrintVoucher
    attr_reader :shipment, :client

    def initialize(shipment)
      @shipment = shipment

      @client = GenikiTaxydromiki::SoapClient.new
    end

    def call
      # TODO: Implement the logic to print the voucher
    end
  end
end
