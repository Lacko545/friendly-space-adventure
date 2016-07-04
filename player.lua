player = {} --TODO: comments

function player:init() --set basic player parameters
	player.width = 10
	player.height = 10
	player.x = screenWidth / 2 - player.width
	player.y = screenHeight / 2 - player.height
	player.goToX = player.x
	player.goToY = player.y
	player.fSpeed = 10
	player.rSpeed = 10
	player.rotation = 0
end

function player:movePlayer(dx, dy) --move player (SHOULD WORK. not tested yet)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function player:rotatePlayer(dr) -- rotate player  (SHOULD WORK. not tested yet)
  self.rotation = self.rotation + dr
end

function player:drawPlayer() --draw player (works, but my player sucks. pfff . . . at least it works)
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", player.x-5, player.y-5, player.width, player.height) --body of spaceship
	love.graphics.polygon("fill",player.x+5, player.y-5, player.x+5, player.y+5, player.x+10, player.y) --front of spaceship
end

function player:updatePlayer(dt) --update player (i need to rework movement and rotation as its not working now)
	player.x = player.x + player.fSpeed * dt
	player.y = player.y + player.fSpeed * dt
end

function player:goTo(coords) --stores coords where you are heading
	player.goToX = coords.x --sets target X coord
	player.goToY = coords.y --sets target Y coord
end