class SortUserIdColumnToHoldings < ActiveRecord::Migration[6.1]
  def change
    change_column :holdings, :user_id, :bigint, after: :stock_id
  end
end
