class UpdatePosts < ActiveRecord::Migration
  def up
    add_column :posts, :ingredients, :text
    add_column :posts, :instructions, :text
  end

  def down
    remove_column :posts, :ingredients, :text
    remove_column :posts, :instructions, :text
  end
end
