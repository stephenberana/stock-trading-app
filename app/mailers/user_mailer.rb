class UserMailer < ApplicationMailer
  default from: "admin@mystonks.com"

  def signup_confirmation(user)
    @user = params[:user]
    mail to: user.email, subject: "Sign-up confirmation"
  end

  def signup_confirmed(user)
    @user = params[:user]
    mail to: @user.email, subject: "Account approved!"
  end
end
