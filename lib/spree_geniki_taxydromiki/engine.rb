module SpreeGenikiTaxydromiki
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_geniki_taxydromiki'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_geniki_taxydromiki.environment', before: :load_config_initializers do |_app|
      SpreeGenikiTaxydromiki::Config = SpreeGenikiTaxydromiki::Configuration.new
    end

    initializer 'spree_geniki_taxydromiki.assets' do |app|
      app.config.assets.paths << root.join('app/javascript')
      app.config.assets.precompile += %w[spree_geniki_taxydromiki_manifest]
    end

    initializer 'spree_geniki_taxydromiki.importmap', after: 'spree.admin.importmap' do |app|
      app.config.spree_admin.importmap.draw(root.join('config/importmap.rb'))

      app.config.spree_admin.cache_sweepers << root.join('app/javascript')
    end

    initializer 'spree_geniki_taxydromiki.cache_sweeper', before: 'spree.admin.importmap.cache_sweeper' do |app|
      app.config.spree_admin.cache_sweepers << root.join('app/javascript')
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
