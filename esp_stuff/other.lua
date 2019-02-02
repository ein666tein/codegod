_misc = { }
_misc.__index = _misc

function _misc:round(b, c)
    local d = 10 ^ (c or 0)
    return math.floor(b * d + 0.5) / d
end

function _misc:round_to_fifth(num)
    num = _misc:round(num, 0)
    num = num / 5
    num = _misc:round(num, 0)
    num = num * 5

    return math.floor(num)
end

function _misc:get_feet_dst(a_x, a_y, a_z, b_x, b_y, b_z)
    return _misc:round_to_fifth(math.ceil(math.sqrt((a_x - b_x)^2 + (a_y - b_y)^2 + (a_z - b_z)^2) * 0.0254 / 0.3048))
end

function _misc:get_weapon_name(ent, handle)
    if handle ~= nil then
        local weapon_name = handle:GetClass()
        weapon_name = weapon_name:gsub("CWeapon", "")
        weapon_name = weapon_name:gsub("CKnife", "knife")
        weapon_name = weapon_name:lower()

        if weapon_name:sub(1, 1) == "c" then 
            weapon_name = weapon_name:sub(2)
        end

        if ent:GetWeaponID() == 64 then 
            weapon_name = "revolver"
        end

        if ent:GetWeaponID() == 61 then 
            weapon_name = "usp silencer"
        end

        return weapon_name
    end

    return nil
end

function _misc:is_sniper(weapon)
    return (weapon:match("ssg08") or weapon:match("awp") or weapon:match("scar20") or weapon:match("g3sg1"))
end

function _misc:is_valid(ent, menu)
    local entlocal = entities.GetLocalPlayer()

    local team_ent = ent:GetIndex()
    local team_local = entlocal:GetTeamNumber()
    local is_enemy = (team_local ~= team_ent)

    if entlocal == nil or team_ent == team_local then
        return false
    end

    return (is_enemy or not is_enemy and menu:get("main", "teammates"))
end