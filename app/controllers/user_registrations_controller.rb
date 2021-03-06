class UserRegistrationsController < ApplicationController
  before_action :load_user, except: [:edit, :update]

  def edit
    if !current_user
      redirect_to root_path
    else
      @user = current_user
    end
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)
    if @user.save
      redirect_to user_path(@user)
      flash.notice = "Your profile has been updated."
    else
      flash.alert = "Please fix the errors to continue."
      render :edit
    end
  end

  def create
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: "Welcome, #{@user.first_name}!"
    else
      flash.alert = "Please fix the errors to continue."
      render :new
    end
  end

    protected

  def load_user
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = User.new
    end
    if params[:user].present?
      @user.assign_attributes(user_params)
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :linkedin, :twitter, :bio, :password, :password_confirmation, :current_employer, :graduation_date, :cohort)
  end
end
