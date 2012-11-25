class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def new
    if !current_user.admin?
      redirect_to root_url
    end
    @user = User.new
  end

  def create
    if !current_user.admin?
      redirect_to root_url
    else
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "#{ @user.email } #{ t('users.created') }."
        redirect_to users_path
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      render :status => :unauthorized, :text => t("users.edit.unauthorized")
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      render :status => :unauthorized, :text => t("users.edit.unauthorized")
    elsif @user.update_attributes(params[:user])
      redirect_to @user, notice: t("users.successfully_updated")
    else
      render action: "edit"
    end
  end

  def destroy
    if !current_user.admin?
      redirect_to root_url
    else
      @user = User.find(params[:id])
      if @user == current_user
        sign_out @user
      end
      @user.destroy
      redirect_to users_path
    end
  end
end