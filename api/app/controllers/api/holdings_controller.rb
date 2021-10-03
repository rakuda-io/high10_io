module Api
  class HoldingsController < ApplicationController
    #最終的に毎回スクレイピングしなくていいようにリファクタリング予定
    def index
      agent = Mechanize.new
      holdings = Holding.all
      holdings.map { |holding|
        individual_page = agent.get(holding.stock.url)
        current_div_amount = individual_page.search("td")[106].text.to_f
        current_div_rate = individual_page.search("td")[118].text.to_f
        holding.update(
          dividend_amount: current_div_amount,
          dividend_rate: current_div_rate,
          total_dividend_amount: current_div_amount * holding.quantity,
        )
      }
      render json: holdings.order(total_dividend_amount: :desc)
    end


  end
end