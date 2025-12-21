SMODS.Joker({
	key = "nofdix",
	rarity = 3,
	pos = {x=5,y=2},
	config = {
		extra = {
            xjank = 1.5
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            hpt.xjank,
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            next(SMODS.get_enhancements(context.other_card)) then
            return {
                xjank = card.ability.extra.xjank
            }
        end
	end
})