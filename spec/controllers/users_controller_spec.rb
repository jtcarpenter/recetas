require 'spec_helper'

describe UsersController do
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