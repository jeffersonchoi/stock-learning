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

ActiveRecord::Schema.define(version: 20161208051320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stock_histories", force: :cascade do |t|
    t.integer  "stock_id"
    t.datetime "date"
    t.decimal  "open"
    t.decimal  "high"
    t.decimal  "low"
    t.decimal  "close"
    t.decimal  "volume"
    t.decimal  "adjusted_close"
    t.string   "trend"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["stock_id"], name: "index_stock_histories_on_stock_id", using: :btree
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "symbol"
    t.string   "name"
    t.decimal  "last_trade"
    t.datetime "date"
    t.datetime "time"
    t.string   "change"
    t.decimal  "change_points"
    t.decimal  "change_percents"
    t.decimal  "previous_close"
    t.decimal  "open"
    t.decimal  "day_high"
    t.decimal  "day_low"
    t.decimal  "volume"
    t.string   "day_range"
    t.string   "last_trade_with_time"
    t.string   "ticker_trend"
    t.decimal  "average_daily_volume"
    t.decimal  "bid"
    t.decimal  "ask"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "display_name",           default: "", null: false
    t.string   "gender"
    t.datetime "date_of_birth"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "stock_histories", "stocks"
end
