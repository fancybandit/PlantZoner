# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_24_212132) do

  create_table "gardens", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.integer "growing_zone_id", null: false
    t.integer "plant_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["growing_zone_id"], name: "index_gardens_on_growing_zone_id"
    t.index ["owner_id"], name: "index_gardens_on_owner_id"
    t.index ["plant_id"], name: "index_gardens_on_plant_id"
  end

  create_table "growing_zones", force: :cascade do |t|
    t.string "name"
    t.integer "zone_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "plants", force: :cascade do |t|
    t.string "name"
    t.string "scientific_name"
    t.text "image_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "gardens", "growing_zones", on_delete: :cascade
  add_foreign_key "gardens", "plants", on_delete: :cascade
  add_foreign_key "gardens", "users", column: "owner_id", on_delete: :cascade
end
