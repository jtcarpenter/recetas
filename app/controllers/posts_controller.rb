class PostsController < ApplicationController

  http_basic_authenticate_with :name => "jason", :password => "B1gD4y", :except => [:index, :show]

  def index
    @posts = Post.all
    # this needs to be filtered on publish
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
  end

  def update
    @post = Post.new(params[:post])
  end

  def destroy
  end
end