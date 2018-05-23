require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, "c2b99d31f6c74cd78b338dbaf59c7bd1", "9780186cd73e43c0be9426edd7bb2476", scope: 'user-read-email playlist-modify-public user-library-read user-library-modify'
end
