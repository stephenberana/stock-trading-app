class PagesController < ApplicationController
  def home
  end
  def approvals
    @unapproved_users = User.where(approved: false)
  end
end
