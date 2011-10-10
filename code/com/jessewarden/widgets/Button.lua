Button = {}

function Button:new(x, y, label)
	
	local button = widget.newButton
	{
		id = "recipesButton",
		label = label,
	}
	
	return button
	
end

return Button