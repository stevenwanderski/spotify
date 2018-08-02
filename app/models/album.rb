# == Schema Information
#
# Table name: albums
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  spotify_id       :string
#  name             :string
#  image_large_url  :string
#  image_medium_url :string
#  image_small_url  :string
#  href             :string
#  uri              :string
#  artists          :jsonb
#  added_at         :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Album < ActiveRecord::Base
  has_many :tracks, dependent: :destroy
  has_many :tags, through: :album_tags
  has_many :album_tags
  belongs_to :user
end
