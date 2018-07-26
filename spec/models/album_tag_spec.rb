# == Schema Information
#
# Table name: album_tags
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe AlbumTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
