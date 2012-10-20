class PostsController < ApplicationController

  http_basic_authenticate_with :name => "jason", :password => "B1gD4y", :except => [:index, :show]

  def index
    @posts = Post.all
    # this needs to be filtered on publish
  end

  def show
    @post = Post.find(params[:id])
  end
end