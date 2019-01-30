images_lib = {}
images_lib.__index = images_lib
images_lib.textures = { }

function images_lib:generate_textures()
    for name, data in pairs(_icons) do

        if images_lib.textures[name] then
            local img_rgba, width, height = common.RasterizeSVG(data[3])
            draw.UpdateTexture(images_lib.textures[name][3], img_rgba)
        else
            local img_rgba, width, height = common.RasterizeSVG(data[3])
            local texture = draw.CreateTexture(img_rgba, width, height)

            images_lib.textures[name] = { width / 2, height / 2, texture, img_rgba }
        end
    end
end

function images_lib:draw_texture(pos, color, data)
    local x, y = pos[1], pos[2]
    x = x - data[1] / 2

    draw.SetTexture(data[3])

    draw.Color(color[1], color[2], color[3], color[4])
    draw.FilledRect(x, y, x + data[1], y + data[2])
end

return images_lib