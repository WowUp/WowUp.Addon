local addonName, WOWUP = ...
local L = WOWUP.L
local CountTable = WOWUP.CountTable

local function OnClick()
    InterfaceOptionsFrame_OpenToCategory(addonName .. " " .. COMMUNITIES_NOTIFICATION_SETTINGS_DIALOG_SETTINGS_LABEL)
    InterfaceOptionsFrame_OpenToCategory(addonName .. " " .. COMMUNITIES_NOTIFICATION_SETTINGS_DIALOG_SETTINGS_LABEL)
end

local function OnEnter(self)
    local r, g, b, row = unpack(WOWUP_DATA.addonManagerColorRGB)
    local tooltip = WOWUP.LibQTip:Acquire(addonName .. "Tooltip", 5)
    self.tooltip = tooltip

    local header = WOWUP.CreateRGBToHexHeader(r, g, b)
    local availableAddonUpdates = CountTable(WOWUP_DATA.updateAddonsList)
    tooltip:AddHeader(header)
    tooltip:SetCell(tooltip:GetLineCount(), 1, header, nil, nil, tooltip:GetColumnCount())
    tooltip:AddSeparator(2, 1, 1, 1, 0)

    if availableAddonUpdates > 0 then
        local ttText = availableAddonUpdates > 1 and L["You have %d addons to be updated"]:format(availableAddonUpdates) or L["You have 1 addon to be updated"]
        tooltip:SetCell(tooltip:GetLineCount(), 1, ttText, nil, nil, tooltip:GetColumnCount())
        -- add a list of addons if a list ist there
        if WOWUP_DATA.updateAddonsList then
            tooltip:AddSeparator(5, 1, 1, 1, 0)
            for k, v in pairs(WOWUP_DATA.updateAddonsList) do
                if type(v) == "table" then
                    row = tooltip:AddLine(k, v[1] and v[1] or " ", "->", v[2] and v[2] or " ", " ")
                    tooltip:SetCellTextColor(row, 1, 1, 1, 1, 1)
                    tooltip:SetCellTextColor(row, 2, GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, 1)
                    tooltip:SetCellTextColor(row, 3, r, g, b, 1)
                    tooltip:SetCellTextColor(row, 4, r, g, b, 1)
                end
            end
        end
    else
        tooltip:AddHeader(L["All addons are up-to-date"])
        tooltip:SetLineTextColor(tooltip:GetLineCount(), 1, 1, 1, 1)
    end
    tooltip:AddSeparator(2, 1, 1, 1, 0)
    tooltip:AddLine(L["Click to open settings"])
    tooltip:SetLineTextColor(tooltip:GetLineCount(), 0.2, 1, 0.2, 1)

    tooltip:SmartAnchorTo(self)
    tooltip:Show()
end

local function OnLeave(self)
    WOWUP.LibQTip:Release(self.tooltip)
    self.tooltip = nil
end

local function createMinimapIcon()
    if WOWUP.icon and WowUpAddonInformation.showMinimapIcon then
        if not WowUpAddonInformationLDBIconDB then WowUpAddonInformationLDBIconDB = {} end

        WOWUP.minimapIcon = LibStub("LibDataBroker-1.1"):NewDataObject(addonName, {
            type = "data source",
            text = "",
            icon = WOWUP_DATA.icon and WOWUP_DATA.icon or "Interface/AddOns/WowUp/textures/ldbicon",
        })
        WOWUP.minimapIcon.OnClick = OnClick
        WOWUP.minimapIcon.OnEnter = OnEnter
        WOWUP.minimapIcon.OnLeave = OnLeave


        WOWUP.icon:Register(addonName, WOWUP.minimapIcon, WowUpAddonInformationLDBIconDB)
    end
end
WOWUP.createMinimapIcon = createMinimapIcon
