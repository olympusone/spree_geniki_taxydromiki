module Spree
  module ShipmentDecorator
    # TODO: remove this method when the Spree version implementing this method
    # Returns the total quantity of all line items in the shipment
    def item_quantity
      manifest.map { |m| m.line_item.quantity }.sum
    end
  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator
