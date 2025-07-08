require 'spree_core'
require 'spree_extension'
require 'spree_geniki_taxydromiki/engine'
require 'spree_geniki_taxydromiki/version'
require 'spree_geniki_taxydromiki/configuration'

module SpreeGenikiTaxydromiki
  def self.queue
    'default'
  end
end