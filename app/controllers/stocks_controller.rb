class StocksController < ApplicationController
    before_action :authenticate_user!

    def new
    end

    def index
        @stocks = User.find(current_user.id).stocks.uniq || = nil
        @stock_data = Hash.new

        @stocks.each do |stock|
            quantity = 0
            compatred_to_open = ""
            quote = client.quote(stock.symbol)

            price = quote.latest_price
            open_price = quote.previous_close
            change = quote.change
            change_percent = quote.change_percent_s

            @user.trades.where(stock_id: stock.id).each do |trade|
                quantity = qantity + trade.quantity
            end

            if change > 0
                compared_to_open = "up-since-open"
            elsif change < 0
                compared_to_open = "down-since-open"
            end

            @stock_data[stock.symbol] = [quantity, price, compared_to_open, change_percent]
        end

        @trade = Trade.new(user_id: current_user.id)
        @trade.build_stock
    end

    def create
    end

    private

    def stock_params
        params.require(:stock).permit(:symbol)
    end
end
