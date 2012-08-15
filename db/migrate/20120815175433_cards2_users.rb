class Cards2Users < ActiveRecord::Migration
  def up
  create_table :cards_users, :id => false do |t|
    t.references :card, :null => false
    t.references :user, :null => false
  end

  # Adding the index can massively speed up join tables. Don't use the
  # unique if you allow duplicates.
  add_index(:cards_users, [:card_id, :user_id], :unique => false)
end

  def down
    drop_table :cards_users
  end
end
