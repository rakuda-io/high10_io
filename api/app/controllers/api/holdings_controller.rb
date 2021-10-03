module Api
  class HoldingsController < ApplicationController
    before_action :authenticate_user!

    #最終的に毎回スクレイピングしなくていいようにリファクタリング予定
    def index
      holdings = Holding.order(total_dividend_amount: :desc)
      render json: holdings
    end

    #今後、決まったタイミングでのみ更新に変更する為に一時的に切り出し
    def get_current_dividend
      agent = Mechanize.new
      holdings = Holding.all
      holdings.map { |holding|
        individual_page = agent.get(holding.stock.url)
        current_div_amount = individual_page.search("td")[106].text.to_f
        current_div_rate = individual_page.search("td")[118].text.to_f
        holding.update(
          dividend_amount: current_div_amount,
          dividend_: current_div_rate,
          total_dividend_amount: current_div_amount * holding.quantity,
        )
      }
    end
  end
end