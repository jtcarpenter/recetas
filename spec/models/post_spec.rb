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
  it "returns an array of published results" do
    published1 = FactoryGirl.create(:post, title: "published1")
    published2 = FactoryGirl.create(:post, title: "published2")
    unpublished = FactoryGirl.create(:post, title: "unpublished", published: false)
    Post.published.should eq [published1, published2]
  end
  it "returns an array of unpublished results" do
    published1 = FactoryGirl.create(:post, title: "published1")
    published2 = FactoryGirl.create(:post, title: "published2")
    unpublished = FactoryGirl.create(:post, title: "unpublished", published: false)
    Post.unpublished.should eq [unpublished]
    Post.unpublished.should_not include published1
  end
end