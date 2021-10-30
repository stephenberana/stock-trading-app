class ApplicationController < ActionController::Base
    before_action :setup
    before_action :set_current_user

    def set_current_user
        @user = current_user
    end

    def setup
        @client = IEX::API::Client.new(
            publishable_token: 'pk_92611ab063e242c8b3ccbed009db8f65', 
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
    end
end
