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

  def self.simple_search(search)
    q = "%#{search}%"
    where('title LIKE ? OR summary LIKE ? OR content LIKE ? ', q, q, q)
  end

  def self.search(search)
    if DB[:adapter] == 'postgresql'
      q = "%#{search}%"
      where('title LIKE ? OR summary LIKE ? OR content LIKE ? ', q, q, q)
    else
      simple_search(search)
    end
  end
end
