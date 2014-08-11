--main.lua
--based on the golfed code in the codegolf stackexchange

function love.conf(t)
	t.console = true
end

function love.load()
	math.randomseed(os.time())
	math.random();math.random();
	DIM = 512 --1024 in the original
	MAX_ITERATIONS = 2500
	CURRENT_ITERATIONS = 70
	love.window.setMode(DIM,DIM)
	canvas = love.graphics.newCanvas(DIM,DIM)
	draw_fractal_n(CURRENT_ITERATIONS,canvas)
end

function draw_fractal(iterations, lcanvas)
	love.graphics.setCanvas(canvas)
	local ymin, ymax, xmin, xmax = 0, 400, 0, 400
	local increment = (ymax - ymin) / DIM
	local i = iterations
	for y = ymin, ymax, increment do
		for x = xmin, xmax, increment do
			love.graphics.setColor(red(x,y,i), green(x,y,i), blue(x,y,i))
			local _x = math.abs((x - xmin) / increment)
			local _y = math.abs((y - ymin) / increment)
			love.graphics.rectangle("fill",_x, _y,1,1)
		end
	end
	love.graphics.setCanvas()
end

function draw_fractal_n(iterations)
	love.graphics.setCanvas(canvas)
	local i = iterations
	for y = 1, DIM do
		for x = 1, DIM do
			love.graphics.setColor(red(x,y,i), green(x,y,i), blue(x,y,i))
			love.graphics.rectangle("fill", x, y, 1, 1)
		end
	end
	love.graphics.setCanvas()
end

--[ [
function love.update(dt)
	love.timer.sleep(1)
	if CURRENT_ITERATIONS < MAX_ITERATIONS then
		CURRENT_ITERATIONS = CURRENT_ITERATIONS + 10
	end
	draw_fractal_n(CURRENT_ITERATIONS,canvas)
end
--]]

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(canvas,1,1)
	love.graphics.setColor(255,255,255)
	love.graphics.print("Drawing",10,10)
	love.graphics.print(CURRENT_ITERATIONS,10,20)
	love.graphics.setColor(0,0,0)
end

function red(i, j, iter)
	local r, s, x = nil, 0, 0.5
	for k = 0, CURRENT_ITERATIONS do
		if k % 5 == 2 or k % 5 == 4 then
			r = (2 * j) / DIM + 2
		else
			r = (2 * i) / DIM + 2
		end
		x = x * r * (1 - x)
		s = s + math.log(math.abs(r - r * 2 * x))
	end
	return math.abs(s)
end

function green(i, j, iter)
	local r, s, x = nil, 0, 0.5
	for k = 0, CURRENT_ITERATIONS do
		if k % 5 == 2 or k % 5 == 4 then
			r = (2 * j) / DIM + 2
		else
			r = (2 * i) / DIM + 2
		end
		x = x * r * (1 - x)
		s = s + math.log(math.abs(r - r * 2 * x))
	end
	if s > 0 then
		return s
	else
		return 0
	end
end

function blue(i, j, iter)
	local r, s, x = nil, 0, 0.5
	for k = 0, CURRENT_ITERATIONS do
		if k % 5 == 2 or k % 5 == 4 then
			r = (2 * j) / DIM + 2
		else
			r = (2 * i) / DIM + 2
		end
		x = x * r * (1 - x)
		s = s + math.log(math.abs(r - r * 2 * x))
	end
	return math.abs(s * x)
end