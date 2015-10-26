class AddBidTypeToBidlist < ActiveRecord::Migration
  def change
    add_column :bidlists, :bid_id, :string
    add_column :bidlists, :bid_type, :string
  end
end
