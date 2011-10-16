
TextArea = {}

function TextArea:new(params)
	local text
	
	if params == nil then
		params = {}
	end

	if params.hasBackground == nil then
		params.hasBackground = true
	end

	if params.isEditable == nil then
		params.isEditable = false
	end

	if params.align == nil then
		params.align = "left"
	end

	if params.font == nil then
		params.font = native.systemFont
	end

	if params.size == nil then
		params.size = 16
	end
	
	if params.width == nil then
		params.width = 100
	end

	if params.height == nil then
		params.height = 100
	end
	
	if params.x == nil then
		params.x = 0
	end
	
	if params.y == nil then
		params.y = 0
	end
	
	if params.color == nil then
		params.color = {r = 255, g = 255, b = 255}
	end
	
	local platform = system.getInfo("platformName")
	if platform == "Android" or platform == "iPhone OS" then
		text = native.newTextBox(0, 0, params.width, params.height)
		text.hasBackground = params.hasBackground
		text.isEditable = params.isEditable
		text.align = params.align
	else
		text = display.newText("", 0, 0, params.font, params.size)
	end
	
	text:setReferencePoint(display.TopLeftReferencePoint)
	text.size = params.size
	text.font = native.newFont(params.font, params.size)
	text:setTextColor(params.color.r, params.color.g, params.color.b)
	if params.text ~= nil then
		text.text = params.text
	end
	
	function text:move(x, y)
		if platform == "Android" or platform == "iPhone OS" then
			self.x = x
			self.y = y
		else
			self.x = x + self.width / 2
			self.y = y + self.height / 2
		end
	end
	
	function text:getTop()
		if platform == "Android" or platform == "iPhone OS" then
			return self.y
		else
			return self.y - self.height / 2
		end
	end
	
	function text:setText(value)
		self.text = value
		self:move(self.x, self.y)
	end
	
	text:move(params.x, params.y)
	
	return text
end

return TextArea