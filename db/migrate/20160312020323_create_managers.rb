class CreateManagers < ActiveRecord::Migration
  def self.up
    create_table :managers, id: false do |t|
      t.integer :user_id
      t.integer :manager_user_id
    end

    add_index(:managers, [:user_id, :manager_user_id], :unique => true)
    add_index(:managers, [:manager_user_id, :user_id], :unique => true)
  end

  def self.down
    remove_index(:managers, [:manager_user_id, :user_id])
    remove_index(:managers, [:user_id, :manager_user_id])
    drop_table :managers
  end
end
