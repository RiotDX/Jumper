-- modified sample movement logic for Roland Yonaba's Jumper module. This is quick code and hasn't been tested extensively.


display.setStatusBar(display.HiddenStatusBar)
local performance = require('performance')
performance:newPerformanceMeter()
	------------------------------
	
	-- Forward declaring variables
local cellWidth = 16 -- size of cell width
local cellHeight = 16 -- size of cell height
local xShift = -8 -- moving the cells back to center
local cellb = {} -- cell display object table
local callNewPath -- forward declaring pathfinding function
local touchStarted = 0 -- touch function variable
local movingHere = false -- path-following variable
local path -- forward declaring pathfinding variable
local rndPlot = 0 -- randomization holder for obstacles (non-walkable tiles).
local rndPlotH = 6 -- randomization threshold for obstacles (non-walkable tiles). 
local setX = {} -- x coordinate table holder for path-following
local setY = {} -- y coordinate table holder for path-following
local pMX = 1 -- forward declaring pathfinding variable
local pMY = 1 -- forward declaring pathfinding variable
local aMX = 1 -- forward declaring pathfinding variable
local aMY = 1 -- forward declaring pathfinding variable
local timeMove = 50 -- speed at which actor moves along path
local moveCount = 0 -- movement counter for main timer
local hero -- forward declaring actor variable
local startx, starty = 1,1
local rndSet -- forward declaring random tile population variable
	local function resetVars() -- resets variables after movement is completed
		pMX = 1
		pMY = 1
		aMX = 1
		aMY = 1
		moveCount = 0
		setX = nil
		setY = nil
		setX = {}
		setY = {}
		endy = nil
		endx = nil
		touchStarted = 0
		movingHere = false
	end
	------------------------------
	
	
	

	local function flipSize(obj) -- flips and returns passed display object tile to original values
		local function objReturn()
			obj:setFillColor(.75,.5,.25)
			transition.to(obj,{time=250, alpha=1, xScale=1}) -- returns flipped tile to original scale, color and alpha
		end
		transition.to(obj,{time=500, xScale=.1, onComplete=objReturn})
	end


local map = {} -- gridmap holder
local function callMap() -- function that creates gridmap
	for x = 1, 25 do -- column
		map[x] = {}
		for y = 1, 17 do --row
			rndSet = math.random(145)
			if rndSet == 1 then
				map[x][y] = 1
			else
				map[x][y] = 0
			end

		end
	end
