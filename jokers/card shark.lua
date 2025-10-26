SMODS.Joker({
	key = "cardshark",
	rarity = 3,
	pos = {x=6,y=2},
	atlas = "medium_jokers",
	config = {
		extra = {
			additional = 3
		}
	},
	add_to_deck = function (self, card, from_debuff)
		G.GAME.max_injogged_cards = G.GAME.max_injogged_cards + card.ability.extra.additional
	end,
	remove_from_deck = function (self, card, from_debuff)
		G.GAME.max_injogged_cards = G.GAME.max_injogged_cards - card.ability.extra.additional
	end,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "injogged_cards" }
		local hpt = card.ability.extra
		local vars = {
			hpt.additional
		}
		return { vars = vars }
	end,
})