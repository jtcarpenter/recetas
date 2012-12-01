class CreateRelationshipBetweenUserAndComment < ActiveRecord::Migration
  def up
    #remove_column :comments, :commenter, :string
    add_column :comments, :user_id, :integer
  end

  def down
    #add_column :comments, :commenter, :string
    remove_column :comments, :user_id, :integer
  end
end
