class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title, :image_cache, :remove_image, :tag_list, :content, :user
  mount_uploader :image, ImageUploader
  validates :title, :presence => true
  validates :content, :presence => true, :length => { :minimum => 5 }
  acts_as_taggable
  has_many  :comments, :dependent => :destroy
  belongs_to :user

  def self.published
    where("published = ?", true)
  end

  def self.unpublished
    where("published = ?", false)
  end
end
