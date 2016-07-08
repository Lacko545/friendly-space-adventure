function love.conf(t)
	t.window.title = "Friendly space adventure"
	t.window.icon = nil
    t.window.width = 800
    t.window.height = 600
	
	t.window.fullscreen = false
	
	t.accelerometerjoystick = false
	t.modules.joystick = false
	t.modules.touch = true --required for touchpads?
end