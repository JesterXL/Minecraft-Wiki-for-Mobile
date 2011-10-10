require "com.jessewarden.minecraftwiki.views.MainScreen"

MineCraftWikiView = {}

function MineCraftWikiView:new(startX, startY, stageWidth, stageHeight)
	local screen = display.newGroup()
	screen.screens = {}
	screen.currentScreen = nil
	screen.currentPopping = nil
	
	function screen.onViewBack(event)
		local self = screen
		self:popScreen()
	end
	
	function screen:addScreen(classObject)
		print("addScreen")
		assert(classObject ~= nil, "You cannot pass a nil classObject.")
		if self.currentScreen ~= nil then
			if self.currentScreen.tween ~= nil then
				transition.cancel(currentScreen.tween)
			end
			self.currentScreen.tween = transition.to(self.currentScreen, 
													{time=500, 
													alpha=0, 
													x=-(stageWidth / 2), 
													transition=easing.outExpo,
													onComplete=screen.onAddScreenAndRemoveTransitionComplete})
		end
		
		local view = classObject:new(startX, startY, stageWidth, stageHeight)
		self.currentScreen = view
		view:addEventListener("onBack", screen.onViewBack)
		view:addEventListener("onNavigate", screen.onViewNavigate)
		local screens = self.screens
		table.insert(screens, view)
		self:insert(view)
		view.x = stageWidth / 2
		view.alpha = 0
		if view.tween ~= nil then
			transition.cancel(view.tween)
		end
		view.tween = transition.to(view, 
									{time=500, 
									alpha=1, 
									x=0, 
									transition=easing.outExpo,
									onComplete=screen.onAddScreenTransitionComplete})
		return view
	end
	
	function screen:popScreen()
		print("popScreen")
		if self.currentScreen ~= nil then
			print("\tself.currentScreen.classType: ", self.currentScreen.classType)
			if self.currentScreen.tween ~= nil then
				transition.cancel(self.currentScreen.tween)
			end
			--self.currentPopping = self.currentScreen
			self.currentScreen.tween = transition.to(self.currentScreen, 
													{time=500, 
													alpha=0, 
													x=stageWidth / 2, 
													transition=easing.outExpo,
													onComplete=screen.onPopScreenOutTransitionComplete})
		end 
		self.currentScreen = nil
		
		local screens = self.screens
		--print("before: ", #screens)
		table.remove(screens, #screens)
		--print("after: ", #screens)
		local newLen = #screens
		if newLen >= 1 then
			local current = screens[newLen]
			print("\tcurrent.classType: ", current.classType)
			self.currentScreen = current
			--self:insert(current)
			current.x = -(stageWidth / 2)
			current.alpha = 0
			if current.tween ~= nil then
				transition.cancel(current.tween)
			end
			current.tween = transition.to(current, 
											{time=500, 
											alpha=1, 
											x=0, 
											transition=easing.outExpo,
											onComplete=screen.onPopScreenInTransitionComplete})
		end
	end
	
	function screen.onAddScreenTransitionComplete(object)
		print("onAddScreenTransitionComplete, classType: ", object.classType)
		if object.tween then
			transition.cancel(object.tween)
			object.tween = nil
		end
	end
	
	function screen.onAddScreenAndRemoveTransitionComplete(object)
		print("onAddScreenAndRemoveTransitionComplete, classType: ", object.classType)
		if object.tween then
			transition.cancel(object.tween)
			object.tween = nil
		end
		--print("removing: ", object.classType)
		--screen:remove(object)
	end
	
	function screen.onPopScreenOutTransitionComplete(object)
		print("onPopScreenOutTransitionComplete, classType: ", object.classType)
		if object.tween then
			transition.cancel(object.tween)
			object.tween = nil
		end
		screen:removeEventListener("onBack", screen.onViewBack)
		screen:removeEventListener("onNavigate", screen.onViewNavigate)
		screen:remove(object)
		object:destroy()
	end
	
	function screen.onPopScreenInTransitionComplete(object)
		print("onPopScreenInTransitionComplete, classType: ", object.classType)
		if object.tween then
			transition.cancel(object.tween)
			object.tween = nil
		end
	end
	
	function screen.onViewNavigate(event)
		--print("onViewNavigate, event.navTarget: ", event.navTarget)
		local self = screen
		local classObject = _G[event.navTarget]
		local view = self:addScreen(classObject)
		print("event.data: ", event.data)
		if event.data ~= nil then
			view:setData(event.data)
		end
	end
	
	function screen:canNavigateBack()
		local screens = self.screens
		if screens and #screens > 1 then
			return true
		else
			return false
		end
	end
	
	function screen:navigateBack()
		self:popScreen()
	end
	
	screen:addScreen(MainScreen)
	
	return screen
end

return MineCraftWikiView