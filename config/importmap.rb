pin 'application-spree-geniki-taxydromiki', to: 'spree_geniki_taxydromiki/application.js', preload: false

pin_all_from SpreeGenikiTaxydromiki::Engine.root.join('app/javascript/spree_geniki_taxydromiki/controllers'),
  under: 'spree_geniki_taxydromiki/controllers',
  to:    'spree_geniki_taxydromiki/controllers',
  preload: 'application-spree-geniki-taxydromiki'
