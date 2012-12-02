class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title, :image_cache, :remove_image, :tag_list, :content, :user
  mount_uploader :image, ImageUploader
  validates :title, :presence => true
  validates :content, :presence => true, :length => { :minimum => 5 }
  acts_as_taggable
  has_many  :comments, :dependent => :destroy
  belongs_to :user

  scope :all
  scope :published , where(:published => true)
  scope :unpublished , where(:published => false)
  scope :all_ordered, order("updated_at DESC")
  scope :published_ordered, where(:published => true).order("updated_at DESC")
  scope :unpublished_ordered, where(:published => false).order("updated_at DESC")

  def self.simple_search(search)
    q = "%#{search}%"
    where('title LIKE ? OR summary LIKE ? OR content LIKE ? ', q, q, q)
  end

  def self.search(search)
    lang = I18n.t("language_str")
    if ENV['RAILS_ENV'] == 'production' || DB[:adapter] == 'postgresql'
      rank = <<-RANK
        ts_rank(to_tsvector('#{lang}', title), plainto_tsquery('#{lang}', #{sanitize(search)})) +
        ts_rank(to_tsvector('#{lang}', summary), plainto_tsquery('#{lang}', #{sanitize(search)})) +
        ts_rank(to_tsvector('#{lang}', content), plainto_tsquery('#{lang}',#{sanitize(search)}))
      RANK

      where("
        to_tsvector('#{lang}', title) @@ plainto_tsquery('#{lang}', #{sanitize(search)}) OR
        to_tsvector('#{lang}', summary) @@ plainto_tsquery('#{lang}', #{sanitize(search)}) OR
        to_tsvector('#{lang}', content) @@ plainto_tsquery('#{lang}', #{sanitize(search)})
        ").order("#{rank} desc")
    else
      simple_search(search)
    end
  end
end
