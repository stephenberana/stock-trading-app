class PagesController < ApplicationController
  def home
    @stock = Stock.where(user_session)
  end
end
