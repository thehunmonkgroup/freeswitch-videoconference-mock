--[[
  Load test video conference.
]]

require('support_functions')

-- debug_print("LUA VERSION: " .. _VERSION);

function usage()
  debug_print(string.format("Usage: %s <gateway> <server> <extension> <mock_video_file> <mock_state_variable_name> <conference_id> <user_id>", argv[0]));
end

function main()

  local gateway = argv[1]
  local server = argv[2]
  local extension = argv[3]
  local mock_video_file = argv[4]
  local mock_state_variable_name = argv[5]
  local conference_id = argv[6]
  local user_id = tonumber(argv[7])

  local hangup_user_var = string.format("%s_%s", mock_state_variable_name, user_id)
  local hangup_all_var = string.format("%s_all", mock_state_variable_name)

  debug_print(string.format("Mocking user ID %d to conference ID %d at %s@%s", user_id, conference_id, extension, server));

  function mock_conference_call(user_id)
    local dialstring = string.format("[origination_caller_id_name='Test user #%02d',origination_caller_id_number=%d,sip_h_X-conference_id=%d]sofia/gateway/%s/%s@%s", user_id, user_id, conference_id, gateway, extension, server)
    debug_print(string.format("Initializing mock conference call with dialstring: %s", dialstring))
    local conference_session = freeswitch.Session(dialstring);
    local play_loop
    play_loop = function()
      if conference_session:ready() == true and freeswitch.getGlobalVariable(hangup_user_var) ~= "true" and freeswitch.getGlobalVariable(hangup_all_var) ~= "true" then
        debug_print(string.format("Playing %s from mock caller: %d", mock_video_file, user_id))
        conference_session:execute("playback", mock_video_file)
        return play_loop()
      else
        debug_print(string.format("Hangup caller #%d", user_id))
        return conference_session:hangup()
      end
    end
    play_loop()
  end

  mock_conference_call(user_id)
end

main()
