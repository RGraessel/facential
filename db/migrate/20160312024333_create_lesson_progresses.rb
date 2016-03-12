class CreateLessonProgresses < ActiveRecord::Migration
  def change
    create_table :lesson_progresses do |t|
      t.belongs_to :lesson, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
