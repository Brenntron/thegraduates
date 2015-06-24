class UsersController < ApplicationController
  before_action :load_user

  def index
    @users = User.search(params[:query]).order("last_name").page(params[:page]).per(PER_PAGE)
  end

  private

  def load_user
    @user = User.find(params[:id]) if params[:id].present?
  end
end
