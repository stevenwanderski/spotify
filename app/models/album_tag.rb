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

class AlbumTag < ActiveRecord::Base
  belongs_to :album
  belongs_to :tag
end
