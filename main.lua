local format = string.format
local pairs = pairs
local print = print

local WowUpOptions = {
    ['showPopupNotification'] = true,
    ['showChatNotification'] = true,
}

SLASH_WOWUP1 = '/wowup'

local FixOptions = function (overwriteToDefault)
    for optionName, optionDefaultValue in pairs(WowUpOptions) do
        if overwriteToDefault or WowUpAddonInformation[optionName] == nil then
            WowUpAddonInformation[optionName] = optionDefaultValue
        end
    end
end

function SlashCmdList.WOWUP(msg)
    if msg == '' then
        return print(WowUpTexts.slashCommandNoArguments)
    end

    local matches = {}
    local i = 0
    for match in msg:gmatch('%S+') do
        i = i + 1
        matches[i] = match
    end

    if matches[1] == 'list' then
        print(WowUpTexts.slashCommandExplainList)
        for k in pairs(WowUpOptions) do
            print(' - ' .. k)
        end
        return
    elseif matches[1] == 'reset' then
        FixOptions(true);
        print(WowUpTexts.slashCommandOptionReset)
        return
    end

    for optionName in pairs(WowUpOptions) do
        if optionName == matches[1] then
            if matches[2] == '1' then
                WowUpAddonInformation[optionName] = true
                print(format(WowUpTexts.slashCommandOptionEnabled, optionName))
            elseif matches[2] == '0' then
                WowUpAddonInformation[optionName] = false
                print(format(WowUpTexts.slashCommandOptionDisabled, optionName))
            else
                local displayValue = '1'
                if (WowUpAddonInformation[optionName] == false) then
                    displayValue = '0'
                end
                print(format(WowUpTexts.slashCommandOptionValue, optionName, displayValue))
            end
            return
        end
    end

    return print(WowUpTexts.slashCommandInvalidArguments)
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

    -- show notification
    local message = format(WowUpTexts.updateNotification, updatesAvailableCount)
    if WowUpAddonInformation.showChatNotification then
        if updatesAvailableCount > 0 then
            print(message)
        else
            print(WowUpTexts.noUpdatesNotification)
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
