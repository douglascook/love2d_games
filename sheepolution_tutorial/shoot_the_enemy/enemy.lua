local Enemy = Object:extend()

function Enemy:new()
  self.imageAlive = love.graphics.newImage("assets/trump_angry.png")
  self.imageDead = love.graphics.newImage("assets/trump_surprised.png")
  self.image = self.imageAlive

  self.scale = 1
  self.width = self.image:getWidth() * self.scale
  self.height = self.image:getHeight() * self.scale

  self.x = WindowWidth - self.width
  self.y = WindowHeight / 2
  self.speed = 200
end

function Enemy:update(dt)
  self.y = self.y + self.speed * dt

  -- Change direction once window boundary is hit
  if self.y <= 0 then
    self.y = 0
    self.speed = -self.speed
  elseif self.y >= WindowHeight - self.height then
    self.y = WindowHeight - self.height
    self.speed = -self.speed
  end
end

function Enemy:handleCollision()
  if self.speed == 0 then
    self.speed = 200
    self.image = self.imageAlive
  end

  -- Speed up if it's been hit
  if self.speed > 0 then
    self.speed = self.speed + 50
  else
    self.speed = self.speed - 50
  end

  if self.speed >= 500 or self.speed <= -500 then
    self.speed = 0
    self.image = self.imageDead
  end
end

function Enemy:draw()
  -- Images can be flipped by setting scale to a negative value
  -- See  https://www.love2d.org/forums/viewtopic.php?t=9511
  love.graphics.draw(self.image, self.x, self.y, 0, -1 * self.scale, self.scale, self.width, 0)
end

return Enemy
