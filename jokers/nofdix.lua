SMODS.Joker({
	key = "nofdix",
	rarity = 2,
	pos = {x=5,y=2},
	config = {
		extra = {
            dollars = 3
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            hpt.dollars,
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            next(SMODS.get_enhancements(context.other_card)) then
            return {
                dollars = card.ability.extra.dollars
            }
        end
	end
})