WowUpTexts = {
    ['Okay'] = 'Okay',
    ['updateNotification'] = '%s Notification: You have %d addon(s) to be updated',
    ['noUpdatesNotification'] = '%s Notification: all addons are up-to-date',
    ['showPopupNotificationCheckboxText'] = 'Show a popup with a notification after loading when updates are available',
    ['showChatNotificationCheckboxText'] = 'Show a chat message indicating whether or not updates are available',
}
local locale = GetLocale()

if locale == 'ruRU' then
    WowUpTexts.Okay = 'Окей'
    WowUpTexts.updateNotification = 'Уведомление от %s: У вас есть %d модификаций нуждающихся в обновлении'
    WowUpTexts.noUpdatesNotification = 'Уведомление от %s: модификации не требуют обновления'
end
