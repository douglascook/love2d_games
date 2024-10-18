local TILESIZE = 16
local X_ORIGIN = 100
local Y_ORIGIN = 100

function love.load()
  Tilemap = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 2, 2, 0, 0, 3, 0, 1 },
    { 1, 0, 0, 2, 2, 0, 0, 3, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  }
  TileSheet = love.graphics.newImage("assets/kenney_1bit/Tilesheet/colored-transparent.png")
  TileTypes = {
    love.graphics.newQuad(0, 17, TILESIZE, TILESIZE, TileSheet),
    love.graphics.newQuad(17, 17, TILESIZE, TILESIZE, TileSheet),
    love.graphics.newQuad(34, 17, TILESIZE, TILESIZE, TileSheet),
  }
  Player = love.graphics.newQuad(24 * 17, 17, TILESIZE, TILESIZE, TileSheet)
  PlayerX = X_ORIGIN + 2 * TILESIZE
  PlayerY = Y_ORIGIN + 2 * TILESIZE
end

function love.update()
end

-- TODO this should operate on grid without worrying about tilesize
function love.keypressed(key)
  local original_x = PlayerX
  local original_y = PlayerY

  if key == "right" then
    PlayerX = PlayerX + TILESIZE
  elseif key == "left" then
    PlayerX = PlayerX - TILESIZE
  elseif key == "down" then
    PlayerY = PlayerY + TILESIZE
  elseif key == "up" then
    PlayerY = PlayerY - TILESIZE
  end

  -- Can't move through occupied tiles
  if Tilemap[(PlayerY - Y_ORIGIN) / TILESIZE][(PlayerX - X_ORIGIN) / TILESIZE] ~= 0 then
    PlayerY = original_y
    PlayerX = original_x
  end
end

function love.draw()
  for i, row in ipairs(Tilemap) do
    local y = Y_ORIGIN + i * TILESIZE

    for j, tile in ipairs(row) do
      if tile ~= 0 then
        local x = X_ORIGIN + j * TILESIZE
        -- Lua arrays are 1-based(!!)
        love.graphics.draw(TileSheet, TileTypes[tile], x, y)
      end
    end
  end

  love.graphics.draw(TileSheet, Player, PlayerX, PlayerY)
end
