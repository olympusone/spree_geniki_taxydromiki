module Spree
  module Integrations
    class GenikiTaxydromiki < Spree::Integration
      preference :wsdl_url, :string
      preference :username, :string
      preference :password, :string
      preference :app_key, :string

      validates :preferred_wsdl_url, presence: true
      validates :preferred_username, presence: true
      validates :preferred_password, presence: true
      validates :preferred_app_key, presence: true

      def self.integration_group
        'shipping'
      end

      def self.icon_path
        'integration_icons/geniki-taxydromiki-logo.png'
      end
    end
  end
end
