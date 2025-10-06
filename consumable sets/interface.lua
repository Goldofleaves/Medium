SMODS.Atlas{key = "medium_interfaces", path = "interface.png", px = 71, py = 95}

SMODS.ConsumableType({
	key = "Interface",
	collection_rows = { 6, 6 },
	primary_colour = HEX("b609f1"),
	secondary_colour = HEX("b609f1"),
	shop_rate = 0.3,
})

SMODS.Consumable({
	key = "vscode",
	set = "Spectral",
	atlas = "medium_interfaces",
	pos = {
		x = 1,
		y = 0
	},
	config = {
		extra = {
		},
	},
	loc_vars = function(self, info_queue, card)
	end,
	can_use = function(self, card)
	end,
	use = function(self, card, area, copier)
	end,
})
SMODS.Consumable({
	key = "chrome",
	set = "Interface",
	atlas = "medium_interfaces",
	pos = {
		x = 0,
		y = 0
	},
	config = {
		extra = {
		},
	},
	loc_vars = function(self, info_queue, card)
	end,
	can_use = function(self, card)
	end,
	use = function(self, card, area, copier)
	end,
})