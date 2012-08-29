class Users2CardSets < ActiveRecord::Migration
 def up
  create_table :card_sets_users, :id => false do |t|
    t.references :card_set, :null => false
    t.references :user, :null => false
  end

  # Adding the index can massively speed up join tables. Don't use the
  # unique if you allow duplicates.
  add_index(:card_sets_users, [:card_set_id, :user_id], :unique => false)
end

  def down
    drop_table :cards_set_users
  end
end
