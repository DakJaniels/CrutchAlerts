CrutchAlerts = CrutchAlerts or {}
local Crutch = CrutchAlerts


---------------------------------------------------------------------
-- Caustic Carrion
---------------------------------------------------------------------

-------------
-- Carrion UI
local BAR_MAX = 10

local function AddCarrionBarNotches()
    local width = CrutchAlertsCausticCarrion:GetWidth() / BAR_MAX
    for i = 0, BAR_MAX do
        local notch = WINDOW_MANAGER:CreateControl("$(parent)Notch" .. tostring(i), CrutchAlertsCausticCarrion, CT_BACKDROP)
        notch:SetEdgeColor(0, 0, 0, 0)
        notch:SetDrawLayer(2)

        if (i == 0) then
            -- Annoying edge
            notch:SetAnchor(TOPLEFT, CrutchAlertsCausticCarrion, TOPLEFT, width * i - 2, -4)
            notch:SetAnchor(BOTTOMRIGHT, CrutchAlertsCausticCarrion, BOTTOMLEFT, width * i - 1, 4)
            notch:SetCenterColor(0.9, 0.9, 0.9, 0.8)
        elseif (i == 5) then
            notch:SetAnchor(TOPLEFT, CrutchAlertsCausticCarrion, TOPLEFT, width * i - 1, -4)
            notch:SetAnchor(BOTTOMRIGHT, CrutchAlertsCausticCarrion, BOTTOMLEFT, width * i + 1, 4)
            notch:SetCenterColor(0.9, 0.9, 0.9, 0.8)
        elseif (i == BAR_MAX) then
            -- Annoying edge
            notch:SetAnchor(TOPLEFT, CrutchAlertsCausticCarrion, TOPLEFT, width * i, -4)
            notch:SetAnchor(BOTTOMRIGHT, CrutchAlertsCausticCarrion, BOTTOMLEFT, width * i + 2, 4)
            notch:SetCenterColor(0.9, 0.9, 0.9, 0.8)
        else
            if (i % 2 == 0) then
                notch:SetAnchor(TOPLEFT, CrutchAlertsCausticCarrion, TOPLEFT, width * i - 1, -4)
                notch:SetAnchor(BOTTOMRIGHT, CrutchAlertsCausticCarrion, BOTTOMLEFT, width * i, 4)
                notch:SetCenterColor(0.7, 0.7, 0.7, 0.8)
            else
                notch:SetAnchor(TOPLEFT, CrutchAlertsCausticCarrion, TOPLEFT, width * i - 1, 0)
                notch:SetAnchor(BOTTOMRIGHT, CrutchAlertsCausticCarrion, BOTTOMLEFT, width * i, 0)
                notch:SetCenterColor(0.7, 0.7, 0.7, 0.4)
            end
        end

        if (i % 2 == 0) then
            local label = WINDOW_MANAGER:CreateControl("$(parent)Label", notch, CT_LABEL)
            label:SetHorizontalAlignment(CENTER)
            label:SetAnchor(TOP, notch, BOTTOM, 0, 2)
            label:SetColor(0.8, 0.8, 0.8, 1)
            if (i < BAR_MAX) then
                label:SetText(tostring(i))
            else
                label:SetText(tostring(i) .. "+")
            end
        end
    end
end
Crutch.AddCarrionBarNotches = AddCarrionBarNotches

----------------
-- Carrion logic
local carrionStacks = {} -- {[tag] = {stacks = 4, tickTime = 1543,}}
local polling = false

-- Return keys in the order of highest stacks + closest to next tick
local function GetSortedCarrion()
    local sorted = {}
    for tag, data in pairs(carrionStacks) do
        local timeToTick = data.tickTime - GetGameTimeMilliseconds() % 2000
        if (timeToTick < 0) then timeToTick = timeToTick + 2000 end
        table.insert(sorted, {unitTag = tag, timeToTick = timeToTick, stacks = data.stacks})
    end

    table.sort(sorted, function(first, second)
        if (first.stacks == second.stacks) then
            return first.timeToTick < second.timeToTick
        end
        return first.stacks > second.stacks
    end)
    return sorted
end

-- Twins HM kills at 6 stacks, so turn it red at 5 (this color applies to nonHM too, which is probably fine for practice)
local regularThresholds = {8, 7}
local twinsThresholds = {5, 4}
local colorThresholds = regularThresholds

