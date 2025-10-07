SMODS.Joker({
	key = "sunrise",
	rarity = 3,
	pos = {x=5,y=0},
	config = {
		extra = {
			hands = 2,
			temp_hands_var = 2
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            hpt.hands,
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.setting_blind then
			hpt.temp_hands_var = hpt.hands
		end
		if context.before and hpt.temp_hands_var > 0 then
			hpt.temp_hands_var = hpt.temp_hands_var - 1
            return {
                level_up = true,
                message = localize('k_level_up_ex')
            }
        end
	end
})