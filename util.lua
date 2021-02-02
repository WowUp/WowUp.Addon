local _, WOWUP = ...
WOWUP.L = LibStub("AceLocale-3.0"):GetLocale("WOWUP")
local L = WOWUP.L

WOWUP_DATA = WOWUP_DATA or {}

-- functions
local function newCheckbox(optionName, label, description, onClick, parent)
    local check = CreateFrame("CheckButton", "WowUpAddon" .. optionName, parent, "InterfaceOptionsCheckButtonTemplate")
    check:SetScript("OnClick", function(self)
        local tick = self:GetChecked()
        onClick(self, tick and true or false)
        if tick then
            PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
        else
            PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
        end
    end)
    check.label = _G[check:GetName() .. "Text"]
    check.label:SetText(label)
    check.tooltipText = label
    check.tooltipRequirement = description
    check.label:SetWidth(InterfaceOptionsFramePanelContainer:GetWidth() - 50)

    return check
end
WOWUP.newCheckbox = newCheckbox

local function CreateRGBToHexHeader(r, g, b)
    r = r <= 1 and r >= 0 and r or 1
    g = g <= 1 and g >= 0 and g or 1
    b = b <= 1 and b >= 0 and b or 1
    return format("%s%02x%02x%02x%s %s|r", "|cff", r * 255, g * 255, b * 255, WOWUP_DATA and WOWUP_DATA.addonManagerName or "WowUp", L["Notification"])
end
WOWUP.CreateRGBToHexHeader = CreateRGBToHexHeader

local function CreateRGBToHex(r, g, b)
    r = r <= 1 and r >= 0 and r or 1
    g = g <= 1 and g >= 0 and g or 1
    b = b <= 1 and b >= 0 and b or 1
    return format("%s%02x%02x%02x", "|cff", r * 255, g * 255, b * 255)
end
WOWUP.CreateRGBToHex = CreateRGBToHex

local function CountTable(T)
    local c = 0
    if T ~= nil and type(T) == "table" then
        for _ in pairs(T) do
            c = c + 1
        end
    end
    return c
end
WOWUP.CountTable = CountTable
