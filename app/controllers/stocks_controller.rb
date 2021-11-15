class StocksController < ApplicationController
    before_action :authenticate_user!
    before_action :setup
    
    def new
        @trade = Trade.new(user_id: current_user.id)
        @trade.build_stock
    end

    def index
        @stocks = User.find(current_user.id).stocks.uniq ||=nil
        @stock_data = Hash.new

        @stocks.each do |stock|
            quantity = 0
            compared_to_open = ""
            quote = client.quote(stock.ticker)

            price = quote.latest_price
            open_price = quote.previous_close
            change = quote.change
            change_percent = quote.change_percent_s

            @user.trades.where(stock_id: stock.id).each do |trade|
                quantity = quantity + trade.quantity
            end

            if change > 0
                compared_to_open = "up-since-open"
            elsif change < 0
                compared_to_open = "down-since-open"
            end

            @stock_data[stock.ticker] = [quantity, price, compared_to_open, change_percent]
        end
    end

    private

    def stock_params
        params.require(:stock).permit(:ticker)
    end

    def setup
        @client = IEX::Api::Client.new(
            publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
            endpoint: 'https://sandbox.iexapis.com/v1'
        )

        @balance = Balance.where(user_session).total_balance
        # @balance = current_user.balance.total_balance
    end
end
