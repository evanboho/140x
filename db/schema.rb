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

ActiveRecord::Schema.define(version: 20131026204326) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grants", force: true do |t|
    t.integer  "granter_id"
    t.integer  "grantee_id"
    t.datetime "starts"
    t.datetime "ends"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grants", ["grantee_id"], name: "index_grants_on_grantee_id", using: :btree
  add_index "grants", ["granter_id"], name: "index_grants_on_granter_id", using: :btree

  create_table "tweeters", force: true do |t|
    t.string   "screen_name"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "timezone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweeters", ["screen_name"], name: "index_tweeters_on_screen_name", using: :btree

  create_table "tweets", force: true do |t|
    t.string   "body"
    t.integer  "tweeter_id"
    t.integer  "sender_id"
    t.string   "tweet_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tweets", ["sender_id"], name: "index_tweets_on_sender_id", using: :btree
  add_index "tweets", ["tweeter_id"], name: "index_tweets_on_tweeter_id", using: :btree

end
