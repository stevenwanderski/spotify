class CreateAlbumTags < ActiveRecord::Migration
  def change
    create_table :album_tags do |t|
      t.integer :album_id, null: false
      t.integer :tag_id, null: false

      t.timestamps null: false
    end
  end
end
