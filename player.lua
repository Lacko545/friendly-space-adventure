player = {} --TODO: comments

function player:init()
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

function player:movePlayer(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function player:rotatePlayer(dr)
  self.rotation = self.rotation + dr
end

function player:drawPlayer()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle("fill", player.x-5, player.y-5, player.width, player.height) --body of spaceship
	love.graphics.polygon("fill",player.x+5, player.y-5, player.x+5, player.y+5, player.x+10, player.y) --front of spaceship
end

function player:updatePlayer(dt)
	player.x = player.x + player.fSpeed * dt
	player.y = player.y + player.fSpeed * dt
end

function player:goTo(coords)
	player.goToX = coords.x
	player.goToY = coords.y
end