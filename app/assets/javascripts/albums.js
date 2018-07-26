window.onSpotifyWebPlaybackSDKReady = () => {
  const token = $('.access-token').data('access-token');

  var player = new Spotify.Player({
    name: 'Funk Player',
    getOAuthToken: (callback) => {
      callback(token);
    },
    volume: 0.5
  });

  // Error handling
   player.addListener('initialization_error', ({ message }) => { console.error(message); });
   player.addListener('authentication_error', ({ message }) => { console.error(message); });
   player.addListener('account_error', ({ message }) => { console.error(message); });
   player.addListener('playback_error', ({ message }) => { console.error(message); });

   // Playback status updates
   player.addListener('player_state_changed', state => { console.log(state); });

   // Ready
   player.addListener('ready', ({ device_id }) => {
     console.log('Ready with Device ID', device_id);
   });

   // Not Ready
   player.addListener('not_ready', ({ device_id }) => {
     console.log('Device ID has gone offline', device_id);
   });

  player.connect().then((success) => {
    if (success) {
      console.log('The Web Playback SDK successfully connected to Spotify!');
    }
  });

  $('.album').on('click', function(e) {
    const uri = $(this).data('uri');
    // const uri = 'spotify:track:5VWomqQEgYN0WTdtY22l5c';

    fetch(`https://api.spotify.com/v1/me/player/play`, {
      method: 'PUT',
      body: JSON.stringify({ context_uri: uri }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });
  });
};
