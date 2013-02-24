class Post < ActiveRecord::Base
  attr_accessible :image, :published, :summary, :title, :image_cache, :remove_image, 
                  :tag_list, :user, :ingredients_image, :remove_ingredients_image, 
                  :ingredients_image_cache, :preparation_image, :remove_preparation_image, 
                  :preparation_image_cache, :ingredients, :instructions
  mount_uploader :image, ImageUploader
  mount_uploader :ingredients_image, IngredientsImageUploader
  mount_uploader :preparation_image, PreparationImageUploader
  validates :title, :presence => true
  validates :ingredients, :presence => true, :length => { :minimum => 5 }
  validates :instructions, :presence => true, :length => { :minimum => 5 }
  acts_as_taggable
  has_many  :comments, :dependent => :destroy
  belongs_to :user

  scope :all
  scope :published , where(:published => true)
  scope :unpublished , where(:published => false)
  scope :all_ordered, order("updated_at DESC")
  scope :published_ordered, where(:published => true).order("updated_at DESC")
  scope :unpublished_ordered, where(:published => false).order("updated_at DESC")

  def self.by_user(user)
    where(:user_id => user)
  end

  def self.simple_search(search)
    q = "%#{search}%"
    where('title LIKE ? OR summary LIKE ? OR ingredients LIKE ? OR instructions LIKE ? ', q, q, q, q)
  end

  def self.search(search)
    if ENV['RAILS_ENV'] == 'production' || DB[:adapter] == 'postgresql'
      lang = I18n.t("language_str")
      rank = <<-RANK
        ts_rank(to_tsvector('#{lang}', title), plainto_tsquery('#{lang}', #{sanitize(search)})) +
        ts_rank(to_tsvector('#{lang}', summary), plainto_tsquery('#{lang}', #{sanitize(search)})) +
        ts_rank(to_tsvector('#{lang}', ingredients), plainto_tsquery('#{lang}',#{sanitize(search)})) +
        ts_rank(to_tsvector('#{lang}', instructions), plainto_tsquery('#{lang}',#{sanitize(search)}))
      RANK

      where("
        to_tsvector('#{lang}', title) @@ plainto_tsquery('#{lang}', #{sanitize(search)}) OR
        to_tsvector('#{lang}', summary) @@ plainto_tsquery('#{lang}', #{sanitize(search)}) OR
        to_tsvector('#{lang}', ingredients) @@ plainto_tsquery('#{lang}', #{sanitize(search)}) OR
        to_tsvector('#{lang}', instructions) @@ plainto_tsquery('#{lang}', #{sanitize(search)})
        ").order("#{rank} desc")
    else
      simple_search(search)
    end
  end

  def self.search_tags(search)
    tag_counts.where("tags.name LIKE ?", "%#{search}%")
  end
end
