SMODS.Atlas{key = "medium_jokers", path = "jokers.png", px = 71, py = 95}

SMODS.Joker({
	key = "chiptunetracker",
	rarity = 2,
	config = {
		extra = {
			jank = 30
		},
	},
	pos = {x=0,y=0},
	atlas = "medium_jokers",
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            hpt.jank,
            colours = {G.C.ORANGE}
		}
		return { vars = vars }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {jank = card.ability.extra.jank}
        end
	end
})