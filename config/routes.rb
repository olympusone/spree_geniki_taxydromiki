Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    post 'geniki_taxydromiki/:order_id/create',   to: 'geniki_taxydromiki#create',   as: :geniki_taxydromiki_create
    get  'geniki_taxydromiki/:order_id/print',    to: 'geniki_taxydromiki#print',    as: :geniki_taxydromiki_print
    post 'geniki_taxydromiki/:order_id/cancel',   to: 'geniki_taxydromiki#cancel',   as: :geniki_taxydromiki_cancel
    post 'geniki_taxydromiki/:order_id/finalize', to: 'geniki_taxydromiki#finalize', as: :geniki_taxydromiki_finalize
  end
end
