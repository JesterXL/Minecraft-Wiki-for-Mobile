local storyboard = require "storyboard"
require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"
require "com.jessewarden.minecraftwiki.controls.CraftGridView"
require "com.jessewarden.utils.WidgetUtils"
require "com.jessewarden.minecraftwiki.controls.TextArea"
require "com.jessewarden.minecraftwiki.Constants"

RecipeScreen = {}

function RecipeScreen:new(x, y, stageWidth, stageHeight)

	assert(x ~= nil, "You cannot pass in a nil x.")
	assert(y ~= nil, "You cannot pass in a nil y.")
	assert(stageWidth ~= nil, "You cannot pass in a nil stageWidth.")
	assert(stageHeight ~= nil, "You cannot pass in a nil stageHeight.")
	
	local screen = BaseScreen:new(x, y, stageWidth, stageHeight)
	
	screen.superCreateScene = screen.createScene
	function screen:createScene(event)
		self:superCreateScene(event)
		
		local group = self.view
		
		local scrollHeight = WidgetUtils:getHeight(stageHeight - screen.content.y)
		local scrollView = widget.newScrollView{x=0, y=0, width=stageWidth, height=scrollHeight}
		group.scrollView = scrollView
		self:insertContent(scrollView.view)

		local backgroundRect = display.newRect(x, y, stageWidth, stageHeight)
		backgroundRect:setFillColor(255, 255, 255)
		screen.backgroundRect = backgroundRect
		scrollView:insert(backgroundRect)

		local craftGridView = CraftGridView:new()
		screen.craftGridView = craftGridView
		if stageWidth / 211 >= 2 then
			craftGridView.xScale = 2
			craftGridView.yScale = 2
		end
		scrollView:insert(screen.craftGridView)

		local textColor = {r = 0, g = 0, b = 0}
		local descriptionTitle = TextArea:new({hasBackground = false, width=stageWidth,
												size=Constants.TEXT_TITLE_SIZE,
												color=textColor})
		screen.descriptionTitle = descriptionTitle
		scrollView:insert(descriptionTitle)
		descriptionTitle:setText("Description")

		local ingredientsTitle = TextArea:new({hasBackground = false, width=stageWidth,
												size=Constants.TEXT_TITLE_SIZE,
												color=textColor})
		screen.ingredientsTitle = ingredientsTitle
		scrollView:insert(ingredientsTitle)
		ingredientsTitle:setText("Ingredients")

		local descriptionText = TextArea:new({hasBackground=false, width=stageWidth,
												height=150,
												size=Constants.TEXT_DESCRIPTION_SIZE,
												color=textColor})
		screen.descriptionText = descriptionText
		scrollView:insert(descriptionText)

		local ingredientsText = TextArea:new({hasBackground=false, width=stageWidth,
												height=100,
												size=Constants.TEXT_DESCRIPTION_SIZE,
												color=textColor})
		screen.ingredientsText = ingredientsText
		scrollView:insert(ingredientsText)

		local addToFavoritesButton = widget.newButton
		{
			id = "addToFavoritesButton",
			label = "Add To Favorites",
			width=stageWidth * .8,
		}
		screen.addToFavoritesButton = addToFavoritesButton
		scrollView:insert(addToFavoritesButton.view)
	end
	
	function screen:setRecipe(recipeVO)
		print("RecipeScreen::setRecipe, recipeVO: ", recipeVO, ", recipeVO.recipe: ", recipeVO.recipe)
		if recipeVO ~= nil then
			if recipeVO.recipe ~= nil then
				self:udpateFromRecipe(nil)
			elseif recipVO.recipes ~= nil then
				self:cycleRecipes(recipeVO)
			else
				self:updateFromRecipe(nil)
			end
		else
			self:updateFromRecipe(nil)
		end
	end
	
	function screen:updateFromRecipe(recipeVO)
		if recipeVO ~= nil then
			self:setTitle(recipeVO.title)
			print("uno")
			local result, err = pcall(self.craftGridView.setSource, self.craftGridView, recipeVO.recipe)
			print("result: ", result, ", err: ", err)
		--	print("dos")
			local result, err = pcall(self.descriptionText.setText, self.descriptionText, recipeVO.description)
			print("result: ", result, ", err: ", err)
			--print("tres")
			local reuslt, err = pcall(self.ingredientsText.setText, self.ingredientsText, recipeVO.ingredients)
			print("result: ", result, ", err: ", err)
			--print("quatro")
			
			
			self.descriptionTitle:move(0, self.craftGridView.y + self.craftGridView.contentHeight)
			self.descriptionText:move(0, self.descriptionTitle.y + Constants.TEXT_TITLE_SIZE + 32)
			
			self.ingredientsTitle:move(0, self.descriptionText.y + self.descriptionText.height)
			self.ingredientsText:move(0, self.ingredientsTitle.y + Constants.TEXT_TITLE_SIZE + 32)
			
			self.addToFavoritesButton.view.x = (stageWidth / 2) - (self.addToFavoritesButton.view.width / 2)
			self.addToFavoritesButton.view.y = self.ingredientsText.y + self.ingredientsText.height + 16
		else
			self.craftGridView:setSource(nil)
			self.descriptionText.text = ""
			self.ingredientsText.text = ""
		end
	end
	
	function screen:cycleRecipes(recipeVO)
		self.recipeVO = recipeVO
		self.currentRecipeIndex = 1
		if self.cycleRecipeTimer ~= nil then
			timer.cancel(self.cycleRecipeTimer)
		end
		local timerTable = {}
		self.timerTable = timerTable
		function timerTable:timer(event)
			screen:nextRecipe()
		end
		self.cycleRecipeTimer = timer.performWithDelay(2000, timerTable)
		
	end
	
	function screen:nextRecipe()
		local recipes = self.recipeVO.recipes
		if self.currentRecipeIndex + 1 < #recipes then
			self.currentRecipeIndex = self.currentRecipeIndex + 1
			if self.currentRecipeIndex > #recipes then
				self.currentRecipeIndex = 1
			end
			self:updateFromRecipe(recipes[self.currentRecipeIndex])
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
	
	screen.superBeforeTransitionOut = screen.beforeTransitionOut
	function screen:beforeTransitionOut()
		self.descriptionTitle.isVisible = false
		self.descriptionText.isVisible = false
		
		self.ingredientsTitle.isVisible = false
		self.ingredientsText.isVisible = false
		
		self:superBeforeTransitionOut()
	end
	
	screen.superDestroy = screen.destroy
	function screen:destroy()
		if self.cycleRecipeTimer then
			timer.cancel(self.cycleRecipeTimer)
		end
		
		display.remove(self.scrollView)
		self:superDestroy()
	end
	
	return screen
end


return RecipeScreen:new(0, 0, 400, 500)
