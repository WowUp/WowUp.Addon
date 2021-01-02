local addonName, WOWUP = ...
local L = LibStub("AceLocale-3.0"):GetLocale("WOWUP")

-- default settings
local WowUpOptions = {
    showPopupNotification = true,
    showChatNotification = true,
}

-- functions
local function newCheckbox(label, description, onClick, parent)
    local check = CreateFrame("CheckButton", "WowUpAddon" .. label, parent, "InterfaceOptionsCheckButtonTemplate")
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

local function CreateRGBToHexHeader(r, g, b)
    r = r <= 1 and r >= 0 and r or 1
    g = g <= 1 and g >= 0 and g or 1
    b = b <= 1 and b >= 0 and b or 1
    return format("%s%02x%02x%02x%s %s|r", "|cff", r * 255, g * 255, b * 255, WOWUP.addonManagerName, L["Notification"])
end

local function checkBox_OnClick(self)
    WowUpAddonInformation[self.settingName] = self:GetChecked()
end

local function setOptions(overwriteToDefault)
    for optionName, optionDefaultValue in pairs(WowUpOptions) do
        if overwriteToDefault or WowUpAddonInformation[optionName] == nil then
            WowUpAddonInformation[optionName] = optionDefaultValue
        end
    end
end

local function frame_OnEvent(self, event, ...)
    -- ensure saved variable is in a usable state
    if not WowUpAddonInformation then
        WowUpAddonInformation = WowUpOptions
    end

    setOptions(false)

    local MainFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    MainFrame.name = addonName .. " " .. COMMUNITIES_NOTIFICATION_SETTINGS_DIALOG_SETTINGS_LABEL

    MainFrame.title = MainFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	MainFrame.title:SetPoint("TOPLEFT", 16, -16)
    MainFrame.title:SetText(addonName)
    
	MainFrame.popupNotificationCheckbox = newCheckbox(L["Show a popup with a notification after loading when updates are available"], "", function(self, value) WowUpAddonInformation.showPopupNotification = value end, MainFrame)
	MainFrame.popupNotificationCheckbox:SetChecked(WowUpAddonInformation.showPopupNotification)
    MainFrame.popupNotificationCheckbox:SetPoint("TOPLEFT", MainFrame.title, "BOTTOMLEFT", -2, -16)

    MainFrame.chatNotificationCheckbox = newCheckbox(L["Show a chat message indicating whether or not updates are available"], "", function(self, value) WowUpAddonInformation.showChatNotification = value end, MainFrame)
	MainFrame.chatNotificationCheckbox:SetChecked(WowUpAddonInformation.showChatNotification)
    MainFrame.chatNotificationCheckbox:SetPoint("TOPLEFT", MainFrame.popupNotificationCheckbox, "BOTTOMLEFT", 0, -8)

    InterfaceOptions_AddCategory(MainFrame)

    -- show notification
    local header = CreateRGBToHexHeader(unpack(WOWUP.addonManagerColorRGB))
    local message = (WOWUP.updatesAvailableCount > 1 and L["You have %d addons to be updated"] or L["You have %d addon to be updated"]):format(WOWUP.updatesAvailableCount)

    if WowUpAddonInformation.showChatNotification then
        if WOWUP.updatesAvailableCount > 0 then
            DEFAULT_CHAT_FRAME:AddMessage(header .. ": " .. message)
        else
            DEFAULT_CHAT_FRAME:AddMessage(header .. ": " .. L["All addons are up-to-date"]:format(WOWUP.addonManagerName))
        end
    end

    if WowUpAddonInformation.showPopupNotification and WOWUP.updatesAvailableCount > 0 then
        local data = {}
        data.Text = header
        data.subText = message
        StaticPopup_Show("WowUp_ShowUpdatesAvailable", nil, nil, data)
    end

    -- Added slash commands
    _G["SLASH_WOWUP1"] = WOWUP.addonManagerNameSlashCommand

    SlashCmdList["WOWUP"] = function()
        -- need to call it twice, due to a blizzard bug
        InterfaceOptionsFrame_OpenToCategory(MainFrame)
        InterfaceOptionsFrame_OpenToCategory(MainFrame)
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

