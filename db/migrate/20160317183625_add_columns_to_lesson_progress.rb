class AddColumnsToLessonProgress < ActiveRecord::Migration
  def change
    add_column :lesson_progresses, :last_session_id, :string
    add_column :lesson_progresses, :recording_url, :string
    add_column :lesson_progresses, :marked_as_complete, :boolean
    add_column :lesson_progresses, :feedback, :text
    add_column :lesson_progresses, :archive_id, :string
  end
end
