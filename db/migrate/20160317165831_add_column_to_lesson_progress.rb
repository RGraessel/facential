class AddColumnToLessonProgress < ActiveRecord::Migration
  def change
    add_column :lesson_progresses, :session_id, :integer
  end
end
