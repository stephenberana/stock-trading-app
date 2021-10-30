class DashboardController < ApplicationController
    #before_action :is_user_admin?
    before_action :setup_portfolio, only: [:index]

    def index 
    end
end
