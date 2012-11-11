require 'spec_helper'

describe PostsController do

  shared_examples("public access to posts") do
    describe 'GET #index' do
      it "populates an array of posts" do
        get :index
        assigns(:posts).should eq [@post]
      end
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  end

  shared_examples("signed in access to posts") do
    describe 'GET #drafts' do
      it "populates an array of draft posts if singed in" do
        draft_post = create(:post, published: false)
        get :drafts
        assigns(:posts).should eq [draft_post]
      end
      it "renders the :index template" do
        get :drafts
        response.should render_template :index
      end
    end
    describe 'GET #show' do
      it "assigns the requested draft post to draft" do
        draft = create(:post, published: false)
        get :show, id: draft
        assigns(:post).should eq draft
      end
      it "renders the :show template" do
        draft = create(:post, published: false)
        get :show, id: draft
        response.should render_template :show
      end
    end
    describe 'GET #new' do
      it "assigns a new post to @post" do
        get :new
        assigns(:post).should be_a_new(Post)
      end
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    describe 'GET #edit' do
      it "assigns the requested post to @post" do
        get :edit, id: @post
        assigns(:post).should eq @post
      end
      it "renders the :edit template" do
        get :edit, id: @post
        response.should render_template :edit
      end
    end
    describe 'POST #create' do
      context "with valid attributes" do
        it "creates a new contact" do
          expect {
            post :create, post: attributes_for(:post)
          }.to change(Post,:count).by(1)
        end
        it "redirects to the home page" do
          post :create, post: attributes_for(:post)
          response.should redirect_to Post.last
        end
      end
      context "with invalid attributes" do
        it "does not save the new post" do
          expect {
            post :create, post: attributes_for(:invalid_post)
          }.to_not change(Post, :count)
        end
        it "re-renders the :new template" do
          post :create, post: attributes_for(:invalid_post)
          response.should render_template :new
        end
      end
    end
    describe 'PUT #update' do
      before :each do
        @post = create(:post, title: "update test")
      end
      context "with valid attributes" do
        it "located the requested @post" do
          put :update, id: @post, post: attributes_for(:post)
          assigns(:post).should eq(@post)
        end
        it "changes @post's attributes" do
          put :update, id: @post, post: attributes_for(:post, title: "title")
          @post.reload
          @post.title.should eq("title")
        end
        it "redirects to the updated post" do
          put :update, id: @post, post: attributes_for(:post)
          response.should redirect_to :post
        end
      end
      context "with invalid attributes" do
        it "does not change @post's attributes" do
          put :update, id: @post, post: attributes_for(:post, title: nil)
          @post.reload
          @post.title.should eq("update test")
        end
        it "re-renders the edit method" do
          put :update, id: @post, post: attributes_for(:invalid_post)
          response.should render_template :edit
        end
      end
    end
    describe 'DELETE #destroy' do
      it "deletes the post from the database" do
        expect {
          delete :destroy, id: @post
        }.to change(Post,:count).by(-1)
      end
      it "redirects to the posts#index" do
        delete :destroy, id: @post
        response.should redirect_to posts_url
      end
    end
  end

  describe "guest access" do
    before do
      @post = create(:post)
    end
    it_behaves_like "public access to posts"
    describe 'GET #show' do
      it "assigns the requested post to @post" do
        get :show, id: @post
        assigns(:post).should eq @post
      end
      it "renders the :show template" do
        get :show, id: @post
        response.should render_template :show
      end
      it "redirects when trying to access draft post while not signed in" do
        draft = create(:post, published: false)
        get :show, id: draft
        response.should redirect_to(new_user_session_path)
      end
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
        response.should require_login
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
    before :each do
      @post = create(:post)
      @user = create(:user)
      sign_in :user, @user
    end
    it_behaves_like "public access to posts"
    it_behaves_like "signed in access to posts"
  end
end