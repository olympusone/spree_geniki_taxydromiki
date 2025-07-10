class AddShipmentJobId < ActiveRecord::Migration[8.0]
  def change
    add_column :spree_shipments, :job_id, :bigint, if_not_exists: true
    add_column :spree_shipments, :job_finalized_at, :datetime, if_not_exists: true
    add_column :spree_shipments, :job_canceled_at, :datetime, if_not_exists: true

    add_index :spree_shipments, :job_id, unique: true, if_not_exists: true
  end
end
