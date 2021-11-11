class ApplicationController < ActionController::Base
    require 'iex-ruby-client'

    # before_action :require_signin
    before_action :set_current_user
    rescue_from IEX::Errors::SymbolNotFoundError, with: :no_symbol_error
    rescue_from Faraday::ConnectionFailed, with: :no_connection_error

private
    def no_symbol_error
        flash[:alert] = "Please enter a valid stock ticker."
        redirect_to new_stock_path
    end

    def no_connection_error
        flash[:alert] = "Unable to connect. Please check your internet connection and try again."
        redirect_to user_stocks_path(current_user.id)
    end

    def require_signin
        unless signed_in?
            flash[:notice] = "Please log in."
            redirect_to root_path
        end
    end

    def set_current_user
        @user = current_user
    end
end
