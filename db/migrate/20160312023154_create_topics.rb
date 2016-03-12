class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name
      t.belongs_to :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
