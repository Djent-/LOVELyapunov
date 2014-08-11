--main.lua
--based on the golfed code in the codegolf stackexchange
--looks best at around 600-1600 iterations

function love.load()
	DIM = 512 --1024 in the original
	D_ITERATIONS = 100
	global_k = 0
	love.window.setMode(DIM,DIM)
	canvas = love.graphics.newCanvas(DIM,DIM)
	ARRAY = {}
	for a = 1, DIM do
		ARRAY[a] = {}
		for b = 1, DIM do
			ARRAY[a][b] = {}
		end
	end
	draw_fractal_n(D_ITERATIONS,canvas)
end

function draw_fractal_n(iterations)
	love.graphics.setCanvas(canvas)
	local i = iterations
	for y = 1, DIM do
		for x = 1, DIM do
			love.graphics.setColor(color("r",x,y,i), color("g",x,y,i), color("b",x,y,i))
			love.graphics.rectangle("fill", x, y, 1, 1)
		end
	end
	love.graphics.setCanvas()
end

function love.update(dt)
	love.timer.sleep(1)
	global_k = global_k + D_ITERATIONS
	draw_fractal_n(D_ITERATIONS,canvas)
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(canvas,1,1)
	love.graphics.setColor(255,255,255)
	love.graphics.print("Drawing",10,10)
	love.graphics.print(global_k + D_ITERATIONS,10,20)
	love.graphics.setColor(0,0,0)
end

function color(c, i, j, iter)
	local r, s, x = nil, ARRAY[j][i].s or 0, ARRAY[j][i].x or 0.5
	local _max = global_k + iter
	for k = global_k, _max do
		if k % 5 == 2 or k % 5 == 4 then
			r = (2 * j) / DIM + 2
		else
			r = (2 * i) / DIM + 2
		end
		x = x * r * (1 - x)
		s = s + math.log(math.abs(r - r * 2 * x))
	end
	write_array(i,j,x,s)
	if c == "r" then
		return math.abs(s)
	elseif c == "g" then
		if s > 0 then
			return s
		else
			return 0
		end
	elseif c == "b" then
		return math.abs(s * x)
	end
end

function write_array(i,j,x,s)
	ARRAY[j][i] = {["x"] = x, ["s"] = s}
end
