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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170905204347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributions", force: :cascade do |t|
    t.decimal "amount", precision: 8, scale: 2
    t.bigint "fellow_id"
    t.bigint "user_id"
    t.string "customer_id"
    t.string "charge_id"
    t.index ["fellow_id"], name: "index_contributions_on_fellow_id"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "fellows", force: :cascade do |t|
    t.string "login"
    t.string "name"
    t.string "avatar_url"
    t.text "bio"
    t.string "html_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.decimal "goal", precision: 8, scale: 2, default: "75000.0", null: false
    t.index ["user_id"], name: "index_fellows_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "github_username"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contributions", "fellows"
  add_foreign_key "contributions", "users"
  add_foreign_key "fellows", "users"
end
