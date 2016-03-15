class CreateCoursesUsersTable < ActiveRecord::Migration
  def change
    create_table :courses_users do |t|
        t.belongs_to :course, index: true, foreign_key: true
        t.belongs_to :user, index: true, foreign_key: true

        t.timestamps null: false
    end
  end
end
