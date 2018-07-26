class AlbumsController < AuthenticatedController
  def index
    if params[:tag_id]
      tag_id = params[:tag_id]
      @tag = current_user.tags.find(tag_id)
      @albums = @tag.albums
      @title = @tag.name
    else
      @albums = current_user.albums
      @title = 'Albums'
    end

    @tags = current_user.tags
    @access_token = current_user.auth_hash['credentials']['token']
  end

  def show
    @album = current_user.albums.find(params[:id])
  end

  def update
    
  end

  def populate
    spotify_user = RSpotify::User.new(current_user.auth_hash)

    current_user.albums.destroy_all

    limit = 50
    offset = 0

    loop do
      albums = spotify_user.saved_albums(limit: limit, offset: offset)

      break if albums.empty?

      albums.each do |spotify_album|
        Album.create!(
          user: current_user,
          spotify_id: spotify_album.id,
          name: spotify_album.name,
          artist: spotify_album.artists.first.name,
          image_large_url: spotify_album.images[0]['url'],
          image_medium_url: spotify_album.images[1]['url'],
          image_small_url: spotify_album.images[2]['url'],
          href: spotify_album.href,
          uri: spotify_album.uri
        )
      end

      offset = offset + limit
    end

    redirect_to albums_path
  end
end
