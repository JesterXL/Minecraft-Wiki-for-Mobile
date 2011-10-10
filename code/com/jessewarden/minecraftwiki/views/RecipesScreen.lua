require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"
require "com.jessewarden.utils.WidgetUtils"
require "com.jessewarden.minecraftwiki.Constants"

RecipesScreen = {}

function RecipesScreen:new(x, y, width, height)
	
	local screen = BaseScreen:new(x, y, width, height)
	screen.classType = "RecipesScreen"
	
	function screen.onItemClick(event)
	   --print( "You touched item: " .. self.categoryData )
		local self = screen
		--print("self.categoryData: ", screen.categoryData[event.target.id].title.label)
		local itemLabel = self.categoryData[event.target.id].title.label
		local navTarget
		if itemLabel == "All" then
			navTarget = "AllScreen"
		elseif itemLabel == "Favorites" then
			navTarget = "FavoritesScreen"
		elseif itemLabel == "Type" then
			navTarget = "TypesScreen"
		elseif itemLabel == "" then
			navTarget = "MaterialScreen"
		end
		
		screen:dispatchEvent({name="onNavigate", target=screen, navTarget=navTarget})
	end
	
	function screen.onSwipeListener(event)
		print("swipe")
	end
	
	--[[
	onRelease = onCategoryClick,
    onLeftSwipe = onSwipeListener,
    onRightSwipe = onSwipeListener,
]]--
	
	local categoryData = 
	{
		{
			title = 
			{
				label = "All",
				font = "Helvetica-Bold",
	            size = Constants.ROW_FONT_SIZE,
	            color = { 0, 0, 0 },  -- red, green, blue
	            left = 14,
	            top = 14,
			},
			onRelease = screen.onItemClick,
			
			{
	            -- CATEGORY (just one key)

	            categoryName = "My Category"
	        },
		},
		{
			title = {
				label = "Favorites",
				font = "Helvetica-Bold",
	            size = Constants.ROW_FONT_SIZE,
	            color = { 0, 0, 0 },  -- red, green, blue
	            left = 14,
	            top = 14,
			},
			onRelease = screen.onItemClick,
		},
		{	
			title = {
				label = "Type",
				font = "Helvetica-Bold",
	            size = Constants.ROW_FONT_SIZE,
	            color = { 0, 0, 0 },  -- red, green, blue
	            left = 14,
	            top = 14,
			},
			onRelease = screen.onItemClick,
		},
		{	
			title = {
				label = "Material",
				font = "Helvetica-Bold",
	            size = Constants.ROW_FONT_SIZE,
	            color = { 0, 0, 0 },  -- red, green, blue
	            left = 14,
	            top = 14,
			},
			onRelease = screen.onItemClick,
		}
	}
	screen.categoryData = categoryData
	
	local recipeCategoriesList = widget.newTableView{rowHeight = Constants.ROW_HEIGHT, width=width}
	screen.recipeCategoriesList = recipeCategoriesList
	screen:insertContent(recipeCategoriesList.view)
	local listHeight = WidgetUtils:getHeight(height - screen.content.y)
	print("screen.content.y: ", screen.content.y)
	print("height: ", height)
	print("REcipesScreen, desiredHeight: ", (height - screen.content.y), ", listHeight: ", listHeight)
	recipeCategoriesList.height = listHeight
	recipeCategoriesList:sync(categoryData)
	
	screen:setTitle("Recipes")
	
	local backButton = widget.newButton
	{
		id = "backButton",
		label = "<< Back",
		onEvent = screen.onBack
	}
	screen.backButton = backButton
	screen:insertHeader(backButton.view)
	
	backButton.view.x = 7
	backButton.view.y = screen.toolbar.view.y + 7
	backButton.isVisible = Constants.SHOW_BACK_BUTTON
	
	screen.superDestroy = screen.destroy
	function screen:destroy()
		print("RecipesScreen::destroy")
		display.remove(backButton.view)
		screen.backButton = nil
		self:superDestroy()
	end
	
	return screen
end

return RecipesScreen