class UsersController < ApplicationController
    def market
        @balance = current_user.balances.total_balance
    end
end
