if JokerDisplay then
    local jd_def = JokerDisplay.Definitions -- You can assign it to a variable to use as shorthand
jd_def.j_med_chemicalequation = {
        extra = {
            {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "odds" },
                { text = ")" },
            }
        },
        extra_config = { colour = G.C.RED, scale = 0.3 },
        calc_function = function(card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'med_chemequation')
            card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        end
}
jd_def.j_med_chiptunetracker = {
        text = {
            { text = "+" },
            { ref_table = "card.ability.extra", ref_value = "jank", retrigger_type = "mult" },
            { text = " Jank" },
        },
        text_config = { colour = G.C.ORANGE }
}    
jd_def.j_med_muddywater = {
        text = {
            { ref_table = "card.joker_display_values", ref_value = "suit", colour = G.C.IMPORTANT},
        },
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.GREY},
        },
        calc_function = function(card)
            local suit = "("..localize("k_none")..")"
    local active = "("..localize("jdis_inactive")..")"
    local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
    local text, _, scoring_hand = JokerDisplay.evaluate_hand(hand)
    if #hand == 2 then
        if hand[1].base.suit ~= hand[2].base.suit then
            active = "("..localize("jdis_active")..")"
            local a = (hand[1]:is_suit("Diamonds") and hand[2]:is_suit("Spades")) or (hand[2]:is_suit("Diamonds") and hand[1]:is_suit("Spades")) and not (hand[2]:is_suit("med_spears") or hand[1]:is_suit("med_spears"))
            if a then
                suit = "("..localize("med_spears", 'suits_plural')..")"
            end
        end
    end
    card.joker_display_values.suit = suit
    card.joker_display_values.active = active
        end
}

jd_def.j_med_cassette = {
        text = {
            { text = "...?" },
        },
        text_config = { colour = G.C.GREY }
}    
jd_def.j_med_achts = {
        text = {
            { ref_table = "card.ability.extra", ref_value = "jokerdisplayval", colour = G.C.GREEN},
        },
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "effect", colour = G.C.IMPORTANT},
        },
        calc_function = function(card)
            local fuck = card.ability.extra
            local ret = ""
            if fuck.currentroll == 0 then
                ret = "Inc. Def. Jank by "..fuck.incrementval
            else
                ret = "+"..fuck.plusjankval.." Jank"
            end
            card.joker_display_values.effect = ret
        end
}

jd_def.j_med_branching_tree = {
        text = {
            { ref_table = "G.GAME.pseudorandom", ref_value = "seed", colour = G.C.GREEN},
        },
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "non_seeded", colour = G.C.GREY},
            { ref_table = "card.joker_display_values", ref_value = "seeded", colour = G.C.RED},
        },
        calc_function = function(card)
            local nonseeded = ""
            local seeded = ""
            if G.GAME.seeded then
                seeded = localize("k_seeded")
            else
                nonseeded = localize("jdis_active")
            end
    card.joker_display_values.non_seeded = nonseeded
    card.joker_display_values.seeded = seeded
        end
}    

jd_def.j_med_rigor = {
        text = {
            { ref_table = "card.ability.extra", ref_value = "jdisplay", colour = G.C.IMPORTANT},
        },
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "reward_1", colour = G.C.GOLD},
            { ref_table = "card.joker_display_values", ref_value = "reward_3", colour = G.C.CHIPS},
            { ref_table = "card.joker_display_values", ref_value = "reward_4", colour = G.C.RED},
            { ref_table = "card.joker_display_values", ref_value = "reward_2_sharp", colour = G.C.RED },
            { ref_table = "card.joker_display_values", ref_value = "reward_2", colour = G.C.RED}
        },
        calc_function = function(card)
            local j = card.ability.extra.currentconjecture
            local reward1,reward2,reward2sharp,reward3,reward4 = "", "", "", "", ""
            if j == 1 then
                reward1 = "+$"..card.ability.extra.money
            elseif j == 2 then
                reward2sharp = "X"
                reward2 = ""..card.ability.extra.xmult
            elseif j==3 then
                reward3 = "+"..card.ability.extra.chips
            else
                reward4 = "+"..card.ability.extra.mult
            end
            card.joker_display_values.reward_1 = reward1
            card.joker_display_values.reward_2_sharp = reward2sharp
            card.joker_display_values.reward_2 = reward2
            card.joker_display_values.reward_3 = reward3
            card.joker_display_values.reward_4 = reward4
        end
}    
end