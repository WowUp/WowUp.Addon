**WARNING: This addon is still in early development**

# WowUp.Addon
_The official WowUp World of Warcraft addon_

This addon receives data from the WowUp application and enables an in-game
notification when you first load, or reload the interface. This addon won't run
without the [WowUp application](https://wowup.io/).

## Basic Usage
After installing the addons, you have a few slash commands available:
 - `/wowup list` to list available options to be set via `/wowup <optionName> <value>`
 - `/wowup reset` to reset all options to their default which can be viewed via `/wowup <optionName>`

## Internal workings
The WowUp application replaces `data.lua` with the required data, which is then
made available to the addon once it's (re)loaded in World of Warcraft
