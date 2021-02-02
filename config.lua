local addonName, WOWUP = ...
local L = WOWUP.L
local newCheckbox = WOWUP.newCheckbox

WOWUP_DATA = WOWUP_DATA or {}

-- default settings
local WowUpOptions = {
    showPopupNotification = true,
    showPopupNotificationList = true,
    showChatNotification = true,
    showChatNotificationList = true,
    showMinimapIcon = true,
}

local function setOptions()
    for optionName, optionDefaultValue in pairs(WowUpOptions) do
        if not WowUpAddonInformation[optionName] == nil then
            WowUpAddonInformation[optionName] = optionDefaultValue
        end
    end
end

local function SetUpSettings()
    -- load libs
    WOWUP.LibQTip = LibStub("LibQTip-1.0", true)
    WOWUP.icon = LibStub("LibDBIcon-1.0", true)

    -- ensure saved variable is in a usable state
    if not WowUpAddonInformation then
        WowUpAddonInformation = WowUpOptions
    end

    setOptions()

    local MainFrame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer)
    MainFrame.name = addonName .. " " .. COMMUNITIES_NOTIFICATION_SETTINGS_DIALOG_SETTINGS_LABEL

    MainFrame.title = MainFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    MainFrame.title:SetPoint("TOPLEFT", 16, -16)
    MainFrame.title:SetText(addonName)

    MainFrame.popupNotificationCheckbox = newCheckbox("Option1",
            L["Show a popup with a notification after loading when updates are available"],
            "",
            function(self, value)
                WowUpAddonInformation.showPopupNotification = value
                self:GetParent().popupNotificationListCheckbox:SetEnabled(value)
            end,
            MainFrame
    )
    MainFrame.popupNotificationCheckbox:SetChecked(WowUpAddonInformation.showPopupNotification)
    MainFrame.popupNotificationCheckbox:SetPoint("TOPLEFT", MainFrame.title, "BOTTOMLEFT", -2, -16)

    MainFrame.popupNotificationListCheckbox = newCheckbox("Option2",L["Show a list of all addons to be updated in a popup notification"], "", function(self, value) WowUpAddonInformation.showPopupNotificationList = value end, MainFrame)
    MainFrame.popupNotificationListCheckbox:SetChecked(WowUpAddonInformation.showPopupNotificationList)
    MainFrame.popupNotificationListCheckbox:SetPoint("TOPLEFT", MainFrame.popupNotificationCheckbox, "BOTTOMLEFT", 20, -8)

    MainFrame.chatNotificationCheckbox = newCheckbox("Option3",
            L["Show a chat message indicating whether or not updates are available"],
            "",
            function(self, value)
                WowUpAddonInformation.showChatNotification = value
                self:GetParent().chatNotificationListCheckbox:SetEnabled(value)
            end,
            MainFrame
    )
    MainFrame.chatNotificationCheckbox:SetChecked(WowUpAddonInformation.showChatNotification)
    MainFrame.chatNotificationCheckbox:SetPoint("TOPLEFT", MainFrame.popupNotificationListCheckbox, "BOTTOMLEFT", -20, -8)

    MainFrame.chatNotificationListCheckbox = newCheckbox("Option4", L["Show a list of all addons to be updated in a chat message"], "", function(self, value) WowUpAddonInformation.showChatNotificationList = value end, MainFrame)
    MainFrame.chatNotificationListCheckbox:SetChecked(WowUpAddonInformation.showChatNotificationList)
    MainFrame.chatNotificationListCheckbox:SetPoint("TOPLEFT", MainFrame.chatNotificationCheckbox, "BOTTOMLEFT", 20, -8)

    MainFrame.MinimapIconCheckbox = newCheckbox("Option5",
            L["Show Minimap icon"],
            "",
            function(self, value)
                WowUpAddonInformation.showMinimapIcon = value
                if value then
                    if not WOWUP.icon:IsRegistered(addonName) then
                        if not WowUpAddonInformationLDBIconDB then WowUpAddonInformationLDBIconDB = {} end
                        WOWUP.icon:Register(addonName, WOWUP.minimapIcon, WowUpAddonInformationLDBIconDB)
                    end
                    WOWUP.icon:Show(addonName)
                else
                    WOWUP.icon:Hide(addonName)
                end
            end,
            MainFrame
    )
    MainFrame.MinimapIconCheckbox:SetChecked(WowUpAddonInformation.showMinimapIcon)
    MainFrame.MinimapIconCheckbox:SetPoint("TOPLEFT", MainFrame.chatNotificationListCheckbox, "BOTTOMLEFT", -20, -8)

    InterfaceOptions_AddCategory(MainFrame)

    -- create slash commands
    if WOWUP_DATA.addonManagerNameSlashCommand then
        _G["SLASH_WOWUP1"] = WOWUP_DATA.addonManagerNameSlashCommand

        SlashCmdList["WOWUP"] = function()
            -- need to call it twice, due to a blizzard bug
            InterfaceOptionsFrame_OpenToCategory(addonName .. " " .. COMMUNITIES_NOTIFICATION_SETTINGS_DIALOG_SETTINGS_LABEL)
            InterfaceOptionsFrame_OpenToCategory(addonName .. " " .. COMMUNITIES_NOTIFICATION_SETTINGS_DIALOG_SETTINGS_LABEL)
        end
    end

    -- create minimap icon
    WOWUP.createMinimapIcon()
end
WOWUP.SetUpSettings = SetUpSettings
