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

ActiveRecord::Schema.define(version: 20160211070803) do

  create_table "activities", force: :cascade do |t|
    t.integer  "position_id",    null: false
    t.integer  "user_id",        null: false
    t.integer  "trackable_id",   null: false
    t.string   "trackable_type", null: false
    t.string   "key",            null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "activities", ["created_at"], name: "index_activities_on_created_at"
  add_index "activities", ["position_id"], name: "index_activities_on_position_id"
  add_index "activities", ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "issues", force: :cascade do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "issues", ["user_id"], name: "index_issues_on_user_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "opinion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["opinion_id"], name: "index_likes_on_opinion_id"
  add_index "likes", ["user_id", "opinion_id"], name: "index_likes_on_user_id_and_opinion_id", unique: true
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "opinions", force: :cascade do |t|
    t.integer  "user_id",                 null: false
    t.integer  "position_id",             null: false
    t.text     "body"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "choice"
    t.integer  "likes_count", default: 0, null: false
    t.integer  "source_id"
  end

  add_index "opinions", ["position_id"], name: "index_opinions_on_position_id"
  add_index "opinions", ["source_id"], name: "index_opinions_on_source_id"
  add_index "opinions", ["user_id"], name: "index_opinions_on_user_id"

  create_table "parti_sso_client_api_keys", force: :cascade do |t|
    t.integer  "user_id",                           null: false
    t.string   "digest",                            null: false
    t.string   "client",                            null: false
    t.integer  "authentication_id",                 null: false
    t.datetime "expires_at",                        null: false
    t.datetime "last_access_at",                    null: false
    t.boolean  "is_locked",         default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "parti_sso_client_api_keys", ["client"], name: "index_parti_sso_client_api_keys_on_client"
  add_index "parti_sso_client_api_keys", ["user_id", "client"], name: "index_parti_sso_client_api_keys_on_user_id_and_client", unique: true

  create_table "positions", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "positions", ["user_id"], name: "index_positions_on_user_id"

  create_table "supports", force: :cascade do |t|
    t.integer  "leader_id",    null: false
    t.integer  "supporter_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "supports", ["leader_id", "supporter_id"], name: "index_supports_on_leader_id_and_supporter_id", unique: true
  add_index "supports", ["supporter_id"], name: "index_supports_on_supporter_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "nickname",   null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["nickname"], name: "index_users_on_nickname", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "position_id", null: false
    t.string   "choice",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "votes", ["position_id", "user_id"], name: "index_votes_on_position_id_and_user_id", unique: true
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
