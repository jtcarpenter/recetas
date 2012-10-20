class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.boolean :published
      t.text :summary
      t.string :image

      t.timestamps
    end
  end
end
