class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])

    @user = User.from_omniauth(request.env['omniauth.auth'], spotify_user.to_hash)
    sign_in_and_redirect @user
  end
end
