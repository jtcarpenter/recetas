class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title

  validates :title, :presence => true
end
