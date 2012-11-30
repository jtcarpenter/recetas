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

  def self.search(search)
    if search
      #find(:all, :conditions => ['title LIKE ? OR summary LIKE ? OR content LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%" ])
      #q = "%#{params[:query]}%"
      #User.where("name like ? or description like ?", q, q).to_sql
      where('title LIKE ? OR summary LIKE ? OR content LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      find(:all)
    end
  end
end
