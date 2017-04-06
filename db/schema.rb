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

ActiveRecord::Schema.define(version: 20170406233251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "course_code"
    t.string   "description"
    t.string   "term"
    t.integer  "students_per_TA"
    t.string   "instructor_id"
    t.string   "requirements"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "projected_course_enrollment"
    t.datetime "deadline"
    t.integer  "year"
    t.integer  "required_hours",              default: 0
  end

  create_table "instructor_preference_tables", force: :cascade do |t|
    t.string  "course_id"
    t.string  "user_id"
    t.boolean "preference"
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "utorid"
    t.string   "course_code"
  end

end
