require("camera")  --create camera
require("player")  --create player
require("container")  --create container for game objects

function love.load()
	gamestate = "playing" --gamestate, for future purposes, skipped implementing for now. fuck me, got bigger problems
	screenWidth = love.graphics.getWidth() --canvas width
	screenHeight = love.graphics.getHeight() --canvas height
	
	errormsg = "" --dbg message holder
	
	container:init() --sets container stuff
	camera:init()
	player:init() --sets player stuff
end

function love.draw()
	love.graphics.setColor(100, 100, 100) --background color. le space
	
	love.graphics.print(tostring(player.x), 20, 20)
	love.graphics.print(tostring(player.y), 20, 50)
	love.graphics.print(tostring(player.forward.x), 160, 20)
	love.graphics.print(tostring(player.forward.y), 160, 50)
	love.graphics.print(tostring(player.goToX), 290, 20)
	love.graphics.print(tostring(player.goToY), 290, 50)
	love.graphics.print(tostring(player.rotation * 180 / math.pi), 390, 20)
	love.graphics.print(tostring(player.rotateTo * 180 / math.pi), 390, 50)
	
	camera:set() --sets camera
	
		--love.graphics.setColor(255, 0, 0) --dbg code
		love.graphics.print(errormsg, 50, 50) --dbg code

	container:draw(camera.x, camera.y, screenWidth, screenHeight) --draw all game objects

	player:drawPlayer() --draw player stuff
	
	camera:unset() --unsets camera
	
	love.graphics.rectangle("fill", screenWidth / 2 - 5, screenHeight / 2 - 5, 10, 10)
end

function love.update(dt)
	player:updatePlayer(dt) --updates player
	
	if love.mouse.isDown(1) --left mouse button
	then
		mouse = camera:getMousePos(love.mouse.getX(), love.mouse.getY()) --calculate coordinates dependent on camera
	end
	
	if love.mouse.isDown(2) --right mouse button
	then
		mouse = camera:getMousePos(love.mouse.getX(), love.mouse.getY(), screenWidth, screenHeight) --calculate coordinates dependent on camera
		player:goTo(mouse) --set target coordinates for player
	end
	
	container:update(dt, camera.x, camera.y, screenWidth, screenHeight)
end

function love.keyreleased(key)
	if key == "escape"   --exit on escape, cos i am too lazy to click X everytime
	then
		love.event.quit() --aaaaand its over
	elseif key == "a" --add planet
	then
		mouse = camera:getMousePos(love.mouse.getX(), love.mouse.getY()) --calculate coordinates dependent on camera
		errormsg = container:add(1, "asd" .. tostring(math.random(10)), mouse.x, mouse.y, 150, 10) --adds planet (contains debugging code - result)
	elseif key == "d" --delete planet
	then
		mouse = camera:getMousePos(love.mouse.getX(), love.mouse.getY()) --calculate coordinates dependent on camera
		errormsg = container:delete(1, mouse.x, mouse.y) --deletes planet (contains debugging code - result)

	elseif key == "o" --add planet
	then
		mouse = camera:getMousePos(-10, -15) --test for drawind planet with center out of camera
		errormsg = container:add(1, "asd" .. tostring(math.random(10)), mouse.x, mouse.y, 150, 10) --adds planet (contains debugging code - result)

	end
end