class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students, id: false do |t|
      t.integer :user_id
      t.integer :student_user_id
    end

    add_index(:students, [:user_id, :student_user_id], :unique => true)
    add_index(:students, [:student_user_id, :user_id], :unique => true)
  end

  def self.down
    remove_index(:students, [:student_user_id, :user_id])
    remove_index(:students, [:user_id, :student_user_id])
    drop_table :students
  end
end
