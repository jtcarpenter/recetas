class UsersController < ApplicationController

  http_basic_authenticate_with :name => "jason", :password => "B1gD4y"
  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      sign_out @user
    end
    @user.destroy
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "#{ @user.email } #{ t('users.created') }."
      redirect_to users_path
    else
      render :action => 'new'
    end
  end
end