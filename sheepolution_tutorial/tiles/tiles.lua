local tile_size = 16
local sheet = love.graphics.newImage("assets/kenney_1bit/Tilesheet/colored-transparent.png")

local function selectQuad(x, y)
  return love.graphics.newQuad(x * (tile_size + 1), y * (tile_size + 1), tile_size, tile_size, sheet)
end

local types = {
  selectQuad(0, 1),
  selectQuad(1, 1),
  selectQuad(2, 1),
}

return {
  sheet = sheet,
  types = types,
  tile_size = tile_size,
  selectQuad = selectQuad
}
