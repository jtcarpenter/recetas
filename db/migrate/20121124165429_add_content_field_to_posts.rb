class AddContentFieldToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :content, :text
  end
  def down
    remove_column :posts, :content, :text
  end
end
