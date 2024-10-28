local Object = require 'classic'
local Tiles = require 'tiles'
local Monster = require 'monster'

local Board = Object:extend()

function Board:new(args)
  self.width = args.width
  self.height = args.height
  self.area = args.width * args.height
  self.x_offset = args.x_offset
  self.y_offset = args.y_offset
  self.scaling = 2

  self.map, self.wall_count = self:generateMap(args.width, args.height)

  self.player = args.player
  self.player_x = args.player_x
  self.player_y = args.player_y
  self.player_direction = "right"

  self.monsters = {}
end

function Board:generateMap(width, height)
  local map = {}
  -- External walls
  local wall_count = 2 * (width + height) - 4

  -- Empty map with border
  for i = 1, height do
    local row = {}
    for j = 1, width do
      local tile = "empty"
      if i == 1 or i == height or j == 1 or j == width then
        tile = "tree1"
      end
      table.insert(row, tile)
    end
    table.insert(map, row)
  end

  -- Fill in some walls
  local internal_wall_count = math.floor(math.random(self.area / 10, self.area / 6))
  wall_count = wall_count + internal_wall_count

  for _ = 1, internal_wall_count do
    -- Player starts at 2,2 so don't draw any walls there
    -- REMEMBER indexes are 1 based!
    local row = 2
    local col = 2
    while row == 2 or col == 2 do
      row = math.random(2, height - 1)
      col = math.random(2, width - 1)
    end

    -- Can't index directly into a table literal. See https://stackoverflow.com/q/19331262
    local trees = { "tree2", "tree3" }
    map[row][col] = trees[math.random(1, 2)]
  end

  return map, wall_count
end

function Board:draw()
  self:drawMap()
  self:drawPlayer()
  self:drawMonsters()
end

function Board:drawMap()
  for i, row in ipairs(self.map) do
    for j, tile in ipairs(row) do
      if tile ~= "empty" then
        -- Lua arrays are 1-based(!!)
        self:drawTile(j, i, tile)
      end
    end
  end
end

function Board:drawPlayer()
  self:drawTile(self.player_x, self.player_y, self.player)
end

function Board:updatePlayer(key)
  local x = self.player_x
  local y = self.player_y

  if key == "right" then
    x = x + 1
  elseif key == "left" then
    x = x - 1
  elseif key == "down" then
    y = y + 1
  elseif key == "up" then
    y = y - 1
  else
    -- Should be guarded against in main love.keypressed
    error("Unexpected key")
  end
  self.player_direction = key

  -- Only move if destination tile is unoccupied
  if not self:isOccupied(x, y) then
    self.player_x = x
    self.player_y = y
  end
end

function Board:addMonster()
  local x = 1
  local y = 1
  while self:isOccupied(x, y) do
    x = math.random(2, self.width - 1)
    y = math.random(2, self.height - 1)
  end

  local monster = Monster(x, y)
  table.insert(self.monsters, monster)
end

function Board:drawMonsters()
  for _, m in ipairs(self.monsters) do
    self:drawTile(m.x, m.y, m.tile, m.colour)
  end
end

function Board:drawTile(x, y, tile, colour)
  if colour ~= nil then
    love.graphics.setColor(colour)
  end

  x, y = self:pixelCoordFromGrid(x, y)
  love.graphics.draw(Tiles.sheet, Tiles.types[tile], x, y, 0, self.scaling, self.scaling)

  -- Reset
  love.graphics.setColor({ 1, 1, 1 })
end

function Board:pixelCoordFromGrid(x, y)
  local x_pixel = self.x_offset + (x * self.scaling * Tiles.tile_size)
  local y_pixel = self.y_offset + (y * self.scaling * Tiles.tile_size)
  return x_pixel, y_pixel
end

function Board:isOccupied(x, y)
  -- Tile is a wall
  if self.map[y][x] ~= "empty" then
    return true
    -- Player is on the tile
  elseif x == self.player_x and y == self.player_y then
    return true
  else
    -- Monster is on the tile
    for _, m in ipairs(self.monsters) do
      if x == m.x and y == m.y then
        return true
      end
    end
  end

  return false
end

-- FIXME this isn't working for the final batch, returns true before really full
function Board:isFull()
  -- Walls, plus monsters, plus player
  return self.wall_count + #self.monsters + 1 == self.area
end

return Board
