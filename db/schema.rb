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

ActiveRecord::Schema.define(version: 2019_12_11_181120) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dog_walkings", force: :cascade do |t|
    t.string "status", default: "scheduled"
    t.datetime "schedule_date", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.integer "duration", null: false
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.datetime "ini_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.index ["provider_id"], name: "index_dog_walkings_on_provider_id"
    t.index ["status"], name: "index_dog_walkings_on_status"
  end

  create_table "dog_walkings_pets", id: false, force: :cascade do |t|
    t.bigint "dog_walking_id", null: false
    t.bigint "pet_id", null: false
    t.index ["dog_walking_id"], name: "index_dog_walkings_pets_on_dog_walking_id"
    t.index ["pet_id"], name: "index_dog_walkings_pets_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name", null: false
    t.string "breed", null: false
    t.bigint "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_pets_on_client_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "document", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "pets", "clients"
end
