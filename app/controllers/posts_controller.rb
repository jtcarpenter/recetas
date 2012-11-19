class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    args = ["published = ?", true]
    if params[:tag]
      if user_signed_in?
        args = []
      end
      @posts = Post.where(args).tagged_with(params[:tag]).order("updated_at DESC").page(params[:page]).per(2)
    else
      @posts = Post.where(args).order("updated_at DESC").page(params[:page]).per(2)
    end
    render action: "index"
  end

  def drafts
    @posts = Post.where("published = ?", false).order("updated_at DESC").page(params[:page]).per(2)
    render action: "index"
  end

  def show
    @post = Post.find(params[:id])
    if !user_signed_in? && !@post.published
      redirect_to new_user_session_path
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post, notice: t("posts.successfully_created")
    else
      render action: "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post, notice: t("posts.successfully_updated")
    else
      render action: "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy #TODO: causing spec to fail
    redirect_to posts_url
  end
end