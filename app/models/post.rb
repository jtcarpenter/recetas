class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title, :image_cache, :remove_image
  mount_uploader :image, ImageUploader
  validates :title, :presence => true

  def self.published
    where("published = ?", true)
  end

  def self.unpublished
    where("published = ?", false)
  end
end
