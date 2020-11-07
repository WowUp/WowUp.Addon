local format = string.format
local pairs = pairs
local print = print

local WowUpOptions = {
    ['showPopupNotification'] = true,
    ['showChatNotification'] = true,
}

local FixOptions = function (overwriteToDefault)
    for optionName, optionDefaultValue in pairs(WowUpOptions) do
        if overwriteToDefault or WowUpAddonInformation[optionName] == nil then
            WowUpAddonInformation[optionName] = optionDefaultValue
        end
    end
end

WowUpOptionsFrame = nil;
showPopupNotificationCheckbox = nil
showChatNotificationCheckbox = nil

SLASH_WOWUP1 = addonManagerNameSlashCommand
function SlashCmdList.WOWUP()
end

local frame = CreateFrame('frame')
frame:RegisterEvent('ADDON_LOADED')

function frame:OnEvent(event, addonName)
    if event ~= "ADDON_LOADED" or addonName ~= 'WowUp' then
        return
    end

    -- ensure saved variable is in a usable state
    if not WowUpAddonInformation then
        WowUpAddonInformation = WowUpOptions
    end

    FixOptions(false);

    showChatNotificationCheckbox:SetChecked(WowUpAddonInformation.showChatNotification)
    showPopupNotificationCheckbox:SetChecked(WowUpAddonInformation.showPopupNotification)

    -- show notification
    local message = format(WowUpTexts.updateNotification, addonManagerName, updatesAvailableCount)
    if WowUpAddonInformation.showChatNotification then
        if updatesAvailableCount > 0 then
            print(message)
        else
            print(format(WowUpTexts.noUpdatesNotification, addonManagerName))
        end
    end

    if WowUpAddonInformation.showPopupNotification and updatesAvailableCount > 0 then
        StaticPopupDialogs['WowUp_ShowUpdatesAvailable'] = {
            text = message,
            button1 = WowUpTexts.Okay,
            timeout = 0,
            whileDead = false,
            hideOnEscape = true,
            preferredIndex = 3,
        }

        StaticPopup_Show('WowUp_ShowUpdatesAvailable')
    end
end

frame:SetScript('OnEvent', frame.OnEvent);

function showPopupNotificationCheckbox_OnLoad(checkbox)
    checkbox.type = CONTROLTYPE_CHECKBOX
    checkbox.Text:SetText(' ' .. WowUpTexts.showPopupNotificationCheckboxText);
    checkbox:SetHitRectInsets(0, -(checkbox.Text:GetWidth() + 20), 0, 0)
    showPopupNotificationCheckbox = checkbox
end

function showChatNotificationCheckbox_OnLoad(checkbox)
    checkbox.type = CONTROLTYPE_CHECKBOX
    checkbox.Text:SetText(' ' .. WowUpTexts.showChatNotificationCheckboxText);
    checkbox:SetHitRectInsets(0, -(checkbox.Text:GetWidth() + 20), 0, 0)
    showChatNotificationCheckbox = checkbox
end

function showPopupNotificationCheckbox_OnClick(checkbox)
    WowUpAddonInformation.showPopupNotification = checkbox:GetChecked()
end

function showChatNotificationCheckbox_OnClick(checkbox)
    WowUpAddonInformation.showChatNotification = checkbox:GetChecked()
end

function WowUpOptionsPanel_OnLoad(optionsFrame)
    optionsFrame.name = addonManagerName .. ' Notifications'
    InterfaceOptions_AddCategory(optionsFrame);
    WowUpOptionsFrame = optionsFrame
end
