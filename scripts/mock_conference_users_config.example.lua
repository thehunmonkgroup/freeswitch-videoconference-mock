--[[
  Configuration for mocking videoconference users.
]]

_M = {
  -- Name of the SIP gateway that registers with the server to be tested.
  gateway = "test_harness",
  -- Server domain of the server to be tested.
  server = "[freeswitch_conference_server_ip]",
  -- Load testing extension on the server to be tested.
  extension = "load_test",
  -- Full path to the video file to play for the tests, including format.
  mock_video_file = "vlc:///usr/local/freeswitch/storage/sample-vid.mp4",
}

return _M
