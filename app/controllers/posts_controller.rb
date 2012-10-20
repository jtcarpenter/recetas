class PostsController < ApplicationController

  http_basic_authenticate_with :name => "jason", :password => "B1gD4y", :except => [:index, :show]

  def index
    @posts = Post.all
    # this needs to be filtered on publish
    # if clicked on drafts filtered on unpublished
  end

  def drafts
    # if !logged_in redirect
    @posts = Post.all
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
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end
end