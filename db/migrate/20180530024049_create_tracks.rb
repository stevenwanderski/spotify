class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id
      t.string :spotify_id
      t.string :name
      t.integer :track_number
      t.string :href
      t.string :uri

      t.timestamps null: false
    end
  end
end
