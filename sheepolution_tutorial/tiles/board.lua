Object = require 'classic'
Tiles = require 'tiles'

local Board = Object:extend()

-- TODO specify separate x and y offsets - would require scale method rethink
function Board:new(x_offset, y_offset)
  self.x_offset = x_offset
  self.y_offset = y_offset
  self.scaling = 2

  self.map = {
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 0, 0, 2, 2, 0, 0, 3, 0, 1 },
    { 1, 0, 0, 2, 2, 0, 0, 3, 0, 1 },
    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
  }
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

function Board:scale(value)
end

function Board:isOccupied(x, y)
  return self.map[y][x] ~= 0
end

return Board
