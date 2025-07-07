require 'spec_helper'

RSpec.describe GenikiTaxydromiki::SoapClient, :integration do
  let(:integration_double) do
    double(
      preferred_wsdl_url: ENV['GENIKI_TAXYDROMIKI_WSDL_URL'],
      preferred_username: ENV['GENIKI_TAXYDROMIKI_USERNAME'],
      preferred_password: ENV['GENIKI_TAXYDROMIKI_PASSWORD'],
      preferred_app_key:  ENV['GENIKI_TAXYDROMIKI_APP_KEY']
    )
  end

  before do
    allow_any_instance_of(GenikiTaxydromiki::SoapClient)
      .to receive(:store_integration)
      .with('geniki_taxydromiki')
      .and_return(integration_double)
  end

  let(:client) { described_class.new }

  it "authenticates successfully with the test service" do
    key = client.authenticate!
    expect(key).to be_a(String)
    expect(key.length).to be > 0
    puts "Authentication key: #{key}"
  end
end
