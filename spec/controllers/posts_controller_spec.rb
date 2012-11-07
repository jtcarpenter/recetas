require 'spec_helper'

describe PostsController do
  describe 'GET #index' do
    it "populates an array of messages" do
      post = FactoryGirl.create(:post)
      get :index
      assigns(:posts).should eq [post]
    end
    it "renders the :index view"
  end
  describe 'GET #drafts' do
  end
  describe 'GET #show' do
  end
  describe 'GET #new' do
  end
  describe 'GET #edit' do
  end
  describe 'POST #create' do
    context "with valid attributes" do
    end
    context "with invalid attributes" do
    end
  end
  describe 'PUT #update' do
    context "with valid attributes" do
    end
    context "with invalid attributes" do
    end
  end
  describe 'DELETE #destroy' do
    it "deletes the message from the database"
    it "redirects to the homepage"
  end
end