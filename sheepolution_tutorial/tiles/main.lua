function love.load()
  -- Change filter used for scaling to avoid blurry pixel art
  -- https://www.love2d.org/forums/viewtopic.php?t=80687
  love.graphics.setDefaultFilter("nearest")

  -- Filter needs to be changed BEFORE importing board - why?
  local Board_ = require "board"
  Fireball = require "fireball"

  WindowHeight = love.graphics.getHeight()
  WindowWidth = love.graphics.getWidth()

  SEED = os.time()
  math.randomseed(SEED)

  Board = Board_({
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

    local x, y = Board:gridCoordFromPixel(f.x, f.y)
    local tile = Board.map[y][x]

    -- If a monster is hit by a fireball then destroy it.
    for j, m in ipairs(Board.monsters) do
      if x == m.x and y == m.y then
        table.remove(Board.monsters, j)
        break
      end
    end

    -- Stop at wall, or off screen.
    if string.sub(tile, 0, 4) == "tree" or f:isOOB() then
      table.remove(Fireballs, i)
    end
  end
end

function love.keypressed(key)
  if key == "up" or key == "down" or key == "left" or key == "right" then
    for _ = 0, math.random(0, 3) do
      if not Board:isFull() then
        Board:addMonster()
      end
    end

    Board:updatePlayer(key)
  end

  if key == "space" then
    local x, y = Board:pixelCoordFromGrid(Board.player_x, Board.player_y)
    local fireball = Fireball(x, y, Board.player_direction)
    table.insert(Fireballs, fireball)
  end
end

function love.draw()
  love.graphics.print("Seed = " .. SEED, 0, 0)
  love.graphics.print("Fireballs = " .. #Fireballs, 0, 20)
  Board:draw()

  for _, f in ipairs(Fireballs) do
    f:draw(Board.scaling)
  end
end
