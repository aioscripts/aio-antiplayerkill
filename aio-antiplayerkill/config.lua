Config = {}
local config = {
    banType = "fiveguard",
    language = "tr", -- Default language: 'en' (English)
}

local banReasons = {
    en = {
        script = "Scripted kill player attempt",
        rapid = "Rapid unarmed punches detected",
        expdamage = "Excessive unarmed damage",
    },
    tr = {
        script = "Oyuncuya yönelik hileli öldürme girişimi",
        rapid = "Hızlı silahsız yumruklar tespit edildi",
        expdamage = "Aşırı silahsız hasar",

    },
    es = {
        script = "Intento de asesinato con script",
        rapid = "Se detectaron golpes rápidos sin armas",
        expdamage = "Daño excesivo sin armas",
    },
}

 function Config.getBanReason(reasonKey)
    local reasons = banReasons[config.language] or banReasons["en"] 
    return reasons[reasonKey] or reasonKey 
end

function handleBan(sender, reason)
    if config.banType == "fiveguard" then
         exports["name"]:fg_BanPlayer(sender, reason, true)
        print(sender, reason)
    elseif config.banType == "custom" then
        DropPlayer(sender, reason)
        else
        -- print("Ban type not configured correctly!")
    end
end