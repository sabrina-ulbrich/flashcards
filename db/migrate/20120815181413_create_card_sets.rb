class CreateCardSets < ActiveRecord::Migration
  def change
    create_table :card_sets do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end
end
