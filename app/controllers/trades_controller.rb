class TradesController < ApplicationController
        # before_action :authenticate_user!
        before_action :setup

        def index
            @trades = Trade.where(user_session)
        end
        
        def new
            @trade = current_user.trades.build
            # @trade.build_stock
        end

        def edit
            @trade = current_user.trades.find(params[:id])
        end

        def update
            client = IEX::Api::Client.new(
                publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
                endpoint: 'https://cloud.iexapis.com/v1'
            )
            stock_price = client.quote(params[:trade][:ticker]).latest_price
            total_price = stock_price * params[:trade][:quantity].to_i

            @trade = current_user.trades.find(params[:id])
            
            if @trade.update(trade_params)
                current_user.balances.create(deposit: total_price)
                redirect_to trades_path, notice: 'Stocks successfully sold.'
            else
                flash[:alert] = "Cannot continue with the transaction. Please check your inputs."
                render :edit
            end
            # #declaring params
            # quantity = params[:trade][:quantity]

            # #start sell transaction
            # if quantity && (quantity <= quantity)
            #     @trade = Trade.update(trade_params)
            #     # Rails.logger.info(@trade.errors.inspect)
            #     if @trade.quantity.instance_of? Integer
            #         @trade.price = stock_price
            #         @trade.purchase_date = DateTime.now
            #         @trade.company_name = company_name
            #         @trade.ticker = company_ticker
            #             begin 
            #             @trade.save!
            #             current_user.balances.create(deposit: total_price)
            #             rescue ActiveRecord::RecordInvalid => invalid
            #             puts invalid.record.errors
            #             byebug
            #             end
            #         flash[:notice] = "Transaction successful!"
            #         redirect_to trades_path
            #     else
            #         flash[:alert] = "Please enter the whole number of shares that you want to sell."
            #         @trade.errors
            #         redirect_to new_trade_path 
            #     end
            # else
            #     flash[:alert] = "You cannot sell what you don't have."
            #     @trade.errors
            #     redirect_to new_trade_path
            # end
        end

        def create
            #getting stock price information
            stock_price = client.quote(params[:trade][:ticker]).latest_price
            total_price = stock_price * params[:trade][:quantity].to_i

            #getting stock company information
            company_name = client.company(params[:trade][:ticker]).company_name
            company_ticker = params[:trade][:ticker]

            #start buy transaction
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
                        puts invalid.record.errors
                        end
                    flash[:notice] = "Transaction successful!"
                    redirect_to trades_path
                    
                else
                    flash[:alert] = "Please enter the whole number of shares that you want to purchase."
                    @trade.errors
                    redirect_to new_trade_path 
                end
            else
                flash[:alert] = "Cannot continue with transaction. Please add more funds to your account."
                @trade.errors
                redirect_to new_trade_path      
            end
        end

        def destroy
            @trade.destroy
            redirect_to trades_path, notice: "Transaction log successfully deleted."
        end
    
        private
    
        def trade_params
           params.require(:trade).permit(:user_id, :quantity, stock_attributes: [:ticker]) 
        end

        def setup
            @balance = Balance.where(user_session).total_balance

            client = IEX::Api::Client.new(
                publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
                endpoint: 'https://cloud.iexapis.com/v1'
            )
        end
end
