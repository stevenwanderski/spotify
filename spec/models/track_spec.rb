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

require 'rails_helper'

RSpec.describe Track, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
