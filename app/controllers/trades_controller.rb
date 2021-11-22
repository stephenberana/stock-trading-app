class TradesController < ApplicationController
        # before_action :authenticate_user!
        before_action :setup
        # around_action :deduct_from_balance, only: [:create]
        
        def index
            # @trades = current_user.trades ||= nil
            @trades = Trade.where(user_session)

        end
        
        def new
            @trade = current_user.trades.build
            # @trade.build_stock
        end

        def update
        end

        def create
            client = IEX::Api::Client.new(
                publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
                endpoint: 'https://cloud.iexapis.com/v1'
            )

            #getting stock price information
            stock_price = client.quote(params[:trade][:ticker]).latest_price
            total_price = stock_price * params[:trade][:quantity].to_i

            #getting stock company information
            company_name = client.company(params[:trade][:ticker]).company_name
            company_ticker = params[:trade][:ticker]

            #start transaction
            if @balance && (@balance > total_price)
                @trade = Trade.create(trade_params)
                Rails.logger.info(@trade.errors.inspect)
                if @trade.quantity.instance_of? Integer
                    @trade.price = stock_price
                    @trade.purchase_date = DateTime.now
                    @trade.company_name = company_name
                    @trade.ticker = company_ticker
                        begin 
                        @trade.save!
                        current_user.balances.create(withdrawals: total_price)
                        rescue ActiveRecord::RecordInvalid => invalid
                        # puts invalid.record.errors
                        byebug
                        end
                    flash[:notice] = "Transaction successful!"
                    redirect_to trades_path
                    
                else
                    flash[:alert] = "Please enter the whole number of shares that you want to purchase."
                    @trade.errors
                    redirect_to new_trade_path
                    # Rails.logger.info(params[:trade])  
                end
            else
                byebug
                flash[:alert] = "Cannot continue with transaction. Please add more funds to your account."
                @trade.errors
                redirect_to new_trade_path
                # Rails.logger.info(params[:trade])            
            end
        end
    
        private
    
        def trade_params
           params.require(:trade).permit(:user_id, :quantity, stock_attributes: [:ticker]) 
        end

        def setup
            # @balance = Balance.find(current_user.id).deposit
            # @balance = current_user.balance.total_balance
            @balance = Balance.where(user_session).total_balance
        end
end
