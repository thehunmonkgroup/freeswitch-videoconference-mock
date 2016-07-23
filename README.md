# freeswitch-videoconference-mock

Set of Lua scripts to assist in mocking/load testing FreeSWITCH videoconference.

## Usage

 * Drop all .lua files in the ```scripts``` directory into the scripts directory of the testing installation.
 * Copy ```mock_conference_users_config.example.lua``` to ```mock_conference_users_config.lua```, and edit the variables to taste.
 * Set up proper gateways/extensions on the installation to be tested, and the mocking installation.
 * From FreeSWITCH CLI on the testing installation run ```luarun mock_conference_users.lua``` for usage instructions.
