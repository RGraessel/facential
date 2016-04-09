  var SAMPLE_SERVER_BASE_URL = 'https://facential.herokuapp.com';
// var SAMPLE_SERVER_BASE_URL = 'http://localhost:3000';
var isReRecord = false;

  var apiKey,
      sessionId,
      token,
      status,
      archiveID;

  $(document).on("page:change", function() {
  $('#stop').show();
  $('#stop').prop('disabled', true)
  $('#view').show()
  $('#view').prop('disabled', true)
  $('#submit').prop('disabled', true)
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
  if(!window.location.pathname.match(/topics\/[0-9]+\/lessons\/[0-9]+/)){
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
    if (isReRecord == true){
      $.ajax('/rerecord?archive_id=' + archiveID)
      $('#publisherHolder').show();
      $('#replay').hide();
    }
    archiveID = event.id;
    console.log('Archive started ' + archiveID);
    $('#stop').prop('disabled', false);
    $('#view').show();
  });

  session.on('archiveStopped', function(event) {
    archiveID = event.id;
    console.log('Archive stopped ' + archiveID);
    // $('#start').prop('disabled', true);
    $('#stop').prop('disabled', true);
    $('#view').show();
    $('#view').prop('disabled', false);
    $('#submit').prop('disabled', false);
    $('#start').empty
    $('#start').html("<i class='material-icons'>replay</i>");
    $('#submit').click('streamCreated');
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
  console.log(lessonId)
}


// Stop recording
function stopArchive() {
  $.post(SAMPLE_SERVER_BASE_URL + '/stop/' + archiveID);
  $('#stop').hide();
  $('#view').prop('disabled', false);
  $('#stop').show();
}


function submitArchive(){
  window.location = SAMPLE_SERVER_BASE_URL + '/submit/?archive_id=' + archiveID
}
// Get the archive status. If it is  "available", download it. Otherwise, keep checking
// every 5 secs until it is "available"
function viewArchive(){
  isReRecord = true
  $('#view').prop('disabled', false);
  $('#start').show()
  $('#start').prop('disabled', false)
  $.ajax('/view?archive_id=' + archiveID)
    .always(function(data) {
    $('#publisherHolder').hide();

    $('#replay').empty();
    $('#replay').append(
      "<video autoplay id='video1' width='400' height='313px'>" +
      "  <source id='source' src='" + data.responseText + "' type='video/mp4'>" +
      "  Your browser does not support HTML5 video. " +
      "</video>"
    );
    $('#replay').show();
  });
}

$(document).ready(function(){
  $('.title').click(function(){
    $('.script').slideToggle('slow')

  });
});
