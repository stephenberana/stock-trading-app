class PagesController < ApplicationController
  def home
    @stock = Stock.where(user_session)
  end
  def approvals
    @unapproved_users = User.where(approved: false)
  end
end
