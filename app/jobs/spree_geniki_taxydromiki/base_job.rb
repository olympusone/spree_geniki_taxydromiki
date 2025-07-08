module SpreeGenikiTaxydromiki
  class BaseJob < Spree::BaseJob
    queue_as SpreeGenikiTaxydromiki.queue
  end
end
