container = {}
container.__index = container

local objects = {"planet", "enemy"}

function container:init() --initialize all variables and stuff
	--do i need this? idk
end

function container:add(object, name, x, y, radius, rotation) --adds planet to objects
	--if objects[object] == "planet"
	--then
		local pos = container:check(name, x, y) --finds position of object in container
		if pos == nil --creates new if not found
		then		
			table.insert(container, {name = name, x = x, y = y, radius = radius or 150, rotation = rotation or 10}) --adds object
			--return tostring(name .. " " .. tostring(x) .. " " .. tostring(y) .. " " .. tostring(radius)) --dbg msg
			return tostring(true)
		end
		return tostring(false)
	--end
end

function container:delete(object, x, y) --removes planet from objects
	local pos = container:check("", x, y) --finds position of object in container
	if pos ~= nil --deletes old if found
	then
		table.remove(container, pos) --removes object
		return tostring(pos) --dbg msg
	end
	return tostring(pos) --dbg msg
end

function container:draw(x, y, width, height) --draws all visible objects
	if table.getn(container) == 0 --check if there are any objects
	then
		return --do nothing if no objects
	end

	for pos, value in ipairs(container) --iterate all objects
	do
		if value.x + value.radius >= x and value.x <= x + width --check if objects is visible with X coord
		then
			if value.y + value.radius >= y and value.y <= y + height --check if objects is visible with Y coord
			then
				love.graphics.print(value.name .. " " .. tostring(value.x) .. " " .. tostring(value.y) .. " " .. tostring(value.radius), value.x - value.radius / 2, value.y + value.radius + 15) --prints planet info under it
				love.graphics.setColor(value.x % 254, value.y % 255, value.radius % 50) --sets planet to green
				love.graphics.circle("fill", value.x, value.y, value.radius) --draws planet
			end
		end
	end
end

function container:update(dt, x, y, width, height) --draws all visible objects
	if table.getn(container) == 0 --check if there are any objects
	then
		return --do nothing if no objects
	end

	for pos, value in ipairs(container) --iterate all objects
	do
		if value.x + value.radius >= x and value.x <= x + width --check if objects is visible with X coord
		then
			if value.y + value.radius >= y and value.y <= y + height --check if objects is visible with Y coord
			then
				--update_planet() --updates visible object
			end
		end
	end
end

function container:check(name, x, y)
	if table.getn(container) == 0 --check if there are any objects
	then
		return nil --empty container
	end
	
	for pos, value in ipairs(container) --iterate all objects
	do
		if name ~= ""
		then
			if value.name == name --check for planet with same name
			then
				return pos -- returns number of object
			end
		end
		if value.y + value.radius >= y and value.y - value.radius <= y --check for planet with Y collision
		then
			if value.x + value.radius >= x and value.x - value.radius <= x --check for planet with X collision
			then
				return pos -- returns number of object
			end
			return value.y --no match
		end
		return nil --no match
	end
end