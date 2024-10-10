local object = require 'classic'
local types = {}

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
  print('draw method')
  print(self.width)
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
