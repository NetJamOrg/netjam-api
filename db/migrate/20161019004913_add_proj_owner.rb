class AddProjOwner < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :owner_id, :integer
    add_foreign_key :projects, :users, column: :owner_id
  end
end
