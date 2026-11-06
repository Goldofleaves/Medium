local function is_in_boss_blind()
	return G.GAME and G.GAME.blind and G.GAME.blind.boss
end
SMODS.Joker({
	key = "calling_card",
	rarity = 3,
	pos = {x = 6, y = 4},
	atlas = "medium_jokers",
	config = {
		extra = {
			cur_method = "kamoshida",
			disabled = false
		}
	},
	loc_vars = function (self, info_queue, card)
		local key = self.key .. "_" .. (is_in_boss_blind() and "active" or "inactive")
		local hpt = card.ability.extra
		info_queue[#info_queue + 1] = {
			set = "Other",
			key = "cc_treasure"
		}
		if is_in_boss_blind() and not hpt.disabled then
			info_queue[#info_queue + 1] = {
				set = "Other",
				key = "cc_" .. card.ability.extra.cur_method
			}
		end
		return { key = key}
	end,
	calculate = function (self, card, context)
		local hpt = card.ability.extra
		local all = {
			"kamoshida",
			"madarame",
			"kaneshiro",
			"okumura"
		}
		local cond = {
			kamoshida = function (card, context)
				if context.joker_main then
					for i = 1, #context.full_hand do
						if not context.full_hand[i]:is_suit("Hearts") then
							return
						end
					end
					if #context.full_hand >= 5 then
						return true
					end
				end
			end,
			madarame = function(card, context)
				if context.playing_card_added then
					return true
				end
			end,
			kaneshiro = function(card, context)
				if context.selling_card and context.card.ability.set == 'Joker' then
					return true
				end
			end,
			okumura = function(card, context)
				if context.destroying_card and not context.blueprint then
					return true
				end
			end,
		}
		if is_in_boss_blind() and not hpt.disabled then
			if cond[hpt.cur_method](card, context) then
				ease_dollars(20)
				G.GAME.blind:disable()
				play_sound('timpani')
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Heart taken!" })
				hpt.disabled = true
			end
		end
		if context.end_of_round and hpt.disabled then
			hpt.disabled = false
			hpt.cur_method = pseudorandom_element(all)
		end
	end
})