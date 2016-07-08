player = {} --TODO: comments

function player:init() --set basic player parameters
	ship = love.graphics.newImage("shship2.png") -- loads ship image
	
	--player.scale = 0.05
	player.scale = 1 --scales ship in case of different sprite sizes( 1 = same, >1 = bigger, <1 = smaller)
	player.width = ship:getWidth() * player.scale
	player.height = ship:getHeight() * player.scale
	player.x = screenWidth / 2
	player.y = screenHeight / 2
	player.rotation = 0
	player.goToX = player.x
	player.goToY = player.y
	player.rotate = 0
	player.fSpeed = 50
	player.rSpeed = 50
	
	centerX = screenWidth / 2 --sets center X position (with player centered)
	centerY = screenHeight / 2 --sets center Y position (with player centered)
end

function player:rotatePlayer(dr) -- rotate player  (SHOULD WORK. not tested yet)
	player.rotation = player.rotation + dr
end

function player:drawPlayer() --draw player (works, but my player sucks. pfff . . . at least it works)
	love.graphics.draw(ship, player.x, player.y, player.rotate, player.scale, player.scale, player.width / (2 * player.scale), player.height / (2 * player.scale)) --draws ship
end

function player:updatePlayer(dt) --update player (i need to improve movement and add rotation)
---[[
	if player.x < player.goToX --check if player should move forward
	then
		player.x = math.ceil(player.x + player.fSpeed * dt) --moves player forward depending on flight speed
	elseif player.x > player.goToX --check if player should move backward 
	then
		player.x = math.floor(player.x - player.fSpeed * dt) --moves player backward depending on flight speed
	end
	if player.y < player.goToY --check if player should move down
	then
		player.y = math.ceil(player.y + player.fSpeed * dt) --moves player down depending on flight speed
	elseif player.y > player.goToY --check if player should move up
	then
		player.y = math.floor(player.y - player.fSpeed * dt) --moves player up depending on flight speed
	end
--]]
	if player.rotation ~= player.rotate
	then
		if player.goToX < centerX
		then
			
		end
		if player.goToX == centerX
		then
			
		end
	end
	
	camera:setPosition(player.x - centerX, player.y - centerY) --centers camera on player
end

function player:goTo(coords) --stores coords where you are heading
	player.goToX = coords.x --sets target X coord
	player.goToY = coords.y --sets target Y coord
	player.rotate = math.atan2((coords.y - player.y), (coords.x - player.x)) + math.pi / 2 --calculates angle of rotation
end
