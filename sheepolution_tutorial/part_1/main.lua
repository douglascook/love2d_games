-- Thanks Sheepolution! https://www.sheepolution.com/learn/book/contents
local theRectangles = {}
local fruits = {}

function love.load()
  Tick = require 'tick'
  Rectangle = require 'rectangle'

  fruits = { "melon", "orange", "lychee" }
  table.insert(fruits, "passion fruit")
  -- Removing item from a table shifts all following members up one
  table.remove(fruits, 1)

  -- how to unpack this into width and height of window? below doesn't work
  -- height, width = table.unpack(love.graphics.getDimensions())

  ShowCircle = false
  -- Tick can be used to schedule functions to run after some time period
  Tick.recur(function() ShowCircle = not ShowCircle end, 1)

  Trex = love.graphics.newImage('assets/trex.png')
end

function love.keypressed(key)
  if key == 'space' then
    local rect = Rectangle.RandomRectangle()
    table.insert(theRectangles, rect)
  end
end

function love.update(dt)
  Tick.update(dt)

  for _, rect in ipairs(theRectangles) do
    -- REMEMBER need to call methods with : so that self is passed
    rect:update(dt)
  end
end

function love.draw()
  love.graphics.draw(Trex, 100, 100, 0, 0.5, 0.5)

  love.graphics.draw(Trex, 200, 200, 1.55, 0.5, 0.5, 0, 0)
  love.graphics.draw(
    Trex, 200, 200, 1.55, 0.5, 0.5,
    Trex:getWidth() / 2, Trex:getHeight() / 2
  )

  if ShowCircle then
    -- setColor sets the colour of everything that is drawn, until changed again
    love.graphics.setColor(1, 50 / 255, 50 / 255, 0.5)
    love.graphics.circle('fill', 400, 300, 200)
    love.graphics.setColor(1, 1, 1)
  end

  for _, rect in ipairs(theRectangles) do
    rect:draw()
  end

  -- for i=1,#fruits do
  for i, f in ipairs(fruits) do
    love.graphics.print(f, 100, i * 100)
  end
end
