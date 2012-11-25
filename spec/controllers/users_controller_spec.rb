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
    describe 'GET #edit' do
      it "assigns the requested user to @user" do
        get :edit, id: @user
        assigns(:user).should eq @user
      end
      it "renders the :edit template" do
        get :edit, id: @current_user
        response.should render_template :edit
      end
      it "prevents editing of other users profiles" do
        get :edit, id: @signed_out_user
        response.response_code.should == 401
      end
    end
    describe 'PUT #update' do
      before :each do
        @user = create(:user)
      end
      context "with valid attributes" do
        it "located the requested @user" do
          put :update, id: @user, user: attributes_for(:user)
          assigns(:user).should eq(@user)
        end
        it "prevents updating of other users profiles" do
          put :update, id: @signed_out_user, user: attributes_for(:user)
          response.response_code.should == 401
        end
        it "changes @users's attributes"
        it "redirects to the updated user"
      end
      context "with invalid attributes" do
        it "does not change @user's attributes"
        it "re-renders the edit method"
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
          response.should redirect_to users_path
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
      @current_user = @user
      @signed_out_user = @admin
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
      @current_user = @admin
      @signed_out_user = @user
    end
    it_behaves_like "signed in access to users"
    it_behaves_like "admin access to users"
  end
end