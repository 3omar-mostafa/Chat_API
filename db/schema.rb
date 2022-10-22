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

ActiveRecord::Schema.define(version: 2022_10_22_163432) do

  create_table "chat", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "chat_id", null: false
    t.bigint "chat_application_id", null: false
    t.string "name", null: false
    t.integer "messages_count", default: 0
    t.index ["chat_application_id", "chat_id"], name: "index_chat_on_chat_application_id_and_chat_id", unique: true
    t.index ["chat_application_id"], name: "fk_rails_dd4d19dd30"
  end

  create_table "chat_application", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "token", limit: 38, null: false
    t.string "name", null: false
    t.integer "chats_count", default: 0
    t.index ["token"], name: "index_chat_application_on_token", unique: true
  end

  create_table "message", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.integer "message_id", null: false
    t.bigint "chat_id", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id", "message_id"], name: "index_message_on_chat_id_and_message_id", unique: true
    t.index ["chat_id"], name: "fk_rails_b7d36e3cb1"
  end

  add_foreign_key "chat", "chat_application", on_delete: :cascade
  add_foreign_key "message", "chat", on_delete: :cascade
end
