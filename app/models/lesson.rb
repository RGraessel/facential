class Lesson < ActiveRecord::Base
  belongs_to :topic
  has_many :lesson_progresses
end
