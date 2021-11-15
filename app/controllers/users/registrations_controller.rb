# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
<<<<<<< HEAD
  before_action :configure_account_update_params, only: [:update]

  GET /resource/sign_up
   def new
     super
   end

   POST /resource
   def create
     super
   end

   GET /resource/edit
   def edit
     super
   end

   PUT /resource
   def update
     super
   end

   DELETE /resource
   def destroy
     super
   end
=======
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    # @user = User.new(sign_up_params)
    # if @user.save
    super
    flash[:notice] = 'Your account needs to be approved before you gain complete access. Please wait for the approval.'
    UserMailer.with(user: @user).signup_confirmation.deliver
  end

  private

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end
>>>>>>> 7fe6e65f905875aca8d00e0b3c4cd65f6198b49f

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
<<<<<<< HEAD
   def cancel
     super
   end
=======
  # def cancel
  #   super
  # end
>>>>>>> 7fe6e65f905875aca8d00e0b3c4cd65f6198b49f

  # protected

  # If you have extra params to permit, append them to the sanitizer.
<<<<<<< HEAD
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
   end

  # The path used after sign up.
   def after_sign_up_path_for(resource)
     super(resource)
   end

  # The path used after sign up for inactive accounts.
   def after_inactive_sign_up_path_for(resource)
     super(resource)
   end
=======
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
>>>>>>> 7fe6e65f905875aca8d00e0b3c4cd65f6198b49f
end
