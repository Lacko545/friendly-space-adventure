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
  love.graphics.rotate(-self.rotation) --rotates it (will we even rotate camera for flying, or just player and move on X and Y axes?)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY) --scales camera (no zooming for now)
  love.graphics.translate(-self.x, -self.y) --moves all coordinates to supplied location
end

function camera:unset() --unsets camera
  love.graphics.pop() --removes frame from stack
end

function camera:move(dx, dy) --move camera
  self.x = self.x + (dx or 0) --move X coord
  self.y = self.y + (dy or 0) --move Y coord
end

function camera:rotate(dr) --rotate camera
  self.rotation = self.rotation + dr -- rotates camera with actual + delta of rotation. not supply full rotation
end

function camera:scale(sx, sy) --scale camera (increase / decrease by ammount)
  sx = sx or 1 --sets x scale to specified or default 1
  self.scaleX = self.scaleX * sx --scales X axis
  self.scaleY = self.scaleY * (sy or sx) -- scales Y axis
end

function camera:setPosition(x, y) --sets camera position
  self.x = x or self.x --sets X position
  self.y = y or self.y --sets Y position
end

function camera:setScale(sx, sy) --sets camera scale (instantly to supplied value)
  self.scaleX = sx or self.scaleX --set X axis scale
  self.scaleY = sy or self.scaleY --set Y axis scale
end

function camera:getMousePos(x, y) --return mouse coordinates deppending on camera cooridnates
	local mouse = {x = x, y = y} --sets coordinates based on screen
	mouse.x = mouse.x + self.x --adds X coordinate of camera
	mouse.y = mouse.y + self.y --adds X coordinate of camera
	return mouse --return mouse coordinates based on camera
end