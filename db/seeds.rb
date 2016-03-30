# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    user1 = User.new
    user1.first_name = 'Carlos'
    user1.last_name = 'Vazquez'
    user1.email = 'carlos@facential.com'
    user1.password_digest = 'test113'
    user1.save!

    user2 = User.new
    user2.first_name = 'David'
    user2.last_name = 'Kay'
    user2.email = 'd_kay@facential.com'
    user2.password_digest = 'test123'
    user2.save!

  # User.populate 5 do |user|
  #    user.first_name = Faker::Name.first_name
  #    user.last_name = Faker::Name.last_name
  #    user.email = Faker::Internet.email
  #    user.phone = Faker::PhoneNumber.phone_number
  #    user.user_role = "student"
  #    user.password_digest = Faker::Internet.password
  #  end

  #  User.create(user_id: 6, first_name: "Samuel", last_name: "Samuels", user_role: student)

  Course.create(course_name: "Improve at Public Speaking")
  Course.create(course_name: "How to Sell")
  Course.create(course_name: "Customer Service")

  Topic.create(topic_name: "Beatboxing")
  Topic.create(topic_name: "Rhytm and style")


  Lesson.create(lesson_name: "Beatboxing", lesson_description: "Basic Beatboxing.")
  Lesson.create(lesson_name: "Singing in Sign Language", lesson_description: "The Rose by Bette Midler in sign language.")
  Lesson.create(lesson_name: "Verbalizing", lesson_description: "Tone and pronunciation.")

  LessonResponse.create(marked_as_complete: true)
  LessonResponse.create(marked_as_complete: true)
