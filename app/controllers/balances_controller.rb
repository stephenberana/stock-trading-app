class BalancesController < ApplicationController
    before_action :setup_balance
    before_action :balance_config, only: %i[deposit withdraw]

    def deposit
    end

    def withdraw
    end

    def create
        @balance = Balance.new(balance_params)
        @balance.user = current_user

        if @balance.save
            flash[:notice] = "Your balance has been updated."
            redirect_to root_path
        else
            flash[:alert] = "Input invalid."
            render :new
        end
    end

    def show
    end

    private

    def setup_balance
        # @balance = Balance.find_by(id: params[:user_id])
        @balance = Balance.find_by(params[:user_id])
        # @balance = current_user.balance
    end

    def balance_config
        @deposit = Balance.new
        @withdraw = Balance.new
        # @balance = current_user.balance.total_balance
        @balance.inspect
        # @balance.user = current_user
    end

    def balance_params
        params.require(:balance).permit(:deposit, :withdrawals)
    end
end
