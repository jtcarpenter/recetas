require 'spec_helper'

describe PostsController do
  describe "guest access" do
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
    describe 'GET #drafts' do
      it "requires sign in" do
        get :drafts
        response.should redirect_to(new_user_session_path)
      end
    end
    describe 'GET #new' do
      it "requires sign in" do
        get :new
        response.should redirect_to(new_user_session_path)
      end
    end
    describe 'GET #edit' do
      it "requires sign in" do
        get :edit, id:  create(:post)
        response.should redirect_to(new_user_session_path)
      end
    end
    describe 'POST #create' do
      it "requires sign in" do
        post :create, id: create(:post), post: attributes_for(:post)
        response.should redirect_to(new_user_session_path)
      end
    end
    describe 'PUT #update' do
      it "requires sign in" do
        put :update, id: create(:post), post: attributes_for(:post)
        response.should redirect_to(new_user_session_path)
      end
    end
    describe 'DELETE #destroy' do
      it "requires sign in" do
        delete :destroy, id: create(:post)
        response.should redirect_to(new_user_session_path)
      end
    end
  end

  describe "signed in access" do
    describe 'GET #drafts' do
      it "populates an array of draft posts if singed in"
      it "renders the :index template"
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
end