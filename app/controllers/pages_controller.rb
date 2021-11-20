class PagesController < ApplicationController
  def home
    @stock_data = Stock.all
  end
end
