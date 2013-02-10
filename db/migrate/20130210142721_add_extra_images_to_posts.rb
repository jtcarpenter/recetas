class AddExtraImagesToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :ingredients_image, :string
    add_column :posts, :preparation_image, :string
  end
  def down
    remove_column :posts, :ingredients_image, :string
    remove_column :posts, :preparation_image, :string
  end
end
