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

  Course.create(course_name: "ruby")
  Course.create(course_name: "ruby on rails")
  Course.create(course_name: "javascript")

  Lesson.create(lesson_name: "ruby classes", lesson_description: "this course teaches all you need to know about ruby classes", topic_id: [5, 6, 7])

  Topic.create(topic_name: "ruby classes 1")
  Topic.create(topic_name: "ruby classes 2")
  Topic.create(topic_name: "ruby classes 3")
