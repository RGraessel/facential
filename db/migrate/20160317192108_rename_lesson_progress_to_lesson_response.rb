class RenameLessonProgressToLessonResponse < ActiveRecord::Migration
  def self.up
   rename_table :lesson_progresses, :lesson_responses
 end

 def self.down
    rename_table :lesson_responses, :lesson_progresses
 end
end
