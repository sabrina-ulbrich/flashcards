class AddAdminRoleBoolean < ActiveRecord::Migration
  def change
      change_column :users, :is_admin, :boolean
  end
end
