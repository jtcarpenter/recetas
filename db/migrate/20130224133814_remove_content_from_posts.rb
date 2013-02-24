class RemoveContentFromPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :content, :text
  end

  def down
    add_column :posts, :content, :text
  end
end
