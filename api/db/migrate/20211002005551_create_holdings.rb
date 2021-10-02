class CreateHoldings < ActiveRecord::Migration[6.1]
  def change
    create_table :holdings do |t|
      t.references :stock, null: false, foreign_key: true

      t.float :quantity
      t.float :dividend_amount
      t.float :dividend_rate
      t.float :total_dividend_amount
      t.float :average_dividend_rate

      t.timestamps
    end
  end
end