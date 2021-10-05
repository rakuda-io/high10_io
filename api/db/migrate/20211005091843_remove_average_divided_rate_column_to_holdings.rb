class RemoveAverageDividedRateColumnToHoldings < ActiveRecord::Migration[6.1]
  def up
    remove_column :holdings, :average_dividend_rate
  end

  def down
    add_column :holdings, :average_dividend_rate
  end
end
