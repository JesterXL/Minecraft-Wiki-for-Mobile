require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"
require "com.jessewarden.utils.WidgetUtils"
require "com.jessewarden.minecraftwiki.Constants"

AllScreen = {}

function AllScreen:new(x, y, width, height)

	local screen = BaseScreen:new(x, y, width, height)
	screen.classType = "AllScreen"
	screen.x = x
	screen.y = y
	
	
	function screen.onItemClick(event)
		local self = screen
		--local itemLabel = self.allRecipesData[event.target.id].title.label
		--if itemLabel == "Wooden Planks" then
		screen:dispatchEvent({name="onNavigate", 
								target=screen, 
								navTarget="RecipeScreen", 
								data=self.allRecipesData[event.target.id].recipeVO})
	end
	
	local allRecipesData = Constants.recipes
	local tableData = {}
	local recipeName
	local recipeVO
	local i = 1
	for recipeName,recipeVO in pairs(allRecipesData) do
		local item = 
		{	
			icon = 
			{
			    image = recipeVO.recipe.image,
                width = Constants.ROW_IMAGE_WIDTH,
                height = Constants.ROW_IMAGE_HEIGHT,
                base = system.ResourcesDirectory,
                paddingTop = 14,
                paddingLeft = 14,
                paddingRight = 14
			},
			title = 
			{
				label = recipeVO.title,
				font = "Helvetica-Bold",
	            size = Constants.ROW_FONT_SIZE,
	            color = { 0, 0, 0 },  -- red, green, blue
	            left = 14,
	            top = 14,
			},
			onRelease = screen.onItemClick,
			recipeVO = recipeVO
		}
		table.insert(tableData, i, item)
		i = i + 1
	end
		
	screen.allRecipesData = tableData
	
	local allRecipesList = widget.newTableView{rowHeight = Constants.ROW_HEIGHT, width=width}
	screen.allRecipesList = allRecipesList
	screen:insertContent(allRecipesList.view)
	local listHeight = WidgetUtils:getHeight(height - screen.content.y)
	allRecipesList.height = listHeight
	allRecipesList:sync(tableData)
	
	screen:setTitle("All Recipes")
	
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
	
	return screen
end

return AllScreen