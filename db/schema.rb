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

ActiveRecord::Schema.define(version: 20151113174024) do

  create_table "event_invitations", force: :cascade do |t|
    t.integer  "inviter_id"
    t.integer  "invitee_id"
    t.integer  "event_id"
    t.boolean  "attending"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "message",    default: "You're invited to this event!"
  end

  add_index "event_invitations", ["event_id"], name: "index_event_invitations_on_event_id"
  add_index "event_invitations", ["invitee_id"], name: "index_event_invitations_on_invitee_id"
  add_index "event_invitations", ["inviter_id", "invitee_id", "event_id"], name: "idx_event_invite_unique", unique: true
  add_index "event_invitations", ["inviter_id"], name: "index_event_invitations_on_inviter_id"

  create_table "event_managements", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.datetime "datetime"
    t.string   "title"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "creator_id"
    t.string   "description"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
