class AddAdminRoleBoolean < ActiveRecord::Migration
  def change
      drop_column :users, :is_admin
      add_column :users, is_admin, :boolean
  end
end
