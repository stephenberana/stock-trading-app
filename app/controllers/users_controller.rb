class UsersController < ApplicationController
    def market
        @balance = current_user.balances
    end
end
