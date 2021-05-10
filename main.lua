local addonName, WOWUP = ...
local L = WOWUP.L
local CountTable = WOWUP.CountTable

WOWUP_DATA = WOWUP_DATA or {}

local function frame_OnEvent(self, event, ...)
    -- check if data addon is loaded
    if not IsAddOnLoaded("wowup_data_addon") then
        DEFAULT_CHAT_FRAME:AddMessage(WOWUP.CreateRGBToHexHeader(232/255,205/255,134/255) .. ": " .. L["Data addon is missing"])
        return
    end
    -- init addon
    WOWUP.SetUpSettings()

    local r, g, b = unpack(WOWUP_DATA.addonManagerColorRGB)
    local availableAddonUpdates = CountTable(WOWUP_DATA.updateAddonsList)
    local message = (availableAddonUpdates > 1 and L["You have %d addons to be updated"] or L["You have %d addon to be updated"]):format(availableAddonUpdates)    -- show notification
    local header = WOWUP.CreateRGBToHexHeader(r, g, b)

    if WowUpAddonInformation.showChatNotification then
        if availableAddonUpdates > 0 then
            DEFAULT_CHAT_FRAME:AddMessage(header .. ": " .. message)
            if WowUpAddonInformation.showChatNotificationList and WOWUP_DATA.updateAddonsList then
                for k, v in pairs(WOWUP_DATA.updateAddonsList) do
                    if type(v) == "table" then
                        local addonLine = k .. ": "-- add AddonName
                        addonLine = addonLine .. WOWUP.CreateRGBToHex(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b) .. (v[1] and v[1] or " ") .. "|r " -- current version
                        addonLine = addonLine .. WOWUP.CreateRGBToHex(r, g, b) .. "-> " .. (v[2] and v[2] or " ") .. "|r "
                        DEFAULT_CHAT_FRAME:AddMessage(addonLine)
                    end
                end
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage(header .. ": " .. L["All addons are up-to-date"])
        end
    end

    if WowUpAddonInformation.showPopupNotification and availableAddonUpdates > 0 then
        local data = {}
        data.Text = header
        if WowUpAddonInformation.showChatNotificationList then
            local addonUpdateList = "\n\n"
            for k, v in pairs(WOWUP_DATA.updateAddonsList) do
                if type(v) == "table" then
                    local addonLine = k .. ": "-- add AddonName
                    addonLine = addonLine .. WOWUP.CreateRGBToHex(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b) .. (v[1] and v[1] or " ") .. "|r " -- current version
                    addonLine = addonLine .. WOWUP.CreateRGBToHex(r, g, b) .. "-> " .. (v[2] and v[2] or " ") .. "|r "
                    addonUpdateList = addonUpdateList .. addonLine .. "\n"
                end
            end
            data.subText = message .. addonUpdateList
        else
            data.subText = message
        end

        StaticPopup_Show("WowUp_ShowUpdatesAvailable", nil, nil, data)
    end
end

local frame = CreateFrame("frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", frame_OnEvent)

StaticPopupDialogs["WowUp_ShowUpdatesAvailable"] = {
    text = "",
    subText = " ",
    button1 = OKAY,
    timeout = 0,
    whileDead = false,
    hideOnEscape = true,
    preferredIndex = 4,
    OnShow = function(self)
        self.text:SetText(self.data.Text)
        self.SubText:SetText(self.data.subText)
        self.SubText:SetTextColor(1, 1, 1)
    end,
}
