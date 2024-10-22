function love.load()
  -- Change filter used for scaling to avoid blurry pixel art
  -- https://www.love2d.org/forums/viewtopic.php?t=80687
  love.graphics.setDefaultFilter("nearest")

  Tiles = require 'tiles'
  Board = require 'board'

  TheBoard = Board(170, 150)
  Player = Tiles.selectQuad(24, 1)
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
  TheBoard:drawMap()
  TheBoard:drawTile(PlayerX, PlayerY, Player)
end
