
WidgetUtils = {}
WidgetUtils.heights = {100, 128, 176, 200, 208, 240, 256, 300, 320, 384, 400, 480, 500, 512, 600, 624, 700, 752, 768, 800, 1024}

function WidgetUtils:getHeight(desiredHeight)
	if desiredHeight < 100 then
		desiredHeight = 100
	end
	
	local heights = self.heights
	local i = 1
	local lastHeight = desiredHeight
	while heights[i] do
		local value = heights[i]
		if value < desiredHeight then
			lastHeight = value
		else
			return lastHeight
		end
		i = i + 1
	end
	return false
end

return WidgetUtils