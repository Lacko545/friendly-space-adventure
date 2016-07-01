planet = {}
planet.__index = planet

function planet:new(name, x, y, radius, rotation) --create planet
	--local self = setmetatable({}, planet)

	--basic planet values START
	self.name = name
	self.x = x
	self.y = y
	self.radius = radius or 150
	self.rotation = rotation or 10
	--basic planet values END

	return self
end

function planet:draw()	--draw planet
	love.graphics.setColor(0, 255, 50) --sets planet to green
	love.graphics.circle("fill", self.x, self.y, self.radius) --draws planet
	love.graphics.print(self.name .. " " .. tostring(self.x) .. " " .. tostring(self.y) .. " " .. tostring(self.radius), self.x - self.radius / 2, self.y + self.radius + 15) --prints planet info under it
end

function planet:update(dt)	--update planet
	--what should planet even do?
end