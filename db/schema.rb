# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120714140103) do

  create_table "cards", :force => true do |t|
    t.boolean  "known"
    t.text     "frontpage_text"
    t.binary   "frontpage_image"
    t.text     "backpage_text"
    t.binary   "backpage_image"
    t.string   "category"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "karteikartes", :force => true do |t|
    t.boolean  "gewusst"
    t.text     "vorderseite_text"
    t.binary   "vorderseite_bild"
    t.text     "rueckseite_text"
    t.binary   "rueckseite_bild"
    t.string   "kategorie"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

end
