function love.load()
	--initialization of variables, so we wont get nil error START
	angle = 0
	mouseY = 0
	mouseX = 0
	asd = 0
	heightTrg = 0
	widthTrg = 0
	radius = 0
	mouseY2 = 0
	mouseX2 = 0
	heightTrg2 = 0
	widthTrg2 = 0
	angle2 = 0
	arcX = 0
	arcY = 0
	--initialization of variables, so we wont get nil error END

	width = love.graphics.getWidth() --width of canvas (also known as drowing place)
	height = love.graphics.getHeight() --height of canvas (also known as drowing place)
	midX, midY = (width/2), (height/2) --where are you my middle point
	
	love.mouse.setX(midX+20) --too lazy to move mouse to position i need when calculating stuff for tests. so yep, X coord
	love.mouse.setY(midY-10) --too lazy to move mouse to position i need when calculating stuff for tests. and Y coord
	
end

function love.draw()
	-- debug stuff START
	love.graphics.print(widthTrg, 10, 10)
	love.graphics.print(heightTrg, 10, 25)
	love.graphics.print(asd, 10, 40)
	love.graphics.print(angle, 10, 55)
	love.graphics.print(midX, 90, 10)
	love.graphics.print(midY, 90, 25)
	love.graphics.print(mouseX, 170, 10)
	love.graphics.print(mouseY, 170, 25)
	love.graphics.print(arcX, 260, 10)
	love.graphics.print(arcY, 260, 25)
	love.graphics.print(radius, 260, 40)
	-- debug stuff END
	
	love.graphics.setBackgroundColor(200, 200, 200) --background (TODO: change to picture of space)
	love.graphics.rectangle("fill", 100, 85, 210, 180) --yup, square planet
	
	love.graphics.setColor(255, 255, 255) --stuff will be white
	love.graphics.arc( "fill", arcX, arcY, radius, angle2, (math.pi + angle2)) -- the arc of flight. its retarded i know
	
	--rotates only stuff drown AFTER rotation
	love.graphics.translate(width/2, height/2) --some magic stuff with middle coords
	love.graphics.rotate(angle)
	love.graphics.translate(-width/2, -height/2) --some other magic stuff with reversed middle coords
	--draw stuff to rotate
	love.graphics.setColor(0,0,0) --stuff will be black
	love.graphics.rectangle("fill", midX-5, midY-5, 10, 10) --body of spaceship
	love.graphics.polygon("fill",midX+5, midY-5, midX+5, midY+5, midX+10, midY) --front of spaceship
end

function love.update(dt)
	if love.mouse.isDown(1) --left mouse button event
	then
		mouseX = love.mouse.getX() --mouse x coord. no magic involved
		mouseY = love.mouse.getY() --mouse y coord. no magic involved either
		widthTrg = mouseX-midX --distance between middle and mouse clicked for X
		heightTrg = (mouseY-midY)*-1 --distance between middle and mouse clicked for Y inversed, because 0 is at top
		angle = math.atan(heightTrg/widthTrg)*-1 --angle or totation for left click
		if widthTrg < 0 -- if rotation is more than 90 and less than 270 we need to turn it to left
		then
			angle = angle + math.pi --adds half of circle to rotate it to the other side
		end
	end
	if love.mouse.isDown(2) --right mouse button event
	then
		mouseX2 = love.mouse.getX() --mouse x coord. no magic involved. yup comments are same
		mouseY2 = love.mouse.getY() --mouse y coord. no magic involved either. yup comments are same and will be
		widthTrg2 = mouseX2-midX --distance between middle and mouse clicked for X
		heightTrg2 = (mouseY2-midY)*-1 --distance between middle and mouse clicked for Y inversed, because 0 is at top
		angle2 = math.atan(heightTrg2/widthTrg2)*-1 --angle or totation for right click
		if widthTrg2 < 0 -- if rotation is more than 90 and less than 270 we need to turn it to left
		then
			angle2 = angle2 + math.pi --adds half of circle to rotate it to the other side
		end
		arcX = midX + widthTrg2 / 2 --x point of arc middle
		arcY = midY - heightTrg2 / 2 --y point of arc middle
		radius = math.sqrt(widthTrg2*widthTrg2+heightTrg2*heightTrg2) / 2  --radius of rotation for arc. some magic, also known as pythagoras theorem. halved to get radius from diameter
	end
end

function love.keyreleased(key)
	if key == "escape"   --exit on escape, cos i am too lazy to click X everytime
	then
		love.event.quit() --aaaaand its over
	end
end

--	(a o² + b o + c) / 2
--	a = move on X coordinate
--	b = curving
--	c = move on Y coordinate - probably enough to use 0, cos shit is centered
--	
--	a b | a b
--
--	- - | - +
--	---------
--	+ + | + -
--
--	path point X coord = mouseX coord
--	path point Y coord = need to be calculated with (a o² + b o) / 2
--	TODO: how do i even calculate <a> and <b> ?
--	