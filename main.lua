--main.lua
--based on the golfed code in the codegolf stackexchange

function love.conf(t)
	t.console = true
end

function love.load()
	math.randomseed(os.time())
	math.random();math.random();
	DIM = 512 --1024 in the original
	MAX_ITERATIONS = 1000
	love.window.setMode(DIM,DIM)
	canvas = love.graphics.newCanvas(DIM,DIM)
	love.graphics.setCanvas(canvas)
	local ymin, ymax, xmin, xmax = 2, 4, 2, 4
	local increment = (ymax - ymin) / DIM
	for y = ymin, ymax, increment do
		for x = xmin, xmax, increment do
			love.graphics.setColor(red(x,y), green(x,y), blue(x,y))
			local _x = math.abs((x - xmin) / increment)
			local _y = math.abs((y - ymin) / increment)
			love.graphics.rectangle("fill",_x, _y,1,1)
		end
	end
	love.graphics.setColor(255,255,255)
	love.graphics.print("Finished drawing",10,10)
	print("Finished drawing")
	love.graphics.setCanvas()
end

function love.draw()
	love.graphics.draw(canvas,1,1)
	love.graphics.print("Drawing",10,30)
end

function red(i, j)
	local r, s, x = nil, 0, 0.5
	for k = 0, MAX_ITERATIONS do
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

function green(i, j)
	local r, s, x = nil, 0, 0.5
	for k = 0, MAX_ITERATIONS do
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

function blue(i, j)
	local r, s, x = nil, 0, 0.5
	for k = 0, MAX_ITERATIONS do
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