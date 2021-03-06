class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :user_id
      t.string :spotify_id
      t.string :name
      t.string :image_large_url
      t.string :image_medium_url
      t.string :image_small_url
      t.string :href
      t.string :uri
      t.jsonb :artists
      t.datetime :added_at

      t.timestamps null: false
    end
  end
end
