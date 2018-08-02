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

require 'rails_helper'

RSpec.describe Album, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
