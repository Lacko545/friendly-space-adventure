player = {} --TODO: comments

function player:init() --set basic player parameters
	player.width = 10
	player.height = 10
	player.x = screenWidth / 2 - player.width
	player.y = screenHeight / 2 - player.height
	player.goToX = player.x
	player.goToY = player.y
	player.fSpeed = 50
	player.rSpeed = 50
	player.rotation = 0
end

function player:movePlayer(dx, dy) --move player (SHOULD WORK. not tested yet)
	player.x = player.x + (dx or 0)
	player.y = player.y + (dy or 0)
end

function player:rotatePlayer(dr) -- rotate player  (SHOULD WORK. not tested yet)
  player.rotation = player.rotation + dr
end

function player:drawPlayer() --draw player (works, but my player sucks. pfff . . . at least it works)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", player.x-5, player.y-5, player.width, player.height) --body of spaceship
	love.graphics.polygon("fill",player.x+5, player.y-5, player.x+5, player.y+5, player.x+10, player.y) --front of spaceship
end

function player:updatePlayer(dt) --update player (i need to rework movement and rotation as its not working now)
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
	camera:setPosition(player.x - centerX, player.y - centerY) --centers camera on player
end

function player:goTo(coords) --stores coords where you are heading
	player.goToX = coords.x --sets target X coord
	player.goToY = coords.y --sets target Y coord
end