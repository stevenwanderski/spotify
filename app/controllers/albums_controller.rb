class AlbumsController < AuthenticatedController
  def index
    if params[:tag_id]
      @tag = current_user.tags.find(params[:tag_id])
      @albums = @tag.albums
      @title = @tag.name
    else
      @albums = current_user.albums
      @title = 'Albums'
    end

    @tags = current_user.tags
  end

  def show
    @album = current_user.albums.find(params[:id])
  end

  def update
    @album = current_user.albums.find(params[:id])
    if @album.update(album_params)
      redirect_to album_path(@album), notice: 'Great job. Success.'
    else
      redirect_to album_path(@album), alert: 'No good. Something went wrong.'
    end
  end

  def populate
    spotify_user = RSpotify::User.new(current_user.auth_hash)

    current_user.albums.destroy_all

    limit = 50
    offset = 0

    RSpotify.raw_response = true

    loop do
      items = JSON.parse(spotify_user.saved_albums(limit: limit, offset: offset).body)['items']

      break if items.empty?

      items.each do |item|
        spotify_album = item['album']
        Album.create!(
          user: current_user,
          spotify_id: spotify_album['id'],
          name: spotify_album['name'],
          artists: spotify_album['artists'].map { |album| album['name'] },
          image_large_url: spotify_album['images'][0]['url'],
          image_medium_url: spotify_album['images'][1]['url'],
          image_small_url: spotify_album['images'][2]['url'],
          href: spotify_album['href'],
          uri: spotify_album['uri'],
          added_at: item['added_at']
        )
      end

      offset = offset + limit
    end

    redirect_to albums_path
  end

  private

  def album_params
    params.require(:album).permit!
  end
end
