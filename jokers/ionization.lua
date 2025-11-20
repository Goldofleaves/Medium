SMODS.Joker({
	key = "ionization",
	rarity = 3,
	config = {
		extra = {
			rank = 8,
            difference = 1,
            enhancement = "m_bonus",
		},
	},
	pos = {x=2,y=2},
	atlas = "medium_jokers",
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.enhancement]
		local hpt = card.ability.extra
		local vars
		vars = {
            hpt.rank,
            hpt.difference,
            G.P_CENTERS[hpt.enhancement].label,
		}
		return {vars = vars }
	end,
	calculate = function(self, card, context)
        if context.after then
            card.fucckkkkkk = nil
        end
            local function isadjacentto(rank, difference, inputrank)
                if (rank + difference) == inputrank then
                    return true
                elseif (rank - difference) == inputrank then
                    return true
                end
                return false
            end
		local hpt = card.ability.extra
        if context.individual and context.cardarea == G.play and not card.fucckkkkkk then
            card.fucckkkkkk = true
            local bool = true
            local counter = 2
            for index, carde in ipairs(context.full_hand) do
                if carde:get_id() == hpt.rank and bool then
                    
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    carde:flip()
                    play_sound('card1', percent)
                    carde:juice_up(0.3, 0.3)
                    return true
                end
            }))

            delay(0.1)

            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    carde:set_ability(hpt.enhancement)
                    return true
                end
            }))

            delay(0.1)
            
            card_eval_status_text(card, 'extra', nil, percent, nil, {message = localize("k_enhanced"), colour = G.C.IMPORTANT})
            
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    carde:flip()
                    play_sound('tarot2', percent, 0.6)
                    carde:juice_up(0.3, 0.3)
                    return true
                end
            }))
            
                    bool = false
                end
                if isadjacentto(hpt.rank, hpt.difference, carde:get_id()) and counter >= 1 then
                    
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    carde:flip()
                    play_sound('card1', percent)
                    carde:juice_up(0.3, 0.3)
                    return true
                end
            }))

            delay(0.1)

            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    assert(SMODS.modify_rank(carde, hpt.rank - carde:get_id()))
                    return true
                end
            }))
            
            delay(0.1)

            card_eval_status_text(card, 'extra', nil, percent, nil, {message = localize("k_converted"), colour = G.C.IMPORTANT})

            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    carde:flip()
                    play_sound('tarot2', percent, 0.6)
                    carde:juice_up(0.3, 0.3)
                    return true
                end
            }))
                    counter = counter - 1
                end
            end
        end
	end
})