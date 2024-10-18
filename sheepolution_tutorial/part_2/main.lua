function love.load()
  -- Using image as cursor so hide os default cursor
  love.mouse.setVisible(false)
  Cursor = require 'cursor'
  Jumping = require 'jumping'
end

function love.update(dt)
  Cursor.updateFireball(dt)
  Jumping.updateFrame(dt)
end

function love.draw()
  Cursor.draw()
  Jumping.draw(500, 300)
end
