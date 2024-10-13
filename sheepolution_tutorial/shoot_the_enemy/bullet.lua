local Bullet = Object:extend()

function Bullet:new(x, y)
  self.image = love.graphics.newImage("assets/fireball.png")
  self.scale = 0.25
  self.width = self.image:getWidth() * self.scale
  self.height = self.image:getHeight() * self.scale

  self.x = x
  self.y = y
  self.speed = 600
end

function Bullet:update(dt)
  self.x = self.x + self.speed * dt
end

function Bullet:dead()
  return self.x + self.width >= WindowWidth
end

function Bullet:draw()
  love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end

return Bullet
