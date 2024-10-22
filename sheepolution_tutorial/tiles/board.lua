Object = require 'classic'
Tiles = require 'tiles'

local Board = Object:extend()

function Board:new(width, height, x_offset, y_offset)
  self.x_offset = x_offset
  self.y_offset = y_offset
  self.scaling = 2

  self.map = self:generateMap(width, height)
end

function Board:generateMap(width, height)
  local map = {}

  -- Empty map with border
  for i = 1, height do
    local row = {}
    for j = 1, width do
      local tile = 0
      if i == 1 or i == height or j == 1 or j == width then
        tile = 1
      end
      table.insert(row, tile)
    end
    table.insert(map, row)
  end

  -- Fill in some walls
  for _ = 1, math.random(6, height * width / 6) do
    -- Player starts at 2,2 so don't draw any walls there
    -- REMEMBER indexes are 1 based!
    local row = 2
    local col = 2
    while row == 2 or col == 2 do
      row = math.random(2, height - 1)
      col = math.random(2, width - 1)
    end

    map[row][col] = math.random(2, 3)
  end

  return map
end

function Board:drawMap()
  for i, row in ipairs(self.map) do
    for j, tile in ipairs(row) do
      if tile ~= 0 then
        -- Lua arrays are 1-based(!!)
        self:drawTile(j, i, Tiles.types[tile])
      end
    end
  end
end

function Board:drawTile(x, y, quad)
  x = self.x_offset + (x * self.scaling * Tiles.tile_size)
  y = self.y_offset + (y * self.scaling * Tiles.tile_size)
  love.graphics.draw(Tiles.sheet, quad, x, y, 0, self.scaling, self.scaling)
end

function Board:isOccupied(x, y)
  return self.map[y][x] ~= 0
end

return Board
