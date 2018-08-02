Albums = {
  init(args) {
    this.args = args;
    window.onSpotifyWebPlaybackSDKReady = () => {
      this.initializeSDK();
    };
  },

  initializeSDK() {
    const accessToken = this.args.accessToken;

    var player = new Spotify.Player({
      name: 'Funk Player',
      getOAuthToken: (callback) => {
        callback(accessToken);
      }
    });

    player.connect();

    $('[data-uri]').on('click', function(e) {
      const uri = $(this).data('uri');

      fetch(`https://api.spotify.com/v1/me/player/play`, {
        method: 'PUT',
        body: JSON.stringify({ context_uri: uri }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${accessToken}`
        }
      }).catch((error) => {
        alert('Token gone bad! Refresh the browser please and thank you 🙏🏼');
        console.error(error);
      });
    });
  }
}
