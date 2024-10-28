local tile_size = 16
local sheet = love.graphics.newImage("assets/kenney_1bit/Tilesheet/colored-transparent.png")

local function selectQuad(x, y)
  return love.graphics.newQuad(x * (tile_size + 1), y * (tile_size + 1), tile_size, tile_size, sheet)
end

-- NOTE these are 0-based
local types = {
  tree1 = selectQuad(0, 1),
  tree2 = selectQuad(1, 1),
  tree3 = selectQuad(2, 1),

  wizard = selectQuad(24, 1),
  fire = selectQuad(15, 10),

  bat = selectQuad(26, 8),
  slime = selectQuad(27, 8),
  serpent = selectQuad(28, 8),
  croc = selectQuad(29, 8),
}

local function getRandomMonster()
  local monsters = { "bat", "slime", "serpent", "croc" }
  return monsters[math.random(1, 4)]
end

return {
  sheet = sheet,
  types = types,
  tile_size = tile_size,
  getRandomMonster = getRandomMonster
}
