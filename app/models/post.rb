class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title, :image_cache, :remove_image, :tag_list, :content, :user
  mount_uploader :image, ImageUploader
  validates :title, :presence => true
  validates :content, :presence => true, :length => { :minimum => 5 }
  acts_as_taggable
  has_many  :comments, :dependent => :destroy
  belongs_to :user

  scope :all, order("updated_at DESC")
  scope :published, where(:published => true).order("updated_at DESC")
  scope :unpublished, where(:published => false).order("updated_at DESC")
end
