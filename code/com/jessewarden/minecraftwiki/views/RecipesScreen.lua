local widget = require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"
require "com.jessewarden.utils.WidgetUtils"
require "com.jessewarden.minecraftwiki.Constants"
require "com.jessewarden.minecraftwiki.controls.RecipesRowRenderer"

RecipesScreen = {}

function RecipesScreen:new(x, y, width, height)
	
	local screen = BaseScreen:new(x, y, width, height)
	screen.classType = "RecipesScreen"
	screen.categories = {"All", "Favorites", "Types", "Materials"}
	
	function screen.onItemClick(event)
		print("RecipesScreen::onItemClick")
		if event.phase ~= "release" then
			return
		end
		
	   --print( "You touched item: " .. self.categoryData )
		local self = screen
		--print("self.categoryData: ", screen.categoryData[event.target.id].title.label)
		local itemLabel = self.categories[event.index]
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
	
	function screen.onRender(event)
		print("screen::onRender")
		local self = screen
		local row = event.target
        local rowGroup = event.view
		local rowRenderer = RecipesRowRenderer:new()
		rowRenderer:setLabel(self.categories[event.index])
        -- must insert everything into event.view:
        rowGroup:insert( rowRenderer )
	end
	-- all, favorites, type, materials
	
	local recipeCategoriesList = widget.newTableView{width=width}
	screen.recipeCategoriesList = recipeCategoriesList
	screen:insertContent(recipeCategoriesList.view)
	local listHeight = WidgetUtils:getHeight(height - screen.content.y)
	
	for i=1,4 do
		recipeCategoriesList:insertRow({onRender=screen.onRender,
										onEvent=screen.onItemClick,
										height=Constants.ROW_HEIGHT,
										textLabel=textLabel})
	end
	
	screen:setTitle("Recipes")
	
	local backButton = widget.newButton
	{
		id = "backButton",
		label = "<< Back",
		onEvent = screen.onBack
	}
	screen.backButton = backButton
	screen:insertHeader(backButton.view)
	
	backButton.view:setReferencePoint(display.TopLeftReferencePoint)
	backButton.view.x = 0
	--backButton.view.y = screen.toolbar.view.y + 7
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