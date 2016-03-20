class RemoveColumnFromLessonResponse < ActiveRecord::Migration
  def change
    remove_column :lesson_responses, :marked_as_complete, :boolea
  end
end
