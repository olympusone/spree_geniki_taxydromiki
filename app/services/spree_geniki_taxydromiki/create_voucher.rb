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
        'OrderId' => order.number,
        'Name' => address.full_name,
        'Address' => address.address1,
        'City' => address.city,
        'Country' => address.country_iso,
        'Email' => order.email,
        'Telephone' => address.phone,
        'Zip' => address.zipcode,
        'Comments' => '',
        'Weight' => shipment.item_weight.to_f,
        'Pieces' => 1, # shipment.item_quantity,
        'Services' => cod_payment ? 'ΑΜ' : '', # e.g. COD, otherwise leave empty
        'CodAmount' => cod_payment ? shipment.final_price_with_items.to_f : 0,
        'InsAmount' => 0 # Insurance amount, set to 0 if not applicable
      }

      result = client.call(
        :create_job,
        {
          oVoucher: record,
          eType: 'Voucher'
        }
      )

      return result if result[:result].to_i.zero?

      raise VoucherError, "Failed to create voucher: #{result[:message]}" if result[:result].to_i != 0
    end

    class VoucherError < StandardError; end
  end
end
