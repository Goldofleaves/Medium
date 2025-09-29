SMODS.Joker({
	key = "chemicalequation",
	rarity = 2,
	config = {
		extra = {
            odds = 4
		},
	},
    remove_from_deck = function (self, card, from_debuff)
        set_current_jank_operator("med_jank")
    end,
	pos = {x=1,y=0},
	atlas = "medium_jokers",
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "decapitated_jank" } 
        info_queue[#info_queue+1] = { set = "Other", key = "improved_jank" } 
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
                set_current_jank_operator("med_jank_decapitated")
                return {
                    message = localize('k_decapitated')
                }
            else
                set_current_jank_operator("med_jank_improved")
                return {
                    message = localize('k_improved')
                }
            end
        end
	end
})