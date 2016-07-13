# freeswitch-videoconference-mock

Set of Lua scripts to assist in mocking/load testing FreeSWITCH videoconference.

## Usage

 * Set up proper gateways/extensions on the installation to be tested, and the testing installation.
 * Drop all .lua files in the ```scripts``` directory into the scripts directory of the testing installation.
 * Edit the variables at the top of ```mock_conference_users.lua``` to taste.
 * From FreeSWITCH CLI on the testing installation run ```luarun mock_conference_users.lua``` for usage instructions.
