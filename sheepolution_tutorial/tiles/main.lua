function love.load()
  -- Change filter used for scaling to avoid blurry pixel art
  -- https://www.love2d.org/forums/viewtopic.php?t=80687
  love.graphics.setDefaultFilter("nearest")
  -- Filter needs to be changed BEFORE importing board - why?
  Board = require 'board'

  SEED = os.time()
  math.randomseed(SEED)

  TheBoard = Board({
    width = 20,
    height = 10,
    x_offset = 50,
    y_offset = 100,
    player = "wizard",
    player_x = 2,
    player_y = 2
  })
end

function love.update(dt)
end

function love.keypressed(key)
  for _ = 0, math.random(0, 3) do
    TheBoard:addMonster()
  end
  TheBoard:updatePlayer(key)
end

function love.draw()
  love.graphics.print("Seed = " .. SEED, 0, 0)
  TheBoard:draw()
end
