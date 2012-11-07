require 'spec_helper'

describe UsersController do
  describe "guest access" do
    describe 'GET #index' do
      it "requires sign in"
    end
    describe 'GET #new' do
      it "requires sign in"
    end
    describe 'POST #create' do
      it "requires sign in"
    end
    describe 'DELETE #destroy' do
      it "requires sign in"
    end
  end

  describe "signed in access" do
    describe 'GET #index' do
      it "populates an array of users"
      it "renders the :index view"
    end
    describe 'GET #new' do
      it "requires admin access"
    end
    describe 'POST #create' do
      it "requires admin access"
    end
    describe 'DELETE #destroy' do
      it "requires admin access"
    end
  end

  describe "admin access" do
    describe 'GET #index' do
      it "populates an array of users"
      it "renders the :index view"
    end
    describe 'GET #new' do
      it "assigns a new user to @user"
      it "renders the :new template"
    end
    describe 'POST #create' do
      context "with valid attributes" do
        it "saves the new user in the database"
        it "redirects to the home page"
      end
      context "with invalid attributes" do
        it "does not save the new user in the database"
        it "re-renders the :new template"
      end
    end
    describe 'DELETE #destroy' do
      it "deletes the user from the database"
      it "redirects to the homepage"
    end
  end
end