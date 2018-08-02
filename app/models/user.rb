# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  auth_hash              :jsonb
#  access_token           :string
#  refresh_token          :string
#  expires_at             :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider              (provider)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid)
#

class User < ActiveRecord::Base
  devise :omniauthable, omniauth_providers: [:spotify]
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :albums
  has_many :tags

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    access_token = auth['credentials']['token']
    refresh_token = auth['credentials']['refresh_token']
    expires_at = DateTime.strptime("#{auth['credentials']['expires_at']}",'%s')

    user.update!({
      auth_hash: auth,
      access_token: access_token,
      refresh_token: refresh_token,
      expires_at: expires_at
    })

    user
  end

  def access_token_expired?
    expires_at_utc = self.expires_at
    now_utc = DateTime.now.in_time_zone('UTC')
    expires_at_utc < now_utc
  end

  def ensure_token!
    if access_token_expired?
      refresh_token = self.refresh_token
      access_token = self.access_token
      url = 'https://accounts.spotify.com/api/token'
      params = {
        grant_type: 'refresh_token',
        refresh_token: refresh_token
      }
      headers = {
        content_type: 'application/x-www-form-urlencoded',
        authorization: "Basic #{access_token}"
      }

      response = RestClient.post(url, params, RSpotify.send(:auth_header))

      json = JSON.parse(response.body)
      token = json['access_token']
      expires_at = DateTime.now.in_time_zone('UTC') + json['expires_in'].seconds

      self.update!(
        access_token: token,
        expires_at: expires_at
      )
    end
  end
end
