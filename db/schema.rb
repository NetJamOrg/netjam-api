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

ActiveRecord::Schema.define(version: 20161019004913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clips", force: :cascade do |t|
    t.string  "path"
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string  "name"
    t.integer "owner_id"
  end

  create_table "songs", force: :cascade do |t|
    t.integer "project_id"
    t.string  "name"
    t.string  "path"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "website"
    t.string "description"
    t.string "oauth_uid"
    t.string "provider"
  end

  add_foreign_key "clips", "projects"
  add_foreign_key "clips", "users"
  add_foreign_key "projects", "users", column: "owner_id"
  add_foreign_key "songs", "projects"
end
