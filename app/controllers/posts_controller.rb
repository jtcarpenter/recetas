class PostsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :set_per_page

  def set_per_page
    @per_page = 5
  end

  def tags
    if (params[:q].strip.length != 0)
      @tags = Post.search_tags(params[:q])
    else
      @tags = [];
    end
    respond_to do |format|
      format.json { render :json => @tags.map(&:attributes) }
    end
  end

  def index
    if params[:search]
      if user_signed_in?
        @posts = Post.all.search(params[:search]).page(params[:page]).per(@per_page)
      else
        @posts = Post.published.search(params[:search]).page(params[:page]).per(@per_page)
      end
    elsif params[:user]
      if user_signed_in?
        @posts = Post.all_ordered.by_user(params[:user]).page(params[:page]).per(@per_page)
      else
        @posts = Post.published_ordered.by_user(params[:user]).page(params[:page]).per(@per_page)
      end
    elsif params[:tag]
      if user_signed_in?
        @posts = Post.all_ordered.tagged_with(params[:tag]).page(params[:page]).per(@per_page)
      else
        @posts = Post.published_ordered.tagged_with(params[:tag]).page(params[:page]).per(@per_page)
      end
    else
      if user_signed_in?
        @posts = Post.all_ordered.page(params[:page]).per(@per_page)
      else
        @posts = Post.published_ordered .page(params[:page]).per(@per_page)
      end
    end
  end

  def drafts
    @posts = Post.unpublished_ordered.page(params[:page]).per(@per_page)
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
    if @post.user != current_user
      render :status => :unauthorized, :text => t("posts.edit.unauthorized")
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: t("posts.successfully_created")
    else
      render action: "new"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.user != current_user
      render :status => :unauthorized, :text => t("posts.edit.unauthorized")
    elsif @post.update_attributes(params[:post])
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