class HoldingSerializer < ActiveModel::Serializer
  belongs_to :stock
  attributes :id, :quantity, :dividend_amount, :dividend_rate, :total_dividend_amount
end
