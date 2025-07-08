Rails.application.config.after_initialize do
  Rails.application.config.spree.integrations << Spree::Integrations::GenikiTaxydromiki

  if Rails.application.config.respond_to?(:spree_admin)
    Rails.application.config.spree_admin.order_page_dropdown_partials << 'spree_geniki_taxydromiki/order_dropdown_options'
  end

  # Storefront partials
  Rails.application.config.spree_admin.head_partials << 'spree_geniki_taxydromiki/head'
end
