local playerAttackData = {}

AddEventHandler('weaponDamageEvent', function(sender, data)
    local unarmedHash = 2725352035
    local customWeaponHash = 133987706
    if not playerAttackData[sender] then
        playerAttackData[sender] = { lastAttacks = {}, banned = false }
    end

    if data.weaponType == customWeaponHash then
        CancelEvent()
    end
    local attackData = playerAttackData[sender]
    local currentTime = os.time()

    if data.weaponType == customWeaponHash or (data.weaponType == unarmedHash and data.damageTime > 200000 and data.weaponDamage > 200) then
        handleBan(sender, Config.getBanReason("script"))
        CancelEvent()
    end

    if data.weaponType == unarmedHash then
        table.insert(attackData.lastAttacks, currentTime)

        for i = #attackData.lastAttacks, 1, -1 do
            if currentTime - attackData.lastAttacks[i] > 1 then
                table.remove(attackData.lastAttacks, i)
            end
        end

        if #attackData.lastAttacks >= 5 then
            if not attackData.banned then
                handleBan(sender, Config.getBanReason("rapid"))
                attackData.banned = true
            end
            CancelEvent()
            return
        end
    end

    if data.weaponType == unarmedHash and data.weaponDamage > 50 then
        handleBan(sender, Config.getBanReason("expdamage"))
        CancelEvent()
    end
end)

