player = {} --TODO: comments

function player:init() --set basic player parameters
	ship = love.graphics.newImage("shship2.png") -- loads ship image
	
	--player.scale = 0.05
	player.scale = 1 --scales ship in case of different sprite sizes( 1 = same, >1 = bigger, <1 = smaller)
	player.width = ship:getWidth() * player.scale
	player.height = ship:getHeight() * player.scale
	player.x = screenWidth / 2
	player.y = screenHeight / 2
	player.goToX = player.x
	player.goToY = player.y
	player.rotateTo = 0
	player.fSpeed = 80
	player.manuverablity = 0.9
	player.fRotSpeed = player.fSpeed * player.manuverablity
	player.rSpeed = 1.5
	
	player.forward = {} --forward vector
	player.forward.x = player.x + 0 --forward vector X
	player.forward.y = player.y - 1 --forward vector Y
	
	player.rotation = player:getVectorRotation(player.forward) --sets default player rotation
	
	centerX = screenWidth / 2 --sets center X position (with player centered)
	centerY = screenHeight / 2 --sets center Y position (with player centered)
end

function player:drawPlayer() --draw player
	love.graphics.draw(ship, player.x, player.y, player.rotation, player.scale, player.scale, player.width / (2 * player.scale), player.height / (2 * player.scale)) --draws ship
end

function player:movePlayer(dt) --moves and rotates player
	player.rotateTo = player:getVectorRotation({x = player.goToX, y = player.goToY}) --gets target rotation
	player.rotation = player:getVectorRotation(player.forward) --calculates player rotation
	
	local rotDiff = player.rotateTo - player.rotation
	if rotDiff < 0
	then
		rotDiff = rotDiff + math.pi*2
	end
	
	if rotDiff > 0.05
	then
		if rotDiff < math.pi
		then
			player.forward = player:rotateVector(player.forward, -player.rSpeed * dt)
			player:fixRotation()
		else
			player.forward = player:rotateVector(player.forward, player.rSpeed * dt)
			player:fixRotation()
		end
		local moveX = (player.forward.x - player.x) * player.fRotSpeed * dt
		local moveY = (player.forward.y - player.y) * player.fRotSpeed * dt
	
		--player.x = player.x - moveX
		--player.y = player.y - moveY
			
		--player.forward.x = player.forward.x - moveX
		--player.forward.y = player.forward.y - moveY
	else
		local moveX = (player.forward.x - player.x) * player.fSpeed * dt
		local moveY = (player.forward.y - player.y) * player.fSpeed * dt
	
		--player.x = player.x - moveX
		--player.y = player.y - moveY
			
		--player.forward.x = player.forward.x - moveX
		--player.forward.y = player.forward.y - moveY
	end
end


function player:fixShaking() --fixes shaking that is caused by floating part of coordinates
	if player.goToX - player.x < 1 --check if distance to target is less than 1 point
	then
		player.x = math.floor(player.x) --fix shaking because of floating part of position
	elseif player.x - player.goToX < 1 --check if distance to target is less than 1 point
	then
		player.x = math.ceil(player.x) --fix shaking because of floating part of position
	end
	
	if player.goToY - player.y < 1 --check if distance to target is less than 1 point
	then
		player.y = math.ceil(player.y) --fix shaking because of floating part of position
	elseif player.y - player.goToY < 1 --check if distance to target is less than 1 point
	then
		player.y = math.floor(player.y) --fix shaking because of floating part of position
	end
end

function player:fixRotation()
	if player.rotation * 180 / math.pi - player.rotateTo * 180 / math.pi < 1
	then
		player.rotateTo = player.rotation
	end
end

function player:updatePlayer(dt) --update player (movement is prety good, neet to add rotation and combine them)

	if player.goToX ~= player.x -- checks if movement is needed on X axis
	then
		player:movePlayer(dt) --moves and rotates player
		--player:fixShaking() --fix target location shaking
	elseif player.goToY ~= player.y -- checks if movement is needed on Y axis
	then
		player:movePlayer(dt) --moves and rotates player
		--player:fixShaking() --fix target location shaking
	end
		
	camera:setPosition(player.x - centerX, player.y - centerY) --centers camera on player
end

function player:goTo(coords) --stores coords where you are heading
	player.goToX = coords.x --sets target X coord
	player.goToY = coords.y --sets target X coord
end


----------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------- VECTOR FUNCTIONS --------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

function player:normalizeVector(v) --normalize vector for calculations
	local vect = {} --create temp "vector"
	
	local length = math.sqrt(v.x * v.x + v.y * v.y) --calculates vector length
	vect.x = v.x / length --normalize x part of vector
	vect.y = v.y / length --normalize y part of vector

	return vect --returns normalized vector
end

function player:rotateVector(v, radians) --rotates vector arround players position
	local vect = {} --create temp "vector"

	local ca = math.cos(radians) --calculates cosinus of angle
	local sa = math.sin(radians) --calculates sinus of angle
	
	digits = 2 --number of digits after decimal point
	dec = 10 ^ digits --decimal modifier
	
	vect.x = ca * (v.x - player.x) - sa * (v.y - player.y) + player.x --moves vector to (0,0), calculate rotated x part and move back to player x position
	vect.y = sa * (v.x - player.x) + ca * (v.y - player.y) + player.y --moves vector to (0,0), calculate rotated y part and move back to player y position
	
	vect.x = math.floor(vect.x * dec + 0.5) / dec
	vect.y = math.floor(vect.y * dec + 0.5) / dec
	
	return vect --returns rotated vector
end

function player:getVectorRotation(v) --calculate vectors rotation in radians
	local radians --creates temp var

	local cx = v.x - player.x --moves start of x part of vector to 0
	local cy = v.y - player.y --moves start of y part of vector to 0
	
	local hx = 1 --x part of help vector
	local hy = 0 --y part of help vector
	
	radians = -math.atan2(cx, cy) --calculates radians of vector rotation (vector . X-axis) (inverted because of inverted Y axis as (0,0) is top left)

	return radians --returns rotation in radians
end