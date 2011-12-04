local widget = require "widget"
local storyboard = require "storyboard"

BaseScreen = {}

function BaseScreen:new()
	local screen = storyboard.newScene()
	
	function screen:createScene(event)
		local group = self.view
		local toolbar = widget.newTabBar( "Title Text" )
		toolbar.view.width = width
		screen.toolbar = toolbar

		local content = display.newGroup()
		screen.content = content

		local headerContent = display.newGroup()
		screen.headerContent = headerContent
		
		group:insert(content)
		group:insert(toolbar.view)
		group:insert(headerContent)

		content.y = toolbar.view.y + 12
	end
	
	function screen:destroyScene(event)
		display.remove(self.toolbar)
		self.headerContent:removeSelf()
		self.content:removeSelf()
		self:removeSelf()
	end
	
	function screen.onBack(event)
		if event.phase == "release" then
			screen:dispatchEvent({name="onBack", target=screen})
			return true
		end
	end
	
	function screen:setTitle(text)
		screen.toolbar.label = text
	end
	
	function screen:setSize(w, h)
		screen.toolbar.view.width = w
	end
	
	function screen:insertContent(obj)
		local content = screen.content
		content:insert(obj)
		obj.x = content.x
		obj.y = content.y
	end
	
	function screen:insertHeader(obj)
		local header = screen.headerContent
		header:insert(obj)
		obj.x = header.x
		obj.y = header.y
	end
	
	function screen:onBack()
		screen:dispatchEvent({name="onBack", target=screen})
	end
	
	function screen:destroy()
		print("BaseScreen::destroy")
		--display.remove(screen.toolbar)
		screen.toolbar = nil
	end
	
	-- HACK: allow components to "do stuff" before they transition.
	-- In the case of some, basically hide native text fields since they can't apparently
	-- alpha if they're in a group since they don't work with gropups which would mean
	-- I'd have to manually set their view.alpha, which is hard without a setter,
	-- which I'm not doing so....... p.i.t.a.
	function screen:beforeTransitionOut()
		-- stub
	end
	
	return screen
end

return BaseScreen