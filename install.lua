for OX_Inventory:

go to ox_inventory\data\items.lua and paste these:

-- Uwu stuff	

	["cooked_ground_pork"] = {
		label = "Cooked Ground Pork",
		description = 'The name says it all. Do we have to stress it out?',
		weight = 50,
		stack = true,
		close = true,
		degrade = 80,
		decay = true
	},

	["ground_pork"] = {
		label = "Ground Pork Raw",
		description = 'You can buy these from the local supermarket or the butcher house. Or... The morgue? Who knows. XD',
		weight = 50,
		stack = true,
		close = true,
		degrade = 20,
		decay = true
	},

	["uwu_btea"] = {
		label = "Uwu Boba Tea",
		description = 'Tapioca-infused kawaii. Sip with extreme caution (or delight).',
		weight = 100,
		stack = true,
		close = true,
		degrade = 300,
		decay = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You have a Boba tea from Uwu Cafe! Share it!', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'The Boba tea ran out. Go get a refill?', 3500)
				end
			end
		}
	},

	["uwu_cookie"] = {
		label = "Uwu Meowkie",
		description = 'Crunchy adorableness. Prepare for a moew-verdose.',
		weight = 50,
		stack = true,
		close = true,
		degrade = 300,
		decay = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You have a Meowkie from Uwu Cafe! Share it!', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'The Meowkies are gone but not forever! Visit Uwu Cafe again!', 3500)
				end
			end
		}
	},

	["uwu_cupcake"] = {
		label = "Uwu Cupcake",
		description = 'Sugar-coated cuteness. Handle with (gloved) hands.',
		weight = 50,
		stack = true,
		close = true,
		degrade = 300,
		decay = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You have a Cupcake from Uwu Cafe! Share it!', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'The Cupcakes are gone but not forever! Visit Uwu Cafe again!', 3500)
				end
			end
		}
	},

	["uwu_eggroll"] = {
		label = "Uwu Eggrolls",
		description = 'Crispy, cute, and suspiciously huggable. Are they filled with savory goodness, or just pure, concentrated desu? One bite and you\'ll be asking, "Is this delicious, or just...adorable?',
		weight = 50,
		stack = true,
		close = true,
		degrade = 300,
		decay = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You have an Eggrolls from Uwu Cafe! Share it!', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'The Eggrolls are gone but not forever! Visit Uwu Cafe again!', 3500)
				end
			end
		}
	},

	["uwu_coleslaw_salad"] = {
		label = "Uwu Coleslaw",
		description = 'Even the humble cabbage has fallen prey to the kawaii overlords. A side dish so cute, you\'ll feel guilty eating it...almost.',
		weight = 50,
		stack = true,
		close = true,
		degrade = 300,
		decay = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You have an Coleslaw from Uwu Cafe! Share it!', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'The Coleslaw is gone but not forever! Visit Uwu Cafe again!', 3500)
				end
			end
		}
	},

	["uwu_sushi"] = {
		label = "Uwu Sushi",
		description = 'Tiny, adorable fishy friends, rolled in rice and existential kawaii. Prepare for a cuteness tsunami with every bite.',
		weight = 50,
		stack = true,
		close = true,
		degrade = 300,
		decay = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You have a Sushi from Uwu Cafe! Share it!', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'The Sushi is gone but not forever! Visit Uwu Cafe again!', 3500)
				end
			end
		}
	},

	["uwu1"] = {
		label = "Uwu Meal 1",
		description = 'A trifecta of sugary kawaii. It includes: Boba for your thirst, a "Meowkie" for your soul (whatever that is), and a cupcake for your... everything else. Prepare for peak adorableness.',
		weight = 50,
		stack = true,
		close = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You received an Uwu Combo meal 1. See the description to know what are included.', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'Be a responsible citizen and throw the paperbag in the trash', 3500)
				end
			end
		}
	},

	["uwu2"] = {
		label = "Uwu Meal 2",
		description = 'A symphony of kawaii and crunch. It includes: Boba for your thirst, a "Meowkie" for... reasons, and eggrolls for your inner, adorable glutton. Expect a delightful clash of sweet and savory, all wrapped in a blanket of pure, unadulterated uwu.',
		weight = 50,
		stack = true,
		close = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You received an Uwu Combo meal 2. See the description to know what are included.', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'Be a responsible citizen and throw the paperbag in the trash', 3500)
				end
			end
		}
	},

	["uwu3"] = {
		label = "Uwu Meal 3",
		description = 'A strategic blend of sweet, crunchy, and... surprisingly refreshing. It includes: Boba for the sugar rush, "Meowkie" (cookies, of course) for peak adorable, and coleslaw because even kawaii enthusiasts need their greens. It\'s the "I\'m cute, but health-conscious" combo.',
		weight = 50,
		stack = true,
		close = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You received an Uwu Combo meal 3. See the description to know what are included.', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'Be a responsible citizen and throw the paperbag in the trash', 3500)
				end
			end
		}
	},

	["uwu4"] = {
		label = "Uwu Meal 4",
		description = 'A full-on assault of kawaii. It includes: Boba for the sugar high, "Meowkie" (cookies, naturally) for the adorable overload, and sushi for a fishy, moe-filled finale. Prepare for a cuteness coma.',
		weight = 50,
		stack = true,
		close = true,
		client = {
			add = function(total)
				if total > 0 then
					--lib.notify({description = 'Nice burger you got there!'})
					exports['mythic_notify']:SendAlert('success', 'You received an Uwu Combo meal 4. See the description to know what are included.', 3500)
				end
			end,
	 
			remove = function(total)
				if total < 1 then
					--lib.notify({description = 'You lost all of your burgers!'})
					exports['mythic_notify']:SendAlert('error', 'Be a responsible citizen and throw the paperbag in the trash', 3500)
				end
			end
		}
	},