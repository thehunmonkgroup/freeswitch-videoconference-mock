--[[
  General support functions used in most of the other scripts.
]]

-- Set this to true to enable console debugging messages.
DEBUG=true

--[[
  Wrapper to optionally print debug messages to the console.
]]
function debug_print(info)
  if DEBUG then
    freeswitch.consoleLog("info", info .. "\n")
  end
end

--[[
  Wrapper to grab session variables.
]]
function get_value(call_var)
  value = session:getVariable(call_var)
  if value then
    debug_print("Got value " .. call_var .. ": " .. value)
  else
    debug_print("Variable " .. call_var .. ": Not set")
  end

  return value
end

--[[
  Wrapper to set session variables.
]]
function set_value(call_var, value)
  session:setVariable(call_var, value)
  debug_print("Set value " .. call_var .. ": " .. value)
end

-- Allows for session checks only when there's an active session.  Otherwise,
-- assume it's a non-session action, and we don't need to worry about endless
-- loops.
function session_ready()
  if session then
    return session:ready()
  else
    return true
  end
end

--[[
  General input callback, which breaks on # key press.
]]
function onInput(session, input_type, data)
  if input_type == "dtmf" then
    -- TODO: Get rid of this when the portaudio bug is fixed.
    data["digit"] = string.sub(data["digit"], 1, 1)
    debug_print("Key pressed: " .. data["digit"])

    if data["digit"] == "#" then
      return "break"
    end
  end
end

--[[
  Wrapper to play the invalid entry macro.
]]
function playback_invalid()
  session:sayPhrase("invalid_entry");
  debug_print("Invalid entry")
end

--[[
  Wrapper to transfer the call to the hangup context.
]]
function hangup()
  session:execute("transfer", "apartmentlines_hangup XML apartmentlines");
end

--[[
  Enables any key press to interrupt a playback file for the duration of the
  file.
]]
function interruptable_playback(filepath)
  set_value("playback_terminators", "0123456789*#")
  session:execute("playback", filepath)
  set_value("playback_terminators", "none")
end

-- Make script arguments consistent.
if argv then
  args = argv
elseif arg then
  args = arg
else
  args = {}
end

