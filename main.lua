local addonName, WOWUP = ...
local L = WOWUP.L
local CountTable = WOWUP.CountTable

local function frame_OnEvent(self, event, ...)
    -- init addon
    WOWUP.SetUpSettings()

    local r, g, b = unpack(WOWUP.addonManagerColorRGB)
    local availableAddonUpdates = CountTable(WOWUP.updateAddonsList)
    local message = (availableAddonUpdates > 1 and L["You have %d addons to be updated"] or L["You have %d addon to be updated"]):format(availableAddonUpdates)    -- show notification
    local header = WOWUP.CreateRGBToHexHeader(r, g, b)

    if WowUpAddonInformation.showChatNotification then
        print(WOWUP.updateAddonsList, availableAddonUpdates)
        if availableAddonUpdates > 0 then
            DEFAULT_CHAT_FRAME:AddMessage(header .. ": " .. message)
            if WowUpAddonInformation.showChatNotificationList and WOWUP.updateAddonsList then
                for k, v in pairs(WOWUP.updateAddonsList) do
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
            for k, v in pairs(WOWUP.updateAddonsList) do
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
    preferredIndex = 3,
    OnShow = function(self)
        self.text:SetText(self.data.Text)
        self.SubText:SetText(self.data.subText)
        self.SubText:SetTextColor(1, 1, 1)
    end,
}

