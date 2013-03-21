class SeedAdmin < ActiveRecord::Migration
   def self.up
    User.new(:name => "admin", :is_admin => true)
  end
  def self.down
    User.delete_all(:name => "admin")
  end
end
