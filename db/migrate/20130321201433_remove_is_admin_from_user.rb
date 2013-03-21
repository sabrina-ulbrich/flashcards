class RemoveIsAdminFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :is_admin
     add_column :users, :is_admin, :Boolean
  end

  def down
  end
end
