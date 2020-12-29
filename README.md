**WARNING: This addon is still in early development**

# Addon Update Notifications (by WowUp)
_The official WowUp World of Warcraft addon_

This addon receives data from an addon manager like WowUp and enables an in-game
notification when you first load, or reload the interface. This addon won't run
without an addon manager that supports this feature. Managers that are known to
support this:
  - [WowUp application](https://wowup.io/)

## Basic Usage
After installing the addons, you have a few slash commands available\*:
 - `/wowup list` to list available options to be set via `/wowup <optionName> <value>`
 - `/wowup reset` to reset all options to their default which can be viewed via `/wowup <optionName>`

_\* When using this addon with another addon manager, you might have to use a different command_

## Internal workings
The addon manager modifies `data.lua` with the required data, which is then
made available to the addon once it's (re)loaded in World of Warcraft
