function love.load()
  Fireball = makeFireball()
  Cursor = love.graphics.newImage("assets/trump_surprised.png")
  -- Using image as cursor so hide os default cursor
  love.mouse.setVisible(false)
end

function love.update(dt)
  MouseX, MouseY = love.mouse.getPosition()

  local distance = getEuclideanDistance(Fireball.x, Fireball.y, MouseX, MouseY)

  if distance > 50 then
    local speed = Fireball.speed * distance / 50
    local angle = math.atan2(MouseY - Fireball.y, MouseX - Fireball.x)
    Fireball.angle = angle
    Fireball.x = Fireball.x + speed * dt * math.cos(angle)
    Fireball.y = Fireball.y + speed * dt * math.sin(angle)
  end
end

function love.draw()
  love.graphics.draw(Fireball.image, Fireball.x, Fireball.y,
    Fireball.angle, 0.5, 0.5, Fireball.offset_x, Fireball.offset_y
  )

  local scale = 0.2
  love.graphics.draw(Cursor,
    MouseX - (scale * Cursor:getWidth() / 2), MouseY - (scale * Cursor:getHeight() / 2), 0, 0.2, 0.2
  )
end

function makeFireball()
  local fireball = {}
  fireball.x = math.random(0, 800)
  fireball.y = math.random(0, 600)
  fireball.image = love.graphics.newImage("assets/fireball.png")
  fireball.offset_x = fireball.image:getWidth() / 2
  fireball.offset_y = fireball.image:getHeight() / 2
  fireball.angle = 0
  fireball.speed = 80
  return fireball
end

function getEuclideanDistance(x1, y1, x2, y2)
  return math.sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end
