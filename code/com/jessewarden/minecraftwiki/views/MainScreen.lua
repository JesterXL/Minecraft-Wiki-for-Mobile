require "widget"
require "com.jessewarden.minecraftwiki.views.BaseScreen"

MainScreen = {}

function MainScreen:new(x, y, width, height)
	local screen = BaseScreen:new(x, y, width, height)
	screen.classType = "MainScreen"
	screen.x = x
	screen.y = y
	
	function screen.onRecipesButton(event)
		if event.phase == "release" then
			screen:dispatchEvent({name="onNavigate", target=screen, navTarget="RecipesScreen"})
			return true
		end
	end
	
	local recipesButton = widget.newButton
	{
		id = "recipesButton",
		label = "Crafting Recipes",
		onEvent = screen.onRecipesButton
	}
	screen.recipesButton = recipesButton
	screen:insertContent(recipesButton.view)
	recipesButton.view.x = (width / 2) - (recipesButton.view.width / 2)
	recipesButton.view.y = (height / 2) - (recipesButton.view.height / 2)
	
	screen.superDestroy = screen.destroy
	function screen:destroy()
		print("MainScreen::destroy")
		display.remove(recipesButton)
		screen.recipesButton = nil
		self:superDestroy()
	end
	
	screen:setTitle("Minecraft Wiki")
	
	return screen
end

return MainScreen