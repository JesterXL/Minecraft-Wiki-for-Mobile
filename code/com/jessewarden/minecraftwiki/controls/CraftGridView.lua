CraftGridView = {}
CraftGridView.MINIMUM_WIDTH = 211

function CraftGridView:new()
	local group = display.newGroup()
	group.x = x
	group.y = y
	
	-- 211,124
	local background = display.newImage("Grid.png", 0, 0, true)
	group.background = background
	group.background:setReferencePoint(display.TopLeftReferencePoint)
	group:insert(group.background)
	group.gridImages = display.newGroup()
	group:insert(group.gridImages)
	
	function group:setResult(img, value)
		if self.resultImage ~= nil then
			self.numberText.isVisible = false
			self.resultImage:removeSelf()
		end
		self.resultImage = display.newImage(img)
		self.resultImage:setReferencePoint(display.TopLeftReferencePoint)
		self:insert(self.resultImage)
		-- 153,38
		self.resultImage.x = 153 + (self.resultImage.width / 2) - 8
		self.resultImage.y = 38 + (self.resultImage.height / 2) - 8
		--print("x: ", self.resultImage.x, ", y: ", self.resultImage.y)
		
		if self.numberText == nil then
			self.numberText = NumberText:new(value)
			self:insert(self.numberText)
		end
		self.numberText:setValue(value)
		self.numberText.isVisible = true
		self.numberText:toFront()
		self.numberText.x = 201 - self.numberText.width
		self.numberText.y = 84 - self.numberText.height
	end
	
	function group:getGenericSource()
		local source = {
			{{}, {}, {}},
			{{}, {}, {}},
			{{}, {}, {}},
		}
		return source
	end
	
	function group:setSource(recipe)
		self:removeAllGridImages()
		if recipe == nil then
			self:setResult(nil, nil)
			return true
		end
		
		self:setResult(recipe.image, recipe.value)
		
		local startX = 10
		local startY = 10
		local wSize = 36
		local hSize = 36
		local r = 1
		while recipe[r] do
			local row = recipe[r]
			local c = 1
			while row[c] do
				local column = row[c]
				--print("r: ", r, ", c: ", c, ", column.image: ", column.image)
				if column.image ~= nil then
					local image = display.newImage(column.image)
					image:setReferencePoint(display.TopLeftReferencePoint)
					self.gridImages:insert(image)
					image.x = ((c - 1) * wSize) + startX + (image.width / 2) - 16
					image.y = ((r - 1) * hSize) + startY + (image.height / 2) - 16
				end	
				c = c + 1
			end	
			r = r + 1
		end
	end
	
	function group:removeAllGridImages()
		group.gridImages:removeSelf()
		group.gridImages = display.newGroup()
		group:insert(group.gridImages)
	end
	
		
	return group
end

return CraftGridView