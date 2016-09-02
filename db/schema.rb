# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160803000002) do

  create_table "accounts", force: :cascade do |t|
    t.string   "identifier",  limit: 255, null: false
    t.string   "player_name", limit: 255, null: false
    t.string   "password",    limit: 255, null: false
    t.string   "user_name",   limit: 255, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "accounts", ["identifier"], name: "index_accounts_on_identifier", unique: true, using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "identifier",        limit: 255,   null: false
    t.string   "target_type",       limit: 255,   null: false
    t.string   "section",           limit: 255,   null: false
    t.string   "target_identifier", limit: 255,   null: false
    t.string   "progress_status",   limit: 255,   null: false
    t.text     "parameters",        limit: 65535
    t.string   "progress_result",   limit: 255
    t.string   "result_error_code", limit: 255
    t.text     "result_detail",     limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "orders", ["identifier"], name: "index_orders_on_identifier", unique: true, using: :btree

  create_table "signs", force: :cascade do |t|
    t.integer  "account_id", limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "signs", ["account_id"], name: "index_signs_on_account_id", unique: true, using: :btree

  create_table "tokens", force: :cascade do |t|
    t.integer  "sign_id",    limit: 4,   null: false
    t.string   "key",        limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tokens", ["key"], name: "index_tokens_on_key", unique: true, using: :btree
  add_index "tokens", ["sign_id"], name: "index_tokens_on_sign_id", unique: true, using: :btree

end
