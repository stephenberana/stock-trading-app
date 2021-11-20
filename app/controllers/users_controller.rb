class UsersController < ApplicationController
    def market
        @balance = Balance.where(user_session).total_balance
    end
end
