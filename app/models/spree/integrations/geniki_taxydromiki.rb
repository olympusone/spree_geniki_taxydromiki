module Spree
  module Integrations
    class GenikiTaxydromiki < Spree::Integration
      preference :username, :string
      preference :password, :string
      preference :app_key, :string

      validates :username, presence: true
      validates :password, presence: true
      validates :app_key, presence: true

      def self.integration_group
        'shipping'
      end

      def self.icon_path
        'integration_icons/geniki-taxydromiki-logo.png'
      end
    end
  end
end
