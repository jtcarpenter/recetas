require 'spec_helper'

describe Post do
  it "has a valid factory" do
    FactoryGirl.create(:post).should be_valid
  end
  it "is invalid without a title" do
    FactoryGirl.build(:post, title: nil).should_not be_valid
  end
  it "returns a posts's title as a string" do
    FactoryGirl.create(:post, title: "test title").title.should eq "test title"
  end
end