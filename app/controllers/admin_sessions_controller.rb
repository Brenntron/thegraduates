class AdminSessionsController < ApplicationController
  before_action :require_login
  def create
    if @admin = login(params[:admin][:email], params[:admin][:password])
      redirect_to rails_admin
    else
      flash.alert = "You are not an admin."
    end
  end

  def destroy
    logout
    redirect_to rails_admin
  end

  def new
    @admin = Admin.new
  end
end
