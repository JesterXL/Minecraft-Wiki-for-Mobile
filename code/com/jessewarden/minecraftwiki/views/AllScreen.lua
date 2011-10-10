require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"
require "com.jessewarden.utils.WidgetUtils"

AllScreen = {}

function AllScreen:new(x, y, width, height)

	local screen = BaseScreen:new(x, y, width, height)
	screen.classType = "AllScreen"
	screen.x = x
	screen.y = y
	
	
	function screen.onItemClick(event)
		local self = screen
		local itemLabel = self.allRecipesData[event.target.id].title.label
		if itemLabel == "Wooden Planks" then
			screen:dispatchEvent({name="onNavigate", 
									target=screen, 
									navTarget="RecipeScreen", 
									data=self.allRecipesData[event.target.id].recipeVO})
		end
	end
	
	local woodenPlanksRecipe = 
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
	
	local allRecipesData = 
	{
		{name="Wooden Planks", image="Wooden_Plank.png", recipeVO=woodenPlanksRecipe},
		{name="Sticks", image="Stick.png"},
		{name="Torches", image="Torch.png"},
		{name="Crafting Table", image="Crafting_Table.png"},
	}
	local i = 1
	local tableData = {}
	while allRecipesData[i] do
		local recipe = allRecipesData[i]
		local item = 
		{	
			icon = 
			{
			    image = recipe.image,
                width = Constants.ROW_IMAGE_WIDTH,
                height = Constants.ROW_IMAGE_HEIGHT,
                base = system.ResourcesDirectory,
                paddingTop = 14,
                paddingLeft = 14,
                paddingRight = 14
			},
			title = 
			{
				label = recipe.name,
				font = "Helvetica-Bold",
	            size = Constants.ROW_FONT_SIZE,
	            color = { 0, 0, 0 },  -- red, green, blue
	            left = 14,
	            top = 14,
			},
			onRelease = screen.onItemClick,
			recipeVO = recipe.recipeVO
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