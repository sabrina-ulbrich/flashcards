class CreateKarteikartes < ActiveRecord::Migration
  def change
    create_table :karteikartes do |t|
      t.boolean :gewusst
      t.text :vorderseite_text
      t.binary :vorderseite_bild
      t.text :rueckseite_text
      t.binary :rueckseite_bild
      t.string :kategorie

      t.timestamps
    end
  end
end
