module Api
  class HoldingsController < ApplicationController
    def index
      holding = Holding.all
      render json: holding
    end
  end
end