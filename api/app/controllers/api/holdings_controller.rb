module Api
  class HoldingsController < ApplicationController
    def index
      holding = Holding.all
      ticker = holding.map do |h|
        h.stock.ticker_symbol
      end
      render json: ticker
    end
  end
end