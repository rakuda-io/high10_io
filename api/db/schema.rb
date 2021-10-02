# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_02_005551) do

  create_table "holdings", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.float "quantity"
    t.float "dividend_amount"
    t.float "dividend_rate"
    t.float "total_dividend_amount"
    t.float "average_dividend_rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_id"], name: "index_holdings_on_stock_id"
  end

  create_table "stocks", charset: "utf8mb4", force: :cascade do |t|
    t.string "company_name"
    t.string "ticker_symbol"
    t.string "country"
    t.string "sector"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "holdings", "stocks"
end
