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
                    assert(SMODS.change_base(context.full_hand[1], "med_spears"))
                    assert(SMODS.change_base(context.full_hand[2], "med_spears"))
                    return { message = localize("k_averaged") }
                end
            end
        end
	end
})