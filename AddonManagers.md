# Connecting this addon to an addon manager
This addon requires data to be pushed by another addon. How this is created or added to wow doesn't matter.

```lua
-- The global variable that holds the data
WOWUP_DATA = {}

-- The minimap icon in tga format
WOWUP_DATA.icon = "Interface/AddOns/wowup_data_addon/ldbicon"

-- The addon manager name that will be display in the addon
WOWUP_DATA.addonManagerName = "WowUp"

-- An accent color that is used to color some titles, names, and version numbers
WOWUP_DATA.addonManagerColorRGB = {232/255,205/255,134/255}

-- A command to quickly open the settings
WOWUP_DATA.addonManagerNameSlashCommand = "/wowup"

-- The addons that can be updated, leave empty for no addons
WOWUP_DATA.updateAddonsList = {
  ["Addon Name"] = {"Old Version", "New Version"},
  ["WowUp Addons"] = {"1.3.2", "2.0.0"},
}
```
