class RemovePostIdAndAddPolymorphicAssociationToComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :post_id
    add_column :comments, :commentable_id, :integer
    add_column :comments, :commentable_type, :string
  end
end