end
callMap()
map[1][1] = 0 -- ensure that actor has a place to start!
map[1][2] = 0 -- ensure that actor has a place to start!

	local function movePlayer() -- moving actor with this function. It is called on a repeated timer and stops after the end is reached, as defined by the timer with the Lua closure below.
		print("BEING CALLED NOW")
		if movingHere then
			print("number of values in setX is "..#setX)
			print("number of values in setY is "..#setY)
			print("aMX value is "..aMX)
			print("aMY value is "..aMY)
			print("setX = "..setX[aMX])
			print("setY = "..setY[aMY])
			print("-------------------")
				hero.x = cellb[setY[aMX]][setX[aMY]].x
				hero.y = cellb[setY[aMX]][setX[aMY]].y
			cellb[setY[aMX]][setX[aMY]]:setFillColor(.5,0,.25)
			flipSize(cellb[setY[aMX]][setX[aMY]])
			aMX = aMX+1
			aMY = aMY+1
			--return true
		end
	end
			
	local function createRanRooms1() -- this function creates the randomly generated obstacles, very quickly. This is ugly and isn't meant to display my skills at PCG. If you judge me, do it publicly so I can benefit from the experience.
		if rndPlot < rndPlotH then -- stops the function after a certain amount of tiles are converted to obstacles
		local wRndX1 = math.random(3,13)
		local wRndY1 = math.random(3,13)
		--print("wRndX1 = "..wRndX1)
		--print("wRndY1 = "..wRndY1)
		-- build map array --
				rndPlot = rndPlot+1
				map[wRndX1+1][wRndY1+1] = 1
				map[wRndX1+1][wRndY1+2] = 1
				map[wRndX1+1][wRndY1+3] = 1
				map[wRndX1+2][wRndY1+1] = 1
				map[wRndX1+2][wRndY1+2] = 1
				map[wRndX1+2][wRndY1+3] = 1
				map[wRndX1+3][wRndY1+1] = 1
				map[wRndX1+3][wRndY1+2] = 1
				map[wRndX1+3][wRndY1+3] = 1
				--print("cellb[wRndX1+3][wRndY1].x = "..cellb[wRndX1+3][wRndY1].x)
				print(" 1111111111111111111111 CHANGED 1 HOLDER for "..wRndX1.." "..wRndY1)
		end
	end
	for i=1, 10 do
	createRanRooms1()
	end
			local function printLoc1(self, event) -- the magic happens. Press down to decide where the actor will go, release to watch.
				if movingHere == false then
					if event.phase == "began" and touchStarted == 0 then
						endx, endy = self.inity,self.initx -- create endpoint for actor's path
						touchStarted = 1
						callNewPath() -- pathfinding function
					end
					if event.phase == "ended" and touchStarted == 1 then
						startx, starty = self.inity,self.initx
						movingHere = true
						timer.performWithDelay(timeMove, movePlayer, moveCount)
						timer.performWithDelay((timeMove*moveCount)+800, function()
						resetVars() -- these reset all of the variables back to original values so that movement can take place again.
						end, 1)
					end
				end
			end
			
	local function createRanRooms() -- creates the display objects for the pre-created gridmap
    -- build map array --
		for x = 1, 25 do -- column
			cellb[x] = {}
			for y = 1, 17 do --row
				if map[x][y] == 0 then -- wall 
				cellb[x][y] = display.newRect(x*cellWidth, y*cellHeight,cellWidth,cellHeight)
				cellb[x][y].x = (y*(cellWidth+1))-xShift
				cellb[x][y].y = x*(cellHeight+1)
				cellb[x][y].initx = x
				cellb[x][y].inity = y
				cellb[x][y].id = ("cell B"..x.."X"..y)
				cellb[x][y]:setFillColor(.75,.5,.25)
				cellb[x][y].touch = printLoc1
				cellb[x][y]:addEventListener("touch", cellb[x][y])
				elseif map[x][y] == 1 then -- wall 
				cellb[x][y] = display.newRect(x*cellWidth, y*cellHeight,cellWidth,cellHeight)
				cellb[x][y].x = (y*(cellWidth+1))-xShift
				cellb[x][y].y = x*(cellHeight+1)
				cellb[x][y].initx = x
				cellb[x][y].inity = y
				cellb[x][y].id = ("cell B"..x.."X"..y)
				cellb[x][y]:setFillColor(.75,0,.25)
				end
			end
		end
	end
	createRanRooms()
		
		hero = display.newRect(cellWidth, cellHeight,cellWidth-4,cellHeight-4)
		hero.x = 288+64
		hero.y = 160-64
		hero:setFillColor(1,0,0)
		hero.x = cellb[1][1].x
		hero.y = cellb[1][1].y
	
	
local walkable = 0

-- Library setup
local Grid = require ("jumper.grid") -- The grid class
local Pathfinder = require ("jumper.pathfinder") -- The pathfinder lass

-- Creates a grid object
local grid = Grid(map) 
-- Creates a pathfinder object using Jump Point Search
local myFinder = Pathfinder(grid, 'DIJKSTRA', walkable) -- I like DIJKSTRA, but others work too. Check the pathfinding module for more info on the types of pathfinding algorithm.
myFinder:setMode('ORTHOGONAL')

-- Calculates the path, and its length
local path
function callNewPath()
	path = myFinder:getPath(startx, starty, endx, endy)
	if path then
	print(('Path found! Length: %.2f'):format(path:getLength()))
		for node, count in path:nodes() do
		print(('Step: %d - x: %d - y: %d'):format(count, node.x, node.y))
		print(node.x)
		print(node.y)
		setX[#setX+1] = node.x -- populating coordinate table on each movement
		setY[#setY+1] = node.y -- populating coordinate table on each movement
		cellb[node:getY()][node:getX()].alpha = .8 -- see the path you've chosen!
		moveCount = moveCount+1
		end
	end
end


