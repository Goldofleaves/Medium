SMODS.Joker({
	key = "chemicalequation",
	rarity = 2,
	config = {
		extra = {
            odds = 4
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, hpt.odds, "med_chemequation")
		local vars = {
            numerator,
            denominator,
            colours = {G.C.ORANGE}
		}
		return { vars = vars }
	end,
	calculate = function(self, card, context)
        if context.setting_blind then
            if SMODS.pseudorandom_probability(card, "med_chemequation", 1, card.ability.extra.odds) then
                SMODS.set_scoring_calculation("med_jank_decapitated")
                return {
                    message = localize('k_decapitated')
                }
            else
                SMODS.set_scoring_calculation("med_jank_improved")
                return {
                    message = localize('k_improved')
                }
            end
        end
	end
})