class SeedAdminPw < ActiveRecord::Migration
  def up
    sabrina = User.where(:name => "Sabrina").first
    sabrina.is_admin = true
    sabrina.save
  end

  def down
  end
end
