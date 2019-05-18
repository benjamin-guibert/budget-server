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

ActiveRecord::Schema.define(version: 2019_05_17_141623) do

  create_table "budget_records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "label", null: false
    t.integer "record_type", null: false
    t.integer "category"
    t.date "date_from", null: false
    t.date "date_to", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.bigint "month_budget_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["month_budget_id"], name: "index_budget_records_on_month_budget_id"
  end

  create_table "month_budgets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", null: false
    t.decimal "initial_balance", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "budget_records", "month_budgets"
end
