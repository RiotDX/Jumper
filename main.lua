display.setStatusBar(display.HiddenStatusBar)
local cellWidth = 16
local cellHeight = 16
local xShift = -8
local cellb = {}
local callNewPath
local touchStarted = 0
local movingHere = false
local path
local rndPlot = 0
local setX = {}
local setY = {}
	local pMX = 1
	local pMY = 1
	local aMX = 1
	local aMY = 1
	local timeMove = 50
	local moveCount = 0
	local hero
local startx, starty = 1,1
local performance = require('performance')
performance:newPerformanceMeter()

	local function flipSize(obj)
		local function objReturn()
			obj:setFillColor(.75,.5,.25)
			transition.to(obj,{time=250, xScale=1})
		end
		transition.to(obj,{time=500, xScale=.1, onComplete=objReturn})
	end


local map = {}
local rndSet
local function callMap()
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
map[1][1] = 0
map[1][2] = 0
	local function movePlayer()
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
			
	local function createRanRooms1()
		if rndPlot < 6 then
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
			local function printLoc1(self, event)
				if movingHere == false then
					if event.phase == "began" and touchStarted == 0 then
						endx, endy = self.inity,self.initx
						touchStarted = 1
						callNewPath()
					end
					if event.phase == "ended" and touchStarted == 1 then
						startx, starty = self.inity,self.initx
						movingHere = true
						timer.performWithDelay(timeMove, movePlayer, moveCount)
						timer.performWithDelay((timeMove*moveCount)+800, function()
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
						end, 1)
					end
				end
			end
			
	local function createRanRooms()
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
local myFinder = Pathfinder(grid, 'DIJKSTRA', walkable) 
myFinder:setMode('ORTHOGONAL')
-- Define start and goal locations coordinates
--local endx, endy = 5,15

-- Calculates the path, and its length
local path
function callNewPath()
path = myFinder:getPath(startx, starty, endx, endy)
if path then
  print(('Path found! Length: %.2f'):format(path:getLength()))
    for node, count in path:nodes() do
      print(('Step: %d - x: %d - y: %d'):format(count, node:getX(), node:getY()))
	  print(node:getX())
	  print(node:getY())
			setX[#setX+1] = node:getX()
			setY[#setY+1] = node:getY()
			--cellb[node:getY()][node:getX()]:setFillColor(.5,0,.25)
			moveCount = moveCount+1
	  if node:getY() == 15 then
			--cellb[15][5]:setFillColor(.5,0,.25)
	  end
    end
end
end


