class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title, :image_cache, :remove_image, :tag_list
  mount_uploader :image, ImageUploader
  validates :title, :presence => true
  acts_as_taggable

  def self.published
    where("published = ?", true)
  end

  def self.unpublished
    where("published = ?", false)
  end
end
