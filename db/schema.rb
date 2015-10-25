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

ActiveRecord::Schema.define(version: 20151025050000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bidlists", force: :cascade do |t|
    t.integer  "site_id",           null: false
    t.string   "name",              null: false
    t.decimal  "bid_amount",        null: false
    t.datetime "bid_open_at"
    t.datetime "bid_closed_at"
    t.decimal  "remaining_amount"
    t.string   "tenor",             null: false
    t.decimal  "interest_rate",     null: false
    t.string   "repayment_method"
    t.decimal  "min_invest_amount"
    t.decimal  "max_invest_amount"
    t.string   "url_address"
    t.integer  "risk_level"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
