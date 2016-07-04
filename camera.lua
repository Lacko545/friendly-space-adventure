camera = {} --TODO: comments

function camera:init() --initialize camera location
	camera.x = 0 --left top x coord
	camera.y = 0 --left top y coord
	camera.scaleX = 1 --scale for x coord (used for zooming)
	camera.scaleY = 1 --scale for y coord (used for zooming)
	camera.rotation = 0 --rotation of camera
end

function camera:set() --sets camera
  love.graphics.push() --puches frame to stack
  love.graphics.rotate(-camera.rotation) --rotates it (will we even rotate camera for flying, or just player and move on X and Y axes?)
  love.graphics.scale(1 / camera.scaleX, 1 / camera.scaleY) --scales camera (no zooming for now)
  love.graphics.translate(-camera.x, -camera.y) --moves all coordinates to supplied location
end

function camera:unset() --unsets camera
  love.graphics.pop() --removes frame from stack
end

function camera:move(dx, dy) --move camera
  camera.x = camera.x + (dx or 0) --move X coord
  camera.y = camera.y + (dy or 0) --move Y coord
end

function camera:rotate(dr) --rotate camera
  camera.rotation = camera.rotation + dr -- rotates camera with actual + delta of rotation. not supply full rotation
end

function camera:scale(sx, sy) --scale camera (increase / decrease by ammount)
  sx = sx or 1 --sets x scale to specified or default 1
  camera.scaleX = camera.scaleX * sx --scales X axis
  camera.scaleY = camera.scaleY * (sy or sx) -- scales Y axis
end

function camera:setPosition(x, y) --sets camera position
  camera.x = x or camera.x --sets X position
  camera.y = y or camera.y --sets Y position
end

function camera:setScale(sx, sy) --sets camera scale (instantly to supplied value)
  camera.scaleX = sx or camera.scaleX --set X axis scale
  camera.scaleY = sy or camera.scaleY --set Y axis scale
end

function camera:getMousePos(x, y) --return mouse coordinates deppending on camera cooridnates
	local mouse = {x = x, y = y} --sets coordinates based on screen
	mouse.x = math.floor(mouse.x + camera.x) --adds X coordinate of camera
	mouse.y = math.floor(mouse.y + camera.y) --adds X coordinate of camera
	return mouse --return mouse coordinates based on camera
end