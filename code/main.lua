
require "com.jessewarden.minecraftwiki.views.MainScreen"
require "com.jessewarden.minecraftwiki.MineCraftWikiView"
require "com.jessewarden.minecraftwiki.views.RecipesScreen"
require "com.jessewarden.minecraftwiki.views.AllScreen"
require "com.jessewarden.minecraftwiki.Constants"
require "com.jessewarden.minecraftwiki.controls.NumberText"
require "com.jessewarden.minecraftwiki.controls.CraftGridView"
require "com.jessewarden.minecraftwiki.controls.TextArea"
require "com.jessewarden.minecraftwiki.views.RecipeScreen"

local function initialize()
	mainGroup = display.newGroup()
	stage = display.getCurrentStage()
	print("stage.height: ", stage.height)
	
	display.setStatusBar(display.HiddenStatusBar)
	
	initKeys()
	
	Runtime:addEventListener("system", onSystemEvent)
	
	platform = system.getInfo("platformName")
	if platform == "Android" then
		widget.setSkin("mono")
		Constants.SHOW_BACK_BUTTON = false
	elseif platform == "iPhone OS" then
		widget.setSkin("iOS")
		Constants.SHOW_BACK_BUTTON = true
	else
		widget.setSkin("mono")
		Constants.SHOW_BACK_BUTTON = true
	end
	
	mineCraftWikiView = MineCraftWikiView:new(x, y, stage.width, stage.height)
	mainGroup:insert(mineCraftWikiView)
	--[[
	debugText = native.newTextBox( 0, 500, stage.width, stage.height - 500 )
	debugText.hasBackground = true
	debugText.isEditable = false
	debugText.isHitTestable = false
	debugText.align = "left"
	debugText:setReferencePoint(display.TopLeftReferencePoint)
	debugText:setTextColor(0, 0, 0)
	debugText.size = 16
	debugText.font = native.newFont( native.systemFont, 16 )
	mainGroup:insert(debugText)
	]]--
	return true
end

function debug(o)
	--debugText.text = debugText.text .. o .. "\n"
end

function initKeys()

	local function onKeyEvent( event )
		--for key,value in pairs(event) do
		--    debug("found member " .. key .. ":" .. value);
		--end
		if event.phase ~= "down" then
			if event.keyName == "back" then
				if mineCraftWikiView:canNavigateBack() then
					mineCraftWikiView:navigateBack()
					return true
				end
			end
		end
		return false
	end

	Runtime:addEventListener( "key", onKeyEvent );
end

function onSystemEvent(event)
	
	if event.type == "applicationExit" or event.type == "applicationSuspend" then
		if platform == "Android" then
			--native.requestExit()
			os.exit()
		elseif platform == "iPhone OS" then
			os.exit()
		end
	end

	--elseif event.type == "applicationResume"
end



local function testMainScreen()
	require "com.jessewarden.minecraftwiki.views.MainScreen"
	local stage = display.getCurrentStage()
	local screen = MainScreen:new(x, y, stage.width, stage.height) 
end

local function testListHeight()
	require "com.jessewarden.utils.WidgetUtils"
	local result = WidgetUtils:getListHeight(50)
	print("result: ", result)
end

local function testRecipesScreen()
	require "com.jessewarden.minecraftwiki.views.RecipesScreen"
	local stage = display.getCurrentStage()
	local screen = RecipesScreen:new(x, y, stage.width, stage.height)
end

local function testAllScreen()
	require "com.jessewarden.minecraftwiki.views.AllScreen"
	local stage = display.getCurrentStage()
	local screen = AllScreen:new(x, y, stage.width, stage.height)
end

local function testingPush()
	local t = {}
	print("start len: ", #t)
	table.insert(t, "Uno")
	print("len: ", #t)
	table.insert(t, "Dos")
	print("len: ", #t)
	print("item 1: ", t[1], ", item 2: ", t[2])
end

local function testNumberText()
	local i = 1
	local max = 12
	local startX = 40
	local startY = 40
	while i < max do
		local num = NumberText:new(i)
		num.x = startX
		num.y = startY
		startX = startX + 20
		i = i + 1
	end
end

local function testCraftGridView()
	local grid = CraftGridView:new()
	grid.x = 40
	grid.y = 40
	grid:setResult("Torch.png", 4)
	local source = grid:getGenericSource()
	source[2][1].image = "Wooden_Plank.png"
	grid:setSource(source)
	grid:setSource(nil)
end

local function testTextArea()
	print("testTextArea")
	--local box = assert(TextArea:new({hasBackground = false, width=100, height=0}), "Failed to create TextArea")
	--box.text = "Hello world, and welcome to t3h\nbig show. Don't forget to pick up your wrench at the desk."
	--box:move(0, 0)
	--box:move(40, 40)
	--box.x = 40
	--box.y = 40
	
	require "com.jessewarden.minecraftwiki.Constants"
	require "com.jessewarden.minecraftwiki.controls.TextArea"
	local stage = display.getCurrentStage()
	--local testTextArea = assert(TextArea:new({text = "Hello World", x=40, y=40}), "Failed to create TextArea")
	local descriptionTitle = assert(TextArea:new({hasBackground = false, width=stage.width, x=40, y=40,
											size=Constants.TEXT_TITLE_SIZE}), "Failed to create TextArea")
	descriptionTitle:setText("Description")
--	print("descriptionTitle: ", descriptionTitle)
	return true
end

local function testRecipeScreen()
	local stage = display.getCurrentStage()
	local recipeVO =
	{
		title = "Wooden Planks",
		recipe =
		{
			image="Wooden_Plank.png", 
			value=4,
			{{}, {}, {}},
			{{}, {}, {}},
			{{}, {image="Wood.png"}, {}}
		},
		description = "Used as a building material and can be crafted into many things. Any form of wood used will still result in the same output.",
		ingredients = "Wood"
	}
	
	local screen = RecipeScreen:new(0, 0, stage.width, stage.height)
	
	screen:setRecipe(recipeVO)
	--screen:setRecipe(nil)
end

local function testLoopingOverRecipes()
	require "com.jessewarden.minecraftwiki.Constants"
	local allRecipesData = Constants.recipes
	for recipeName,recipeVO in pairs(allRecipesData) do
		print("recipeVO: ", recipeVO, ", recipeName: ", recipeName)
	end
end




--testMainScreen()
--testListHeight()
--testRecipesScreen()
--testAllScreen()
--testingPush()
--testNumberText()
--testCraftGridView()
--assert(testTextArea(), "Failed testTextArea")
--testRecipeScreen()
--testLoopingOverRecipes()


initialize()


