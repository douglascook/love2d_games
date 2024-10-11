local object = require 'classic'
local types = {}

function types.checkCollision(a, b)
  -- This is called AABB collision (Axis-Aligned Bounding Box)
  local aTop = a.y
  local aBottom = a.y + a.height
  local aLeft = a.x
  local aRight = a.x + a.width

  local bTop = b.y
  local bBottom = b.y + b.height
  local bLeft = b.x
  local bRight = b.x + b.width

  return aLeft <= bRight
      and aRight >= bLeft
      -- NOTE origin is **top** left, so this looks back to front
      and aTop <= bBottom
      and aBottom >= bTop
end

-- Rectangle
types.Rectangle = object:extend()

function types.Rectangle:new(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.speed = 400
end

function types.Rectangle:update(dt)
  -- Delta time is the time between screen updates. Multiply magnitude by delta time
  -- to ensure consistency across machines
  if love.keyboard.isDown('right') then
    self.x = (self.x + self.speed * dt) % 800
  elseif love.keyboard.isDown('left') then
    self.x = (self.x - self.speed * dt) % 800
  end

  if love.keyboard.isDown('up') then
    self.y = (self.y - self.speed * dt) % 600
  elseif love.keyboard.isDown('down') then
    self.y = (self.y + self.speed * dt) % 600
  end
end

function types.Rectangle:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

-- RandomRectangle
types.RandomRectangle = types.Rectangle:extend()

function types.RandomRectangle:new()
  local x = math.random(800)
  local y = math.random(600)
  local width = math.random(50, 200)
  local height = math.random(50, 200)

  types.RandomRectangle.super.new(self, x, y, width, height)
end

return types