local function UpdateCarrionDisplay()
    local sorted = GetSortedCarrion()

    -- Individual stacks
    if (Crutch.savedOptions.osseincage.showCarrionIndividual) then
        local text = ""
        for _, data in ipairs(sorted) do
            local name = GetUnitDisplayName(data.unitTag)
            if (name) then
                text = string.format("%s%s%s(%s) - %d stacks; %dms to tick", text, text == "" and "" or "\n", name, data.unitTag, data.stacks, data.timeToTick)
            end
        end
        CrutchAlertsCausticCarrionText:SetText(text)
        CrutchAlertsCausticCarrionText:SetHidden(false)
    else
        CrutchAlertsCausticCarrionText:SetHidden(true)
    end

    -- Get the highest stacks
    if (#sorted > 0) then
        local highest = sorted[1]
        local progress = (2000 - highest.timeToTick) / 2000 + highest.stacks
        if (progress > colorThresholds[1]) then
            CrutchAlertsCausticCarrionBar:SetGradientColors(1, 0, 0, 1, 0.5, 0, 0, 1)
            CrutchAlertsCausticCarrionStacks:SetColor(1, 0, 0, 1)
        elseif (progress > colorThresholds[2]) then
            CrutchAlertsCausticCarrionBar:SetGradientColors(1, 1, 0, 1, 0.7, 0, 0, 1)
            CrutchAlertsCausticCarrionStacks:SetColor(1, 1, 0, 1)
        else
            ZO_StatusBar_SetGradientColor(CrutchAlertsCausticCarrionBar, ZO_XP_BAR_GRADIENT_COLORS)
            CrutchAlertsCausticCarrionStacks:SetColor(1, 1, 1, 1)
        end

        ZO_StatusBar_SmoothTransition(CrutchAlertsCausticCarrionBar, progress, BAR_MAX)
        CrutchAlertsCausticCarrionStacks:SetText(string.format("%.1f", math.floor(progress * 10) / 10))
    else
        ZO_StatusBar_SmoothTransition(CrutchAlertsCausticCarrionBar, 0, BAR_MAX)
        CrutchAlertsCausticCarrionStacks:SetText("0")
        CrutchAlertsCausticCarrionStacks:SetColor(1, 1, 1, 1)
    end
end

local function OnCausticCarrion(_, changeType, _, _, unitTag, beginTime, endTime, stackCount, _, _, _, _, _, _, _, abilityId)
    if (abilityId == 241089) then
        colorThresholds = twinsThresholds
    else
        colorThresholds = regularThresholds
    end

    if (changeType == EFFECT_RESULT_FADED) then
        carrionStacks[unitTag] = nil

        -- Check if there are no more stacks
        if (polling) then
            for _, _ in pairs(carrionStacks) do
                return -- Continue polling
            end
            polling = false
            EVENT_MANAGER:UnregisterForUpdate(Crutch.name .. "CarrionPoll")
            UpdateCarrionDisplay()
        end
        return
    end
    local tickRemainder = GetGameTimeMilliseconds() % 2000
    carrionStacks[unitTag] = {stacks = stackCount, tickTime = tickRemainder}

    if (not polling) then
        polling = true
        EVENT_MANAGER:RegisterForUpdate(Crutch.name .. "CarrionPoll", 90, UpdateCarrionDisplay)
    end
end


---------------------------------------------------------------------
-- Stricken
---------------------------------------------------------------------
-- EVENT_EFFECT_CHANGED (number eventCode, MsgEffectResult changeType, number effectSlot, string effectName, string unitTag, number beginTime, number endTime, number stackCount, string iconName, string buffType, BuffEffectType effectType, AbilityType abilityType, StatusEffectType statusEffectType, string unitName, number unitId, number abilityId, CombatUnitType sourceType)
local function OnStricken(_, changeType, _, _, unitTag, beginTime, endTime)
    local atName = GetUnitDisplayName(unitTag)
    local tagNumber = string.gsub(unitTag, "group", "")
    local tagId = tonumber(tagNumber)
    local fakeSourceUnitId = 8880100 + tagId -- TODO: really gotta rework the alerts and stop hacking around like this

    -- Gained
    if (changeType == EFFECT_RESULT_GAINED) then
        if (Crutch.savedOptions.general.showRaidDiag) then
            Crutch.msg(zo_strformat("<<1>> got Stricken", atName))
        end

        -- Event is not registered if NEVER, so the only other option is TANK
        if (Crutch.savedOptions.osseincage.showStricken == "ALWAYS" or GetSelectedLFGRole() == LFG_ROLE_TANK) then
            local label = zo_strformat("|ca361ff<<C:1>>: <<2>>|r", GetAbilityName(235594), atName)
            Crutch.DisplayNotification(235594, label, (endTime - beginTime) * 1000, fakeSourceUnitId, 0, 0, 0, false)
        end

    -- Faded
    elseif (changeType == EFFECT_RESULT_FADED) then
        if (Crutch.savedOptions.general.showRaidDiag) then
            Crutch.msg(zo_strformat("<<1>> is no longer Stricken", atName))
        end

        Crutch.Interrupted(fakeSourceUnitId)
    end
end


---------------------------------------------------------------------
-- Icons for Dominator's Chains
---------------------------------------------------------------------
-- Chains start off with an initial debuff, 232773 and 232775
-- 4 seconds later, the real tether starts, 232780 and 232779. The initial debuff fades immediately after
-- We need to account for the possibility of someone dying during the 4 seconds,
-- which means the tether doesn't cast

local chainsDisplaying1, chainsDisplaying2 -- unit tag of player if there is some kind of chains on them

local UNSAFE = 20 -- Chains have red effect when under 20m
local SUS = 25
local SAFE = 30 -- Arbitrary number just for the constant
local prevInThreshold = UNSAFE
local function ChangeLineColor(distance)
    if (distance <= UNSAFE) then
        if (prevInThreshold == UNSAFE) then
            return -- No change, still red
        end
        prevInThreshold = UNSAFE
        Crutch.SetLineColor(1, 0, 0, 0.5, 0.5, Crutch.savedOptions.debugLineDistance)
    elseif (distance <= SUS) then
        if (prevInThreshold == SUS) then
            return -- No change, still yellow
        end
        prevInThreshold = SUS
        Crutch.SetLineColor(1, 1, 0, 0.4, 0.4, Crutch.savedOptions.debugLineDistance)
    else
        if (prevInThreshold == SAFE) then
            return -- No change, still green
        end
        prevInThreshold = SAFE
        Crutch.SetLineColor(0, 1, 0, 0.3, 0.3, Crutch.savedOptions.debugLineDistance)
    end
end

local function AddChainToPlayer(unitTag)
    if (chainsDisplaying1 == unitTag or chainsDisplaying2 == unitTag) then
        -- If this is the same player, do nothing because it's already displaying
        return
    end

    local iconPath = "esoui/art/trials/vitalitydepletion.dds"

    Crutch.dbgSpam(string.format("Setting |t100%%:100%%:%s|t for %s", iconPath, GetUnitDisplayName(unitTag)))
    Crutch.SetMechanicIconForUnit(GetUnitDisplayName(unitTag), iconPath, 100, {1, 0, 1})


    if (not chainsDisplaying1) then
        -- If no one has chains yet, consider this the first one and save it for later
        chainsDisplaying1 = unitTag
    else
        -- If the other player has already received it, we can draw the line
        chainsDisplaying2 = unitTag
        prevInThreshold = UNSAFE
        Crutch.SetLineColor(1, 0, 0, 0.4, 0.4, Crutch.savedOptions.debugLineDistance)
        Crutch.DrawLineBetweenPlayers(chainsDisplaying1, unitTag, ChangeLineColor)
    end
end
Crutch.AddChainToPlayer = AddChainToPlayer -- /script CrutchAlerts.AddChainToPlayer("group1") CrutchAlerts.AddChainToPlayer("group2")

-- Completely remove it from both players, and remove the line
local function RemoveChain()
    Crutch.RemoveLine()
    Crutch.RemoveMechanicIconForUnit(GetUnitDisplayName(chainsDisplaying1))
    Crutch.RemoveMechanicIconForUnit(GetUnitDisplayName(chainsDisplaying2))
    chainsDisplaying1 = nil
    chainsDisplaying2 = nil
end

local tethered = {} -- Anyone who has the real tether. [@name] = true
local function OnChainsInitial(_, changeType, _, _, unitTag)
    if (changeType == EFFECT_RESULT_GAINED) then
        -- Show the icons and line as soon as the initial debuff starts
        AddChainToPlayer(unitTag)
    elseif (changeType == EFFECT_RESULT_FADED) then
        -- When it fades, check if the real tether is already up. If yes, do nothing.
        if (tethered[unitTag]) then
            return
        end

        -- If not, then the player died before the actual tether appeared, so remove the icons
        RemoveChain()
    end
end

-- The actual tether when it's active
local function OnChainsTether(_, changeType, _, _, unitTag)
    if (changeType == EFFECT_RESULT_GAINED) then
        tethered[unitTag] = true
        AddChainToPlayer(unitTag) -- This shouldn't be needed, but idk, do it anyway
    elseif (changeType == EFFECT_RESULT_FADED) then
        tethered[unitTag] = nil
        RemoveChain()
    end
end


---------------------------------------------------------------------
-- Font shenanigans
---------------------------------------------------------------------
local KEYBOARD_STYLE = {
    thickFont = "$(BOLD_FONT)|20|soft-shadow-thick",
    individualFont = "ZoFontGame",
    notchFont = "ZoFontGameSmall",
}

local GAMEPAD_STYLE = {
    thickFont = "ZoFontGamepad27",
    individualFont = "ZoFontGamepad18",
    notchFont = "ZoFontGamepad18",
}

local function ApplyStyle(style)
    CrutchAlertsCausticCarrionStacks:SetFont(style.thickFont)

    CrutchAlertsCausticCarrionTitle:SetFont(style.thickFont)
    CrutchAlertsCausticCarrionTitle:SetHeight(100)
    CrutchAlertsCausticCarrionTitle:SetHeight(CrutchAlertsCausticCarrionTitle:GetTextHeight())

    CrutchAlertsCausticCarrionText:SetFont(style.individualFont)

    for i = 0, BAR_MAX do
        if (i % 2 == 0) then
            local label = CrutchAlertsCausticCarrion:GetNamedChild("Notch" .. tostring(i) .. "Label")
            label:SetFont(style.notchFont)
        end
    end
end

local initialized = false
local function InitFont()
    if (initialized) then return end
    initialized = true

    ZO_PlatformStyle:New(ApplyStyle, KEYBOARD_STYLE, GAMEPAD_STYLE)
end


---------------------------------------------------------------------
-- Register/Unregister
---------------------------------------------------------------------
local carrionFragment

function Crutch.RegisterOsseinCage()
    Crutch.dbgOther("|c88FFFF[CT]|r Registered Ossein Cage")
    InitFont()

    -- Caustic Carrion
    if (Crutch.savedOptions.osseincage.showCarrion) then
        if (not carrionFragment) then
            carrionFragment = ZO_SimpleSceneFragment:New(CrutchAlertsCausticCarrion)
        end
        HUD_SCENE:AddFragment(carrionFragment)
        HUD_UI_SCENE:AddFragment(carrionFragment)

        Crutch.RegisterExitedGroupCombatListener("ExitedCombatCarrion", function() carrionStacks = {} end)

        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "CausticCarrionRegular", EVENT_EFFECT_CHANGED, OnCausticCarrion)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "CausticCarrionRegular", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 240708)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "CausticCarrionRegular", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")

        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "CausticCarrionBoss2", EVENT_EFFECT_CHANGED, OnCausticCarrion)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "CausticCarrionBoss2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 241089)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "CausticCarrionBoss2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")
    end

    -- Stricken (tank swap)
    if (Crutch.savedOptions.osseincage.showStricken ~= "NEVER") then
        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "Stricken", EVENT_EFFECT_CHANGED, OnStricken)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "Stricken", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "Stricken", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 235594)
    end

    -- Icons/line for Dominator's Chains
    if (Crutch.savedOptions.osseincage.showChains) then
        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "ChainsInitial1", EVENT_EFFECT_CHANGED, OnChainsInitial)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsInitial1", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 232773)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsInitial1", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")

        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "ChainsInitial2", EVENT_EFFECT_CHANGED, OnChainsInitial)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsInitial2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 232775)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsInitial2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")

        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "ChainsTether1", EVENT_EFFECT_CHANGED, OnChainsTether)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsTether1", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 232779)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsTether1", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")

        EVENT_MANAGER:RegisterForEvent(Crutch.name .. "ChainsTether2", EVENT_EFFECT_CHANGED, OnChainsTether)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsTether2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, 232780)
        EVENT_MANAGER:AddFilterForEvent(Crutch.name .. "ChainsTether2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group")
    end
end

function Crutch.UnregisterOsseinCage()
    Crutch.UnregisterExitedGroupCombatListener("ExitedCombatCarrion")
    if (carrionFragment) then
        HUD_SCENE:RemoveFragment(carrionFragment)
        HUD_UI_SCENE:RemoveFragment(carrionFragment)
    end

    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "CausticCarrionRegular", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "CausticCarrionBoss2", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "Stricken", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "ChainsInitial1", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "ChainsInitial2", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "ChainsTether1", EVENT_EFFECT_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(Crutch.name .. "ChainsTether2", EVENT_EFFECT_CHANGED)

    Crutch.dbgOther("|c88FFFF[CT]|r Unregistered Ossein Cage")
end
