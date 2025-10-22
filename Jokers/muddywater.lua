SMODS.Joker({
	key = "muddywater",
	rarity = 2,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "fusion_suits" } 
        info_queue[#info_queue+1] = { set = "Other", key = "average" } 
        
    end,
	calculate = function(self, card, context)
        if context.before then
            if #context.full_hand == 2 then
                local a = (context.full_hand[1]:is_suit("Diamonds") and context.full_hand[2]:is_suit("Spades")) or (context.full_hand[2]:is_suit("Diamonds") and context.full_hand[1]:is_suit("Spades")) and not (context.full_hand[2]:is_suit("med_spears") or context.full_hand[1]:is_suit("med_spears"))
                print(a)
                if a then
                    for i = 1, 2 do
                    
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    context.full_hand[i]:flip()
                    play_sound('card1', percent)
                    context.full_hand[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))

            delay(0.1)

            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    assert(SMODS.change_base(context.full_hand[i], "med_spears"))
                    return true
                end
            }))

            delay(0.1)
            
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.15,
                func = function()
                    context.full_hand[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    context.full_hand[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))

                    end
                    return { message = localize("k_averaged") }
                end
            end
        end
	end
})