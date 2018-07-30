Albums = {
  init(args) {
    this.args = args;
    window.onSpotifyWebPlaybackSDKReady = () => {
      this.initializeSDK();
    };
  },

  initializeSDK() {
    const token = this.args.accessToken;

    var player = new Spotify.Player({
      name: 'Funk Player',
      getOAuthToken: (callback) => {
        callback(token);
      }
    });

    player.addListener('ready', ({ device_id }) => {
      console.log('The Web Playback SDK is ready to play music!');
      console.log('Device ID', device_id);
    });

    player.connect();

    $('[data-uri]').on('click', function(e) {
      const uri = $(this).data('uri');

      fetch(`https://api.spotify.com/v1/me/player/play`, {
        method: 'PUT',
        body: JSON.stringify({ context_uri: uri }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        }
      });
    });
  }
}
