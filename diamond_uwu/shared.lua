Config = {}
Config.BobaPrice = 180
Config.CookiePrice = 150
Config.CupCakePrice = 150
Config.EggrollPrice = 220
Config.SaladPrice = 180
Config.SushiPrice = 180
Config.GroundPorkPrice = 100
Config.DeliveryCooldown = 1 -- In Minutes

Config.Recipes = {

['cooked_ground_pork'] = {
	Amount = 5,
	Animation = 'PROP_HUMAN_PARKING_METER',  -- Prepare or Cook (for Animation)
	Ingredients = { 
		['ground_pork'] = 5
	}
},

['uwu_btea'] = {
	Amount = 5,
	Animation = 'PROP_HUMAN_PARKING_METER',  -- Prepare or Cook (for Animation)
	Ingredients = { 
		['black_pearls'] = 5,
		['sugar'] = 5,
		['tea_powder'] = 5,
		['vanilla_essence'] = 5,
		['water'] = 5,
		['milk'] = 5
	}
},

['uwu_cookie'] = {
	Amount = 5,
	Animation = 'PROP_HUMAN_PARKING_METER', -- Prepare or Cook (for Animation)
	Ingredients = { 
		['butter'] = 5,
		['eggs'] = 5,
		['vanilla_essence'] = 5,
		['baking_soda'] = 5,
		['water'] = 5,
		['salt'] = 5,
		['flour'] = 5,
		['chocolate_chips'] = 5,
		['nuts'] = 5
	}
},

['uwu_cupcake'] = {
	Amount = 5,
	Animation = 'PROP_HUMAN_PARKING_METER', -- Prepare or Cook (for Animation)
	Ingredients = { 
		['cocoa_powder'] = 5,
		['flour'] = 5,
		['sugar'] = 5,
		['butter'] = 5,
		['vanilla_essence'] = 5,
		['eggs'] = 5,
		['milk'] = 5,
		['salt'] = 5
	}
},

['uwu_eggroll'] = {
	Amount = 5,
	Animation = 'PROP_HUMAN_PARKING_METER', -- Prepare or Cook (for Animation)
	Ingredients = { 
		['cooked_ground_pork'] = 5,
		['eggs'] = 5,
		['ginger'] = 5,
		['garlic_powder'] = 5,
		['cabbage'] = 5,
		['carrots'] = 5,
		['soy_sauce'] = 5
	}
},

['uwu_coleslaw_salad'] = {
	Amount = 5, 
	Animation = 'PROP_HUMAN_PARKING_METER', -- Prepare or Cook (for Animation)
	Ingredients = { 
		['coleslaw_mix'] = 5,
		['mayonnaise'] = 5,
		['apple_cider'] = 5,
		['honey'] = 5
	}
},

['uwu_sushi'] = {
	Amount = 5, 
	Animation = 'PROP_HUMAN_PARKING_METER', -- Prepare or Cook (for Animation)
	Ingredients = { 
		['water'] = 5,
		['white_rice'] = 5,
		['rice_vinegar'] = 5,
		['sugar'] = 5,
		['salt'] = 5,
		['nori'] = 5,
		['premade_crabmeat'] = 5,
		['cucumber'] = 5,
		['avocado'] = 5,
		['ginger'] = 5
	}
},

-- Uwu1 Meal
['uwu1'] = {
	Amount = 1, 
	Animation = 'PROP_HUMAN_BUM_BIN', 
	Ingredients = { 
		['uwu_btea'] = 5,
		['uwu_cookie'] = 5,
		['uwu_cupcake'] = 5,
	}
},

-- Uwu2 Meal
['uwu2'] = {
	Amount = 1, 
	Animation = 'PROP_HUMAN_BUM_BIN', 
	Ingredients = { 
		['uwu_btea'] = 5,
		['uwu_cookie'] = 5,
		['uwu_eggroll'] = 5,
	}
},

-- Uwu3 Meal
['uwu3'] = {
	Amount = 1, 
	Animation = 'PROP_HUMAN_BUM_BIN', 
	Ingredients = { 
		['uwu_btea'] = 5,
		['uwu_cookie'] = 5,
		['uwu_coleslaw_salad'] = 5,
	}
},

-- Uwu4  Meal
['uwu4'] = {
	Amount = 1, 
	Animation = 'PROP_HUMAN_BUM_BIN', 
	Ingredients = { 
		['uwu_btea'] = 5,
		['uwu_cookie'] = 5,
		['uwu_sushi'] = 5,
	}
},
}