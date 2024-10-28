local Object = require "classic"
local Tiles = require "tiles"

local Fireball = Object:extend()

function Fireball:new(x, y, direction)
  self.x = x
  self.y = y
  self.direction = direction

  self.tile_type = "fire"
  self.speed = 200
end

function Fireball:update(dt)
  if self.direction == "right" then
    self.x = self.x + self.speed * dt
  elseif self.direction == "left" then
    self.x = self.x - self.speed * dt
  elseif self.direction == "down" then
    self.y = self.y + self.speed * dt
  else
    self.y = self.y - self.speed * dt
  end
end

function Fireball:isOOB()
  return self.x < 0 or self.x >= WindowWidth or self.y < 0 or self.y >= WindowHeight
end

function Fireball:draw(scale)
  love.graphics.draw(
    Tiles.sheet, Tiles.types[self.tile_type], self.x, self.y,
    0, scale, scale)
end

return Fireball
