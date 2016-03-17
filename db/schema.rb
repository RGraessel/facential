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

ActiveRecord::Schema.define(version: 20160317192108) do

  create_table "courses", force: :cascade do |t|
    t.string   "course_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "courses_users", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses_users", ["course_id"], name: "index_courses_users_on_course_id"
  add_index "courses_users", ["user_id"], name: "index_courses_users_on_user_id"

  create_table "lesson_responses", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "session_id"
    t.string   "last_session_id"
    t.string   "recording_url"
    t.boolean  "marked_as_complete"
    t.text     "feedback"
    t.string   "archive_id"
  end

  add_index "lesson_responses", ["lesson_id"], name: "index_lesson_responses_on_lesson_id"
  add_index "lesson_responses", ["user_id"], name: "index_lesson_responses_on_user_id"

  create_table "lessons", force: :cascade do |t|
    t.string   "lesson_name"
    t.string   "lesson_description"
    t.string   "lesson_objective"
    t.integer  "topic_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "lessons", ["topic_id"], name: "index_lessons_on_topic_id"

  create_table "managers", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "manager_user_id"
  end

  add_index "managers", ["manager_user_id", "user_id"], name: "index_managers_on_manager_user_id_and_user_id", unique: true
  add_index "managers", ["user_id", "manager_user_id"], name: "index_managers_on_user_id_and_manager_user_id", unique: true

  create_table "students", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "student_user_id"
  end

  add_index "students", ["student_user_id", "user_id"], name: "index_students_on_student_user_id_and_user_id", unique: true
  add_index "students", ["user_id", "student_user_id"], name: "index_students_on_user_id_and_student_user_id", unique: true

  create_table "topics", force: :cascade do |t|
    t.string   "topic_name"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topics", ["course_id"], name: "index_topics_on_course_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "phone"
    t.string   "user_role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
