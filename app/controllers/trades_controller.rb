class TradesController < ApplicationController
    before_action :authenticate_user!

    def index
        @trades = User.find(current_user.id).trades ||= nil
    end

    def create
        stock_price = client.quote(params[:trade][:stock_attributes][:name]).latest_price
        total_price = stock_price * params[:trade][:quantity].to_i

        if @user.balance > total_price
            @trade = Trade.create(trade_params)

        if @trade.valid?
            @trade.purchase_price = stock_price
            @trade.purchase_date = DateTime.now
            @trade.save
            @user.deduct_from_balance(total_price)
            redirect_to user_stocks_path(current_user.id)
        end
    else
        flash[:notice] = "Please enter the whole number of shares that you want to purchase."
        redirect_to user_stocks_path(current_user.id)
    else
        flash[:alert] = "Cannot continue with transaction. Please add more funds to your account."
        redirect_to user_stocks_path(current_user.id)
    end

    def trade_params
       params.require(:trade).permit(:user_id, :quantity, :stock_id, stock_attributes: [:symbol]) 
    end
end
