class AddColumnFromLessonResponse < ActiveRecord::Migration
  def change
    add_column :lesson_responses, :marked_as_complete, :boolean, :default => false
  end
end
