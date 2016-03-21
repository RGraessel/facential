# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  User.populate 5 do |user|
     user.first_name = Faker::Name.first_name
     user.last_name = Faker::Name.last_name
     user.email = Faker::Internet.email
     user.phone = Faker::PhoneNumber.phone_number
     user.user_role = "student"
     user.password_digest = Faker::Internet.password
   end

  #  User.create(user_id: 6, first_name: "Samuel", last_name: "Samuels", user_role: student)

  Course.create(id: 1, course_name: "ruby")
  Course.create(course_name: "ruby on rails")
  Course.create(course_name: "javascript")

  Topic.create(course_id: 1, topic_name: "ruby classes 1", topic_id: 1)
  Topic.create(course_id: 1, topic_name: "ruby classes 2", topic_id: 2)
  Topic.create(course_id: 1, topic_name: "ruby classes 3", topic_id: 3)
  Topic.create(course_id: 1, topic_name: "ruby variables 1", topic_id: 4)

  Lesson.create(id: 1, lesson_name: "ruby classes", lesson_description: "this course teaches all you need to know about ruby classes", topic_id: 1)
  Lesson.create(id: 2, lesson_name: "ruby variables", lesson_description: "This course teaches all you need to know about ruby variables", topic_id: 1)

  LessonResponses.create(marked_as_complete: true, lesson_id: 1, user_id: 6)
  LessonResponses.create(marked_as_complete: true, lesson_id: 2, user_id: 6)
