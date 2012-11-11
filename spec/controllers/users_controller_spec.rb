require 'spec_helper'

describe UsersController do

  shared_examples("signed in access to users") do
    describe 'GET #index' do
      it "populates an array of users" do
        get :index
        assigns(:users).should eq [@user, @admin]
      end
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end
  end

  shared_examples("admin access to users") do
    describe 'GET #new' do
      it "assigns a new user to @user" do
        get :new
        assigns(:user).should be_a_new(User)
      end
      it "renders the :new template" do
        get :new
        response.should render_template :new
      end
    end
    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the new user in the database" do
          expect {
            post :create, user: attributes_for(:user)
          }.to change(User,:count).by(1)
        end
        it "redirects to the users page" do
          post :create, user: attributes_for(:user)
          response.should redirect_to User.last
        end
      end
      context "with invalid attributes" do
        it "does not save the new user in the database" do
          expect {
            post :create, user: attributes_for(:invalid_user)
          }.to_not change(User, :count)
        end
        it "re-renders the :new template" do
          post :create, user: attributes_for(:invalid_user)
          response.should render_template :new
        end
      end
    end
    describe 'DELETE #destroy' do
      it "deletes the user from the database" do
        expect {
          delete :destroy, id: @user
        }.to change(User,:count).by(-1)
      end
      it "redirects to the homepage" do
        delete :destroy, id: @user
        response.should redirect_to users_url
      end
    end
  end

  describe "guest access" do
    describe 'GET #index' do
      it "requires sign in" do
        get :index
        response.should require_login
      end
    end
    describe 'GET #new' do
      it "requires sign in" do
        get :new
        response.should require_login
      end
    end
    describe 'POST #create' do
      it "requires sign in" do
        post :create, id: create(:user), user: attributes_for(:user)
        response.should require_login
      end
    end
    describe 'DELETE #destroy' do
      it "requires sign in" do
        delete :destroy, id: create(:user)
        response.should require_login
      end
    end
  end

  describe "signed in access" do
    before :each do
      @user = create(:user)
      @admin = create(:admin)
      sign_in :user, @user
    end
    it_behaves_like "signed in access to users"
    describe 'GET #new' do
      it "requires admin access" do
        get :new
        response.should redirect_to root_url
      end
    end
    describe 'POST #create' do
      it "requires admin access" do
        post :create, id: create(:user), user: attributes_for(:user)
        response.should redirect_to root_url
      end
    end
    describe 'DELETE #destroy' do
      it "requires admin access" do
        delete :destroy, id: create(:user)
        response.should redirect_to root_url
      end
    end
  end

  describe "admin access" do
    before do
      @user = create(:user)
      @admin = create(:admin)
      sign_in :user, @admin
    end
    it_behaves_like "signed in access to users"
    it_behaves_like "admin access to users"
  end
end