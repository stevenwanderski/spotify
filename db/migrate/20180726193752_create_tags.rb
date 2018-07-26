class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :user_id, null: false
      t.text :name, null: false

      t.timestamps null: false
    end
  end
end
