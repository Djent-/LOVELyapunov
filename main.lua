--main.lua
--based on the golfed code in the codegolf stackexchange

function love.load()
	DIM = 512 --1024 in the original
	canvas = love.graphics.newCanvas()
end

function love.draw()
	
end

function red(i, j)
	local r, s, x = nil, 0, 0.5
	for k = 0, 50 do
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
	for k = 0, 50 do
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
	for k = 0, 50 do
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