WowUpTexts = {
    ['Okay'] = 'Okay',
    ['updateNotification'] = 'WowUp Notification: You have %d addon(s) to be updated',
    ['noUpdatesNotification'] = 'WowUp Notification: all addons are up-to-date',
    ['slashCommandNoArguments'] = 'To use use /wowup, you must pass the option name and then 1 or 0 to enable the option. Use "/wowup list" to show all options. Use /wowup reset to reset all options to their default value.',
    ['slashCommandInvalidArguments'] = 'Invalid command arguments given.',
    ['slashCommandExplainList'] = 'The following options can be used with 1 or 0 to turn it on or off. Pass no 1 or 0 to see its current value.',
    ['slashCommandOptionEnabled'] = '%s is now enabled.',
    ['slashCommandOptionDisabled'] = '%s is now disabled.',
    ['slashCommandOptionValue'] = '%s: has a value of "%s".',
    ['slashCommandOptionReset'] = 'All options have been reset to their default value.',
}
local locale = GetLocale()

if locale == 'ruRU' then
    WowUpTexts.Okay = 'Окей'
    WowUpTexts.updateNotification = 'Уведомление от WowUp: У вас есть %d модификаций нуждающихся в обновлении'
end
