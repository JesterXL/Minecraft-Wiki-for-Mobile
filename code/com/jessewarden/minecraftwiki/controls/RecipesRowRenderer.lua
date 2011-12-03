
require "com.jessewarden.minecraftwiki.Constants"

RecipesRowRenderer = {}

function RecipesRowRenderer:new()
	local group = display.newGroup()
	--[[
	local rect = display.newRect(0, 0, 300, 100)
	rect:setReferencePoint(display.TopLeftReferencePoint)
	rect.strokeWidth = 3
	rect:setFillColor(255, 255, 255)
	rect:setStrokeColor(180, 180, 180)
	group:insert(rect)
	]]--
	
	local label = display.newRetinaText("Hello World!", 14, 14, "Helvetica-Bold", Constants.ROW_FONT_SIZE)
	label:setTextColor(0, 0, 0)
	group:insert(label)
	
	function group:setLabel(text)
		label.text = text
		
	end
	
	return group
end

return RecipesRowRenderer 