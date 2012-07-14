class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.boolean :known
      t.text :frontpage_text
      t.binary :frontpage_image
      t.text :backpage_text
      t.binary :backpage_image
      t.string :category

      t.timestamps
    end
  end
end
