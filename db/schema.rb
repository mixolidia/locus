# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_07_212714) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.bigint "city_id", null: false
    t.bigint "state_id", null: false
    t.bigint "coordinate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["coordinate_id"], name: "index_addresses_on_coordinate_id"
    t.index ["state_id"], name: "index_addresses_on_state_id"
    t.index ["street"], name: "index_addresses_on_street", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["value"], name: "index_cities_on_value", unique: true
  end

  create_table "coordinates", force: :cascade do |t|
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lat", "lon"], name: "index_coordinates_on_lat_and_lon", unique: true
    t.index ["lat"], name: "index_coordinates_on_lat", unique: true
    t.index ["lon"], name: "index_coordinates_on_lon", unique: true
  end

  create_table "meetings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "coordinate_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coordinate_id"], name: "index_meetings_on_coordinate_id"
    t.index ["user_id"], name: "index_meetings_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "value", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["value"], name: "index_states_on_value", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_name", "last_name", "mobile"], name: "index_users_on_first_name_and_last_name_and_mobile", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_venues_on_address_id"
    t.index ["name"], name: "index_venues_on_name", unique: true
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "coordinates"
  add_foreign_key "addresses", "states"
  add_foreign_key "meetings", "coordinates"
  add_foreign_key "meetings", "users"
  add_foreign_key "venues", "addresses"
end
