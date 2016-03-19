var SAMPLE_SERVER_BASE_URL = 'http://localhost:3000';

var apiKey,
    sessionId,
    token,
    status,
    archiveID;

$(document).ready(function() {
  $('#stop').show();
  $('#stop').prop('disabled', true)
  archiveID = null;

  // Make an Ajax request to get the OpenTok API key, session ID, and token from the server
  $.get(SAMPLE_SERVER_BASE_URL + '/session', function(res) {

    apiKey = res.api_key;
    sessionId = res.session_id;
    token = res.token;

    initializeSession();
  });
});

function initializeSession() {
  if(!window.location.pathname.match(/\/users\/[0-9]+\/courses\/[0-9]+\/topics\/[0-9]+\/lessons\/[0-9]+/)){
    return false;
  }
  var session = OT.initSession(apiKey, sessionId);

  // Subscribe to a newly created stream
  session.on('streamCreated', function(event) {
    session.subscribe(event.stream, 'subscriber', {
      insertMode: 'replace',
      width: '100%',
      height: '100%'
    });
  });

  session.on('archiveStarted', function(event) {
    archiveID = event.id;
    console.log('Archive started ' + archiveID);
    $('#stop').prop('disabled', false);
    $('#start').prop('disabled', true);
    $('#view').show();
  });

  session.on('archiveStopped', function(event) {
    archiveID = event.id;
    console.log('Archive stopped ' + archiveID);
    $('#start').prop('disabled', true);
    $('#stop').prop('disabled', true);
    $('#view').show();

  });

  session.on('sessionDisconnected', function(event) {
    console.log('You were disconnected from the session.', event.reason);
  });

  // Connect to the session
  console.log(token);
  session.connect(token, function(error) {
    console.log(error);
    // If the connection is successful, initialize a publisher and publish to the session
    if (!error) {
      var publisher = OT.initPublisher('publisher', {
        insertMode: 'append',
        width: '460px',
        height: '285px'
      });

      session.publish(publisher);
    } else {
      console.log('There was an error connecting to the session: ', error.code, error.message);
    }
  });
}

// Start recording
function startArchive() {
  var lessonId = 1;
  $.post(SAMPLE_SERVER_BASE_URL + '/start/' + sessionId + '/' + lessonId);
  $('#start').show();
  $('#stop').show();
}


// Stop recording
function stopArchive() {
  $.post(SAMPLE_SERVER_BASE_URL + '/stop/' + archiveID);
  $('#stop').hide();
  $('#view').prop('disabled', false);
  $('#stop').show();
}

// Get the archive status. If it is  "available", download it. Otherwise, keep checking
// every 5 secs until it is "available"
function viewArchive(){
  $('#view').prop('disabled', true);
  $.ajax('/view?archive_id=' + archiveID)
    .always(function(data) {
    $('#videos').empty
    $('#videos').html(
      "<div class='video-resize'>"+
      "<video autoplay id='video1' width='400' height='313px'>" +
      "  <source id='source' src='" + data.responseText + "' type='video/mp4'>" +
      "  Your browser does not support HTML5 video. " +
      "</video>" +
      "</div>"
    );
  });
}

$('#start').show();
$('#view').hide();


// var myVideo = document.getElementById("video_box1");
//
//
// function playPause() {
//     if (myVideo.paused)
//         myVideo.play();
//     else
//         myVideo.pause();
// }
//
// function makeBig() {
//     myVideo.width = 560;
// }
//
// function makeSmall() {
//     myVideo.width = 320;
// }
//
// function makeNormal() {
//     myVideo.width = 420;
// }
