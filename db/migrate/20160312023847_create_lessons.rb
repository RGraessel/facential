class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :lesson_name
      t.string :lesson_description
      t.string :lesson_objective
      t.belongs_to :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
