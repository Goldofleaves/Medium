SMODS.Joker({
	key = "blue",
	rarity = 1,
	pos = {x = 3, y = 2},
	config = {
		extra = {
            xchips = 1
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            hpt.xchips
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.joker_main then
                return {xchips = hpt.xchips, message = localize("k_blue1")..hpt.xchips..localize("k_blue2"), colour = G.C.CHIPS, sound = "xchips"}
        end
	end
})