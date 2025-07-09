Spree::Core::Engine.add_routes do
  namespace :geniki_taxydromiki do
    post 'create',       to: 'geniki_taxydromiki#create'
    get  ':id/print',    to: 'geniki_taxydromiki#print',   as: :print_voucher
    post ':id/cancel',   to: 'geniki_taxydromiki#cancel',  as: :cancel_voucher
    post ':id/finalize', to: 'geniki_taxydromiki#finalize',  as: :finalize_voucher
  end
end
