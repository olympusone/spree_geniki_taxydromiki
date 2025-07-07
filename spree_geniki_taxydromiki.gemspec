# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_geniki_taxydromiki/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_geniki_taxydromiki'
  s.version     = SpreeGenikiTaxydromiki::VERSION
  s.summary     = 'Spree Commerce Geniki Taxydromiki Extension'
  s.description = 'Adds the ability to manage Geniki Taxydromiki courier vouchers to Spree stores.'

  s.required_ruby_version = '>= 3.0'

  s.author    = 'OlympusOne'
  s.email     = 'info@olympusone.com'
  s.homepage  = 'https://github.com/olympusone/spree_geniki_taxydromiki'
  s.license   = 'MIT'

  s.metadata = {
    "bug_tracker_uri"   => "#{s.homepage}/issues",
    "changelog_uri"     => "#{s.homepage}/releases/tag/v#{s.version}",
    "documentation_uri" => s.homepage,
    "homepage_uri"      => s.homepage,
    "source_code_uri"   => "#{s.homepage}/tree/v#{s.version}",
  }

  s.files        = Dir["{app,config,db,lib,vendor}/**/*", "LICENSE.md", "Rakefile", "README.md"].reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 5.0.4'
  s.add_dependency 'spree', spree_version
  s.add_dependency 'spree_storefront', spree_version
  s.add_dependency 'spree_admin', spree_version
  s.add_dependency 'spree_extension'
  
  s.add_dependency 'importmap-rails'
  s.add_dependency 'savon', '~> 2.15'

  s.add_development_dependency 'spree_dev_tools'
  s.add_development_dependency 'dotenv'
end
