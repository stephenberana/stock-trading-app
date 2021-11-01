class ApplicationController < ActionController::Base
    before_action :set_current_user

    def set_current_user
        @user = current_user
    end
end
