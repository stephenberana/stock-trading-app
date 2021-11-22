class Admin::UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy approve ]
    before_action :allow_without_password, only: [:update]
    before_action :check_if_admin
  

    def index
      @users = User.all
      @unapproved_users = User.where(approved: false)
    end
  

    def show
    end
  

    def new
      @user = User.new
    end
  

    def edit
    end
  

    def create
      @user = User.new(user_params)
      @user.approved = true
  
      respond_to do |format|
        if @user.save        
          flash[:notice] = "User was successfully created."
          format.html { redirect_to admin_user_url(@user) }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  

    def update    
      respond_to do |format|
        if @user.update(user_params)
          flash[:notice] = "User was successfully updated."
          format.html { redirect_to admin_user_url(@user) }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  

    def approve
      if @user.update(user_params)
        flash[:notice] = "#{@user.email} was successfully approved."
        redirect_to admin_approvals_path
      else
        flash[:alert] = "Something went wrong."
        render admin_approvals_path
      end
    end
  

    def destroy
      @user.destroy
      respond_to do |format|
        flash[:alert] = "User was successfully destroyed."
        format.html { redirect_to admin_users_url }
        format.json { head :no_content }
      end
    end

    private

      def set_user
        @user = User.find(params[:id])
      end
  

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :approved)
      end
  
      def allow_without_password
        if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
        end
      end
  
      def check_if_admin
        flash[:alert] = 'This page is only  accessible by admins'
        redirect_to root_path unless current_user.is_Admin?
    end
  end