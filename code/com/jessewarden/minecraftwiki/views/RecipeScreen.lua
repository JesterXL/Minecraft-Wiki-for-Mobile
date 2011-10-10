require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"
require "com.jessewarden.minecraftwiki.controls.CraftGridView"
require "com.jessewarden.utils.WidgetUtils"
require "com.jessewarden.minecraftwiki.controls.TextArea"
require "com.jessewarden.minecraftwiki.Constants"

RecipeScreen = {}

function RecipeScreen:new(x, y, stageWidth, stageHeight)

	local screen = BaseScreen:new(x, y, stageWidth, stageHeight)
	
	local scrollHeight = WidgetUtils:getHeight(stageHeight - screen.content.y)
	local scrollView = widget.newScrollView{y=0, width=stageWidth, height=scrollHeight}
	screen.scrollView = scrollView
	screen:insertContent(scrollView.view)
	
	local craftGridView = CraftGridView:new(x, y, stageWidth, stageHeight)
	screen.craftGridView = craftGridView
	scrollView:insert(screen.craftGridView)
	
	local descriptionTitle = TextArea:new({hasBackground = false, width=stageWidth / 2,
											size=Constants.TEXT_TITLE_SIZE})
	screen.descriptionTitle = descriptionTitle
	scrollView:insert(descriptionTitle)
	descriptionTitle.text = "Description"
	
	local ingredientsTitle = TextArea:new({hasBackground = false, width=stageWidth / 2,
											size=Constants.TEXT_TITLE_SIZE})
	screen.ingredientsTitle = ingredientsTitle
	scrollView:insert(ingredientsTitle)
	ingredientsTitle.text = "Ingredients"
	
	local descriptionText = TextArea:new({hasBackground=false, width=stageWidth / 2,
											height=300,
											size=Constants.TEXT_DESCRIPTION_SIZE})
	screen.descriptionText = descriptionText
	scrollView:insert(descriptionText)
	
	local ingredientsText = TextArea:new({hasBackground=false, width=stageWidth / 2,
											height=300,
											size=Constants.TEXT_DESCRIPTION_SIZE})
	screen.ingredientsText = ingredientsText
	scrollView:insert(ingredientsText)
	
	local addToFavoritesButton = widget.newButton
	{
		id = "addToFavoritesButton",
		label = "Add To Favorites",
	}
	screen.addToFavoritesButton = addToFavoritesButton
	scrollView:insert(addToFavoritesButton.view)
	
	function screen:setRecipe(recipeVO)
		if recipeVO ~= nil then
			self:setTitle(recipeVO.title)
			self.craftGridView:setSource(recipeVO.recipe)
			self.descriptionText.text = recipeVO.description
			self.ingredientsText.text = recipeVO.ingredients
			self.descriptionTitle:move(0, self.craftGridView.y + self.craftGridView.height)
			self.ingredientsTitle:move(stageWidth / 2, self.descriptionTitle:getTop())
			self.descriptionText:move(0, self.descriptionTitle.y + self.descriptionTitle.height + 2)
			self.ingredientsText:move(self.ingredientsTitle.x, self.ingredientsTitle.y + self.ingredientsTitle.height + 2)
			self.addToFavoritesButton.view.x = (stageWidth / 2) - (self.addToFavoritesButton.view.width / 2)
			self.addToFavoritesButton.view.y = self.descriptionText.y + self.descriptionText.height + 2
		else
			self.craftGridView:setSource(nil)
			self.descriptionText.text = ""
			self.ingredientsText.text = ""
		end
	end
	
	function screen:setData(data)
		self:setRecipe(data)
	end
	
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
		display.remove(self.scrollView)
		self:superDestroy()
	end
	
	return screen
end


return RecipeScreen