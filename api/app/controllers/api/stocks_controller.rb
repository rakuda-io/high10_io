module Api
  class StocksController < ApplicationController
    before_action :authenticate_api_user!, except: [:index, :show]

    def index
      stocks = Stock.all
      render json: stocks
    end

    def show
      stock = Stock.find(params[:id])
      render json: stock
    end

  end
end