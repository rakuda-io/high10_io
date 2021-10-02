class Holding < ApplicationRecord
  belongs_to :stock

  def attributes
    {'ticker_symbol' => nil, 'quantity' => nil, 'stock_id' => nil}
  end
end
