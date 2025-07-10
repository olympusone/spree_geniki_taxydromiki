module SpreeGenikiTaxydromiki
  class PrintVouchers
    include Spree::IntegrationsConcern

    attr_reader :voucher_numbers, :client

    def initialize(voucher_numbers)
      @voucher_numbers = voucher_numbers

      @client = GenikiTaxydromiki::SoapClient.new
    end

    def call
      integration = store_integration('geniki_taxydromiki')

      raise 'Integration not found' unless integration

      wsdl_url = integration.preferred_wsdl_url

      raise 'WSDL URL is required' unless wsdl_url

      auth_key = ERB::Util.url_encode(client.auth_key)

      pdf_url = "#{wsdl_url}/GetVouchersPdf?authKey=#{auth_key}"

      voucher_numbers.each do |voucher_number|
        pdf_url += "&voucherNumbers=#{voucher_number}"
      end

      paper_type = integration.preferred_paper_type
      pdf_url += "&format=#{paper_type}&extraInfoFormat=None"

      pdf_url
    end
  end
end
