function love.load()
  -- Change filter used for scaling to avoid blurry pixel art
  -- https://www.love2d.org/forums/viewtopic.php?t=80687
  love.graphics.setDefaultFilter("nearest")

  -- Filter needs to be changed BEFORE importing board - why?
  Board = require "board"
  Fireball = require "fireball"

  WindowHeight = love.graphics.getHeight()
  WindowWidth = love.graphics.getWidth()

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

  Fireballs = {}
end

function love.update(dt)
  for i, f in ipairs(Fireballs) do
    f:update(dt)

    if f:isOOB() then
      table.remove(Fireballs, i)
    end
  end
end

function love.keypressed(key)
  if key == "up" or key == "down" or key == "left" or key == "right" then
    for _ = 0, math.random(0, 3) do
      if not TheBoard:isFull() then
        TheBoard:addMonster()
      end
    end

    TheBoard:updatePlayer(key)
  end

  if key == "space" then
    local x, y = TheBoard:pixelCoordFromGrid(TheBoard.player_x, TheBoard.player_y)
    local fireball = Fireball(x, y, TheBoard.player_direction)
    table.insert(Fireballs, fireball)
  end
end

function love.draw()
  love.graphics.print("Seed = " .. SEED, 0, 0)
  love.graphics.print("Fireballs = " .. #Fireballs, 0, 20)
  TheBoard:draw()

  for _, f in ipairs(Fireballs) do
    f:draw(TheBoard.scaling)
  end
end
