# == Schema Information
#
# Table name: tracks
#
#  id           :integer          not null, primary key
#  album_id     :integer
#  spotify_id   :string
#  name         :string
#  track_number :integer
#  href         :string
#  uri          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Track < ActiveRecord::Base
end
