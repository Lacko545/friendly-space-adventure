container = {}

require("planet")

function container:init() --initialize all variables and stuff
	--do i need this? idk
end

function container:add(name, x, y, radius, rotation) --adds planet to objects
	local pos = self:check(name, x, y) --finds position of object in container
	if pos == nil --creates new if not found
	then
		local plnt = planet:new(tostring(name), x, y, radius, rotation) --creates new planet
		table.insert(self, plnt) --adds object
		return tostring(true) --dbg msg
	end
	return tostring(false) --dbg msg
end

function container:delete(x, y) --removes planet from objects
	local pos = self:check("", x, y) --finds position of object in container
	if pos ~= nil --deletes old if found
	then
		table.remove(self, pos) --removes object
		return tostring(true) --dbg msg
	end
	return tostring(false) --dbg msg
end

function container:draw(x, y, width, height) --draws all visible objects
	if table.getn(self) == 0 --check if there are any objects
	then
		return --do nothing if no objects
	end

	for pos, value in ipairs(self) --iterate all objects
	do
		if value.x + value.radius >= x and value.x <= x + width --check if objects is visible with X coord
		then
			if value.y + value.radius >= y and value.y <= y + height --check if objects is visible with Y coord
			then
				value:draw() --draws visible object
			end
		end
	end
end

function container:update(dt, x, y, width, height) --draws all visible objects
	if table.getn(self) == 0 --check if there are any objects
	then
		return --do nothing if no objects
	end

	for pos, value in ipairs(self) --iterate all objects
	do
		if value.x + value.radius >= x and value.x <= x + width --check if objects is visible with X coord
		then
			if value.y + value.radius >= y and value.y <= y + height --check if objects is visible with Y coord
			then
				value.update(dt) --updates visible object
			end
		end
	end
end

function container:check(name, x, y)
	if table.getn(self) == 0 --check if there are any objects
	then
		return nil --empty container
	end
	
	for pos, value in ipairs(container) --iterate all objects
	do
		if value.name == name --check for planet with same name
		then
			return pos -- returns number of object
		elseif value.x + value.radius >= x and value.x - value.radius <= x --check for planet with X collision
		then
			if value.y + value.radius >= y and value.y - value.radius <= y --check for planet with Y collision
			then
				return pos -- returns number of object
			end
			return nil --no match
		elseif value.y + value.radius >= y and value.y - value.radius <= y --check for planet with Y collision
		then
			if value.x + value.radius >= x and value.x - value.radius <= x --check for planet with X collision
			then
				return pos -- returns number of object
			end
			return nil --no match
		else
			return nil --no match
		end
	end
end