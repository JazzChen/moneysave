class CreateBidlists < ActiveRecord::Migration
  def change
    create_table :bidlists do |t|
      t.integer :site_id, null: false
      t.string :name, null: false
      t.decimal :bid_amount, null: false
      t.timestamp :bid_open_at
      t.timestamp :bid_closed_at
      t.decimal :remaining_amount
      t.string :tenor, null: false
      t.decimal :interest_rate, null: false
      t.string :repayment_method
      t.decimal :min_invest_amount
      t.decimal :max_invest_amount
      t.string :url_address
      t.integer :risk_level

      t.timestamps null: false
    end
  end
end
