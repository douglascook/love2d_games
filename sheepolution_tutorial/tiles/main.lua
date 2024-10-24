function love.load()
  -- Change filter used for scaling to avoid blurry pixel art
  -- https://www.love2d.org/forums/viewtopic.php?t=80687
  love.graphics.setDefaultFilter("nearest")

  SEED = os.time()
  math.randomseed(SEED)

  Tiles = require 'tiles'
  Board = require 'board'

  TheBoard = Board(20, 10, 50, 100)
  PLAYER = "wizard"
  PlayerX = 2
  PlayerY = 2
end

function love.update()
end

function love.keypressed(key)
  local x = PlayerX
  local y = PlayerY

  if key == "right" then
    x = x + 1
  elseif key == "left" then
    x = x - 1
  elseif key == "down" then
    y = y + 1
  elseif key == "up" then
    y = y - 1
  end

  -- Only move if destination tile is unoccupied
  if not TheBoard:isOccupied(x, y) then
    PlayerX = x
    PlayerY = y
  end
end

function love.draw()
  love.graphics.print("Seed = " .. SEED, 0, 0)

  TheBoard:drawMap()
  TheBoard:drawTile(PlayerX, PlayerY, PLAYER)
end
