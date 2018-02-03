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

ActiveRecord::Schema.define(version: 20180203003903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  create_table "anamnesis", force: :cascade do |t|
    t.string   "sp"
    t.string   "hea"
    t.string   "fog"
    t.string   "ape"
    t.string   "apa"
    t.string   "afa"
    t.string   "sv"
    t.string   "pa"
    t.string   "fr"
    t.string   "p"
    t.string   "t"
    t.string   "fcyp"
    t.string   "tc"
    t.string   "orl"
    t.string   "cp"
    t.string   "abd"
    t.string   "ext"
    t.string   "pyf"
    t.string   "idx"
    t.string   "tx"
    t.string   "annotations"
    t.integer  "patient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appointments", force: :cascade do |t|
    t.string   "symptoms"
    t.string   "medicines"
    t.string   "cares"
    t.string   "annotations"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "address"
    t.string   "email"
    t.string   "home_number"
    t.string   "phone_numer"
    t.string   "blood_type"
    t.string   "annotations"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
