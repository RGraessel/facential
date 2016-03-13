class User < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_many :lesson_progresses
  has_many :topics, through: :courses
  has_many :lessons, through: :topics
  has_secure_password

has_and_belongs_to_many :students,
class_name: "User",
join_table: :students,
foreign_key: :user_id,
association_foreign_key: :student_user_id

has_and_belongs_to_many :managers,
class_name: "User",
join_table: :managers,
foreign_key: :user_id,
association_foreign_key: :manager_user_id

end
