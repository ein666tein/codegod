_esp = { }
_esp.__index = _esp

function _esp:WorldToScreen(pos)
    local x, y = client.WorldToScreen(pos[1], pos[2], pos[3])

    if x ~= nil and y ~= nil then
        return { x, y }
    end

    return nil
end

function _esp:get_bounding_box(player)
    local screen_pos, pos_3d, screen_top, top_3d
	local duck_amt = player:GetPropFloat("m_flDuckAmount")
    local angels = player:GetPropFloat("m_angEyeAngles[0]")
    
    pos_3d = { player:GetAbsOrigin() }
    pos_3d[3] = pos_3d[3] - 3
 
    top_3d = { player:GetAbsOrigin() }
	top_3d[3] = top_3d[3] + 79 - 14 * duck_amt - angels / 89 * 3

    screen_pos, screen_top = _esp:WorldToScreen(pos_3d), _esp:WorldToScreen(top_3d)
    if screen_pos ~= nil and screen_top ~= nil then
        local height = screen_pos[2] - screen_top[2]
        local width = height / 2.2
 
        local left = screen_pos[1] - width / 2
        local right = (screen_pos[1] - width / 2) + width
        local top = screen_top[2] + width / 5
        local bottom = screen_top[2] + height
 
        return { left = left, right = right, top = top, bottom = bottom }
    end
 
    return nil
end

function _esp:text(text, pos, centered, shadow, font, color, offset)
    draw.Color(color[1], color[2], color[3], color[4])
    draw.SetFont(font)

    if pos ~= nil then
        local x, y = pos[1], pos[2]
        if (centered) then
            local w, h = draw.GetTextSize(text)
            if offset ~= nil then
                x = x - w / 2 + offset
            else
                x = x - w / 2
            end
        end

        if (shadow) then
            draw.TextShadow(x, y, text)
        else
            draw.Text(x, y, text)
        end
    end
end

function _esp:rect_outline(pos1, pos2, color, outline_color)
    draw.Color(color[1], color[2], color[3], color[4])
    draw.OutlinedRect(pos1[1], pos1[2], pos2[1], pos2[2])
 
    draw.Color(outline_color[1], outline_color[2], outline_color[3], outline_color[4])
    draw.OutlinedRect(pos1[1] - 1, pos1[2] - 1, pos2[1] + 1, pos2[2] + 1)
    draw.OutlinedRect(pos1[1] + 1, pos1[2] + 1, pos2[1] - 1, pos2[2] - 1)
end
 
function _esp:rect_fill(pos1, pos2, color)
    draw.Color(color[1], color[2], color[3], color[4])
    draw.FilledRect(pos1[1], pos1[2], pos2[1], pos2[2])
end