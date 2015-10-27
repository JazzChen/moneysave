class AddIndexToBidlist < ActiveRecord::Migration
  def change
      add_index :bidlists, :bid_id
      add_index :bidlists, :site_id
      add_index :bidlists, :bid_type
  end
end
