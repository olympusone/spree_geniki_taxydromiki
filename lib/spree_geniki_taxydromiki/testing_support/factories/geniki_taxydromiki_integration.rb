FactoryBot.define do
  factory :geniki_taxydromiki_integration, class: Spree::Integrations::GenikiTaxydromiki do
    active { true }
    preferred_wsdl_url { ENV['GENIKI_TAXYDROMIKI_WSDL_URL'] }
    preferred_username { ENV['GENIKI_TAXYDROMIKI_USERNAME'] }
    preferred_password { ENV['GENIKI_TAXYDROMIKI_PASSWORD'] }
    preferred_app_key { ENV['v'] }
    store { Spree::Store.default }
  end
end
