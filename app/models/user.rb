class User < ActiveRecord::Base
  has_secure_password
  validates :avatar, presence: true
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


  has_and_belongs_to_many :courses
  has_many :lesson_responses
  has_many :topics, through: :courses
  has_many :lessons, through: :courses

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
