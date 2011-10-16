
Constants = {}
Constants.ROW_HEIGHT = 100
Constants.ROW_FONT_SIZE = 32
Constants.ROW_IMAGE_WIDTH = 64
Constants.ROW_IMAGE_HEIGHT = 64
Constants.SHOW_BACK_BUTTON = true

Constants.TEXT_TITLE_SIZE = 22
Constants.TEXT_DESCRIPTION_SIZE = 18

Constants.recipes = {
	woodenPlanksRecipe = 
	{
		title = "Wooden Planks",
		recipe =
		{
			image="Wooden_Plank.png", 
			value=4,
			{{}, {}, {}},
			{{}, {}, {}},
			{{}, {image="Wood.png"}, {}}
		},
		description = "Used as a building material and can be crafted into many things. Any form of wood used will still result in the same output.",
		ingredients = "Wood"
	},
	
	sticksRecipe = 
	{
		title = "Sticks",
		recipe =
		{
			image="Stick.png", 
			value=4,
			{{}, {}, {}},
			{{}, {image="Wooden_Plank.png"}, {}},
			{{}, {image="Wooden_Plank.png"}, {}}
		},
		description = "Used to craft torches, arrows, signs,\n ladders, fences and as handles for tools and weapons.",
		ingredients = "Wooden Plank"
	},
	
	torchesRecipe = 
	{
		title = "Torches",
		recipe =
		{
			image="Torch.png", 
			value=4,
			{{}, {}, {}},
			{{}, {image="Coal.png"}, {}},
			{{}, {image="Stick.png"}, {}}
		},
		description = "Used to create light. Torches also melt snow and ice.",
		ingredients = "Stick + Coal (or Charcoal)"
	},
	
	torchesRecipe = 
	{
		title = "Crafting Table",
		recipe =
		{
			image="Crafting_Table.png", 
			value=1,
			{{}, {}, {}},
			{{image="Wooden_Plank.png"}, {image="Wooden_Plank.png"}, {}},
			{{image="Wooden_Plank.png"}, {image="Wooden_Plank.png"}, {}}
		},
		description = "Allows the player to craft on a 3x3 grid.",
		ingredients = "Wooden Plank"
	},
	
	furnaceRecipe = 
	{
		title = "Furnace",
		recipe =
		{
			image="Furnace.png", 
			value=1,
			{{image="Cobblestone.png"}, {image="Cobblestone.png"}, {image="Cobblestone.png"}},
			{{image="Cobblestone.png"}, {}, 						{image="Cobblestone.png"}},
			{{image="Cobblestone.png"}, {image="Cobblestone.png"}, {image="Cobblestone.png"}}
		},
		description = "Allows the player to smelt.",
		ingredients = "Cobblestone"
	},
	
	chestRecipe = 
	{
		title = "Chest",
		recipe =
		{
			image="Chest.png", 
			value=1,
			{{image="Wooden_Plank.png"}, {image="Wooden_Plank.png"}, {image="Wooden_Plank.png"}},
			{{image="Wooden_Plank.png"}, {}, 							{image="Wooden_Plank.png"}},
			{{image="Wooden_Plank.png"}, {image="Wooden_Plank.png"}, {image="Wooden_Plank.png"}}
		},
		description = "Stores blocks and items inside. Place two chests side by side to create a larger chest with double the capacity.",
		ingredients = "Wooden Plank"
	},
	
	oreRecipe = 
	{
		title = "Ore Blocks",
		recipes =
		{
			{
				image="Lapis_Lazuli_(Block).png", 
				value=1,
				{{image="Lapis_Lazuli_(Dye).png"}, {image="Lapis_Lazuli_(Dye)"}, {image="Lapis_Lazuli_(Dye).png"}},
				{{image="Lapis_Lazuli_(Dye).png"}, {}, 								{image="Lapis_Lazuli_(Dye).png"}},
				{{image="Lapis_Lazuli_(Dye).png"}, {image="Lapis_Lazuli_(Dye).png"}, {image="Lapis_Lazuli_(Dye).png"}}
			},
			
			{
				image="Gold_(Block).png", 
				value=1,
				{{image="Gold_(Ingot).png"}, {image="Gold_(Ingot).png"}, {image="Gold_(Ingot).png"}},
				{{image="Gold_(Ingot).png"}, {}, 						{image="Gold_(Ingot).png"}},
				{{image="Gold_(Ingot).png"}, {image="Gold_(Ingot).png"}, {image="Gold_(Ingot).png"}}
			},
		},
		description = "Stores blocks and items inside. Place two chests side by side to create a larger chest with double the capacity.",
		ingredients = "Wooden Plank"
	},
}
