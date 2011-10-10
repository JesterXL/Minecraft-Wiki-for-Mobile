require "sprite"

NumberText = {}

function NumberText:new(value)
	assert(value, "You cannot pass a nil value.")
	if(NumberText.spriteSheet == nil) then
		local spriteSheet = sprite.newSpriteSheet("Numbers.png", 16, 16)
		local spriteSet = sprite.newSpriteSet(spriteSheet, 1, 10)
		sprite.add(spriteSet, "numbers", 1, 10, 1000, 0)
		NumberText.spriteSheet = spriteSheet
		NumberText.spriteSet = spriteSet
	end
	
	local img = sprite.newSprite(NumberText.spriteSet)
	img:setReferencePoint(display.TopLeftReferencePoint)
	img.classType = "Number"
	img:prepare("numbers")
	img:play()
	img:pause()
	img.value = value
	
	function img:setValue(value)
		self.value = value
		if value ~= 0 then
			img.currentFrame = value
		else
			img.currentFrame = 10
		end
	end
	
	img:setValue(value)
	
	return img
end

return NumberText