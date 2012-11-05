class PostsController < ApplicationController

  http_basic_authenticate_with :name => "jason", :password => "B1gD4y"
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.published
  end

  def drafts
    @posts = Post.unpublished
    render action: "index"
  end

  def show
    @post = Post.find(params[:id])
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
      # and validated
      redirect_to @post, notice: t("posts.successfully_updated")
    else
      render action: "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end
end