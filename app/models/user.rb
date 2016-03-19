class User < ActiveRecord::Base

  before_save { email.downcase! }
  # validates :first_name, presence: true, length: { in: 3..30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, confirmation: true, format: { with: VALID_EMAIL_REGEX}
  validates :email, length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password


  validates :avatar, presence: true
  has_attached_file :avatar, styles: { thumb: "100x100>" }
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
