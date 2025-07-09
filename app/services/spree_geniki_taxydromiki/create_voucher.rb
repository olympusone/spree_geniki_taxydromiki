module SpreeGenikiTaxydromiki
  class CreateVoucher
    attr_reader :order, :shipment, :client

    def initialize(shipment)
      @order = shipment.order
      @shipment = shipment

      @client = GenikiTaxydromiki::SoapClient.new
    end

    def call
      address = shipment.address
      cod_payment = order.payment_method&.cod_payment?

      record = {
        OrderId: order.number,
        Name: address.full_name,
        Address: address.address1,
        City: address.city,
        Country: address.country_iso,
        Email: order.email,
        Telephone: address.phone,
        Zip: address.zipcode,
        Weight: shipment.item_weight,
        Pieces: shipment.item_quantity,
        Services: cod_payment ? 'ΑΜ' : nil, # e.g. COD, otherwise leave empty
        CodAmount: cod_payment ? shipment.item_cost : 0
      }

      result = client.call(
        :create_job,
        {
          oVoucher: record,
          eType: 'Voucher'
        }
      )

      return result[:voucher] if result[:result].to_i.zero?

      raise VoucherError, "Failed to create voucher: #{result[:message]}" if result[:result].to_i != 0
    end

    class VoucherError < StandardError; end
  end
end
