module Spree
  module Integrations
    class GenikiTaxydromiki < Spree::Integration
      preference :wsdl_url, :string
      preference :username, :string
      preference :password, :string
      preference :app_key, :string
      preference :paper_type, :string, default: 'Flyer'

      validates :preferred_wsdl_url, presence: true
      validates :preferred_username, presence: true
      validates :preferred_password, presence: true
      validates :preferred_app_key, presence: true
      validates :preferred_paper_type, presence: true, inclusion: { in: %w[Flyer Sticker] }

      def self.integration_group
        'shipping'
      end

      def self.icon_path
        'integration_icons/geniki-taxydromiki-logo.png'
      end
    end
  end
end
