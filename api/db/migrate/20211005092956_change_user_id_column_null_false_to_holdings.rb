class ChangeUserIdColumnNullFalseToHoldings < ActiveRecord::Migration[6.1]
  def up
    change_column :holdings, :user_id, :bigint, null: false
  end

  def down
    change_column :holdings, :user_id, :bigint
  end
end
