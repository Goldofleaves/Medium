SMODS.Joker({
	key = "kevin_haas",
	rarity = 4,
    cost = 20,
	config = {
		extra = {
            odds = 2,
            hand_amount = 1
		},
	},
	pos = {x=7,y=1},
	atlas = "medium_jokers",
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, hpt.odds, "med_kevin")
		local vars = {
            numerator,
            denominator,
            hpt.hand_amount,
			(hpt.hand_amount > 1 and localize("k_plural") or ""),
            colours = {G.C.ORANGE}
		}
		return { vars = vars }
	end,
	calculate = function(self, card, context)
        if context.setting_blind then
            if SMODS.pseudorandom_probability(card, "med_kevin", 1, card.ability.extra.odds) then
				G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand_amount
				ease_hands_played(card.ability.extra.hand_amount)
                return {
                    message = "+"..card.ability.extra.hand_amount.." "..localize("k_hand")..(card.ability.extra.hand_amount > 1 and localize("k_plural") or "")
                }
            end
        end
	end
})