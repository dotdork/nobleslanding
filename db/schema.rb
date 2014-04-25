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

ActiveRecord::Schema.define(version: 20140425211849) do

  create_table "checklist_items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "order"
    t.integer  "checklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checklist_items", ["checklist_id"], name: "index_checklist_items_on_checklist_id"

  create_table "checklists", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guest_logs", force: true do |t|
    t.string   "name"
    t.text     "log",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "in_at"
    t.date     "out_at"
    t.integer  "rating",                 default: 10
  end

end
