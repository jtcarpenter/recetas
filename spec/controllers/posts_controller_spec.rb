require 'spec_helper'

describe PostsController do
  describe 'GET #index' do
    it "populates an array of posts" do
      post = create(:post)
      get :index
      assigns(:posts).should eq [post]
    end
    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end
  describe 'GET #drafts' do
    it "populates an array of draft posts if singed in"
    it "redirects if not signed in"
  end
  describe 'GET #show' do
    it "assigns the requested post to @post" do
      post = create(:post)
      get :show, id: post
      assigns(:post).should eq post
    end
    it "renders the :show template" do
      post = create(:post)
      get :show, id: post
      response.should render_template :show
    end
    it "assigns the requested draft post to @post if signed in"
    it "redirects when trying to access draft post while not signed in"
  end
  describe 'GET #new' do
    it "assigns a new post to @post"
    it "renders the :new template"
  end
  describe 'GET #edit' do
    it "assigns the requested post to @post"
    it "renders the :edit template"
  end
  describe 'POST #create' do
    context "with valid attributes" do
      it "saves the new post in the database"
      it "redirects to the home page"
    end
    context "with invalid attributes" do
      it "does not save the new post in the database"
      it "re-renders the :new template"
    end
  end
  describe 'PUT #update' do
    before :each do
      @post = create(:post, title: "update test")
    end
    it "locates the requested @post"
    context "with valid attributes" do
      it "changes @post's attributes"
      it "redirects to the updated post"
    end
    context "with invalid attributes" do
      it "does not change @post's attributes"
      it "re-renders the edit method"
    end
  end
  describe 'DELETE #destroy' do
    it "deletes the post from the database"
    it "redirects to the homepage"
  end
end