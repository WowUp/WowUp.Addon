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

if locale == 'deDE' then
    WowUpTexts.Okay = 'Okay'
    WowUpTexts.updateNotification = '%s Hinweis: Du hast %d Addon(s), die aktualisiert werden können. Öffne WowUp um deine Addons zu aktualisieren.'
    WowUpTexts.noUpdatesNotification = '%s Hinweis: Alle deine Addons sind auf dem neusten Stand.'
end
