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
jd_def.j_med_blue = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "xchips", retrigger_type = 'exp'},
            },
            border_colour = G.C.CHIPS
        }
    },
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
            { ref_table = "card.joker_display_values", ref_value = "fuck", colour = G.C.IMPORTANT},
            { ref_table = "card.joker_display_values", ref_value = "number", colour = G.C.IMPORTANT, retrigger_type = "mult" },
            { ref_table = "card.joker_display_values", ref_value = "ending", colour = G.C.IMPORTANT},
        },
        calc_function = function(card)
            local fuck = card.ability.extra
            local ret = ""
            if fuck.currentroll == 0 then
                ret = localize("k_jdisplay_incdefjank")..fuck.incrementval
            else
                ret = "+"..fuck.plusjankval.." "..localize("k_jdisplay_jank")
            end
            local num
            if fuck.currentroll == 0 then
                num = fuck.incrementval
            else
                num = fuck.plusjankval
            end
            local endig = ""
            if fuck.currentroll == 0 then
            else
                endig = localize("k_jdisplay_jank")
            end
            card.joker_display_values.effect = ret
            card.joker_display_values.number = num
            card.joker_display_values.ending = endig
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

jd_def.j_med_ionization = {
        text = {
            { ref_table = "card.ability.extra", ref_value = "rank", colour = G.C.IMPORTANT},
        },
        reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "rank1", colour = G.C.GREY},
            { text = ", ", colour = G.C.GREY},
            { ref_table = "card.joker_display_values", ref_value = "rank2", colour = G.C.GREY},
            { text = ", ", colour = G.C.GREY},
            { ref_table = "card.joker_display_values", ref_value = "enhancement", colour = G.C.GREY},
        },
        calc_function = function(card)
            local rank1, rank2, enhancement
            rank1 = card.ability.extra.rank - card.ability.extra.difference
            rank2 = card.ability.extra.rank + card.ability.extra.difference
            enhancement = G.P_CENTERS[card.ability.extra.enhancement].label
    card.joker_display_values.rank1 = rank1
    card.joker_display_values.rank2 = rank2
    card.joker_display_values.enhancement = enhancement
        end
}    

jd_def.j_med_rigor = {
    text = {
        {
            border_nodes = {
                { ref_table = "card.ability.extra", ref_value = "jdisplay", color = G.C.IMPORTANT},
            },
        }
    },
    reminder_text = {
        {
            border_nodes = {
                { ref_table = "card.joker_display_values", ref_value = "text1", color = G.C.IMPORTANT},
                { ref_table = "card.joker_display_values", ref_value = "text2", color = G.C.IMPORTANT}
            },
        }
    },
    calc_function = function(card)
            local j = card.ability.extra.currentconjecture
            local reward = ""
            local rewardk = 0
            if j == 1 then
                reward = "+$"
                rewardk = card.ability.extra.money
            elseif j == 2 then
                reward = "X"
                rewardk = card.ability.extra.xmult
            elseif j==3 then
                reward = "+"
                rewardk = card.ability.extra.chips
            else
                reward = "+"
                rewardk = card.ability.extra.mult
            end
            card.joker_display_values.text1 = reward
            card.joker_display_values.text2 = rewardk
    end,
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[1].children[1] then
            local border_config = text.children[1].config
            local text_config = text.children[1].children[1].config
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.UI.TEXT_LIGHT
        end
        if reminder_text and reminder_text.children[1] and reminder_text.children[1].children[1] then
            local border_config = reminder_text.children[1].config
            local text_config = reminder_text.children[1].children[1].config

            local j = card.ability.extra.currentconjecture
            if j == 1 then
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.GOLD
            end
            if j == 2 then
                border_config.colour = G.C.MULT
                text_config.colour = G.C.UI.TEXT_LIGHT
            end
            if j == 3 then
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.CHIPS
            end
            if j == 4 then
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.MULT
            end
        end
        if reminder_text and reminder_text.children[1] and reminder_text.children[1].children[2] then
            local border_config = reminder_text.children[1].config
            local text_config = reminder_text.children[1].children[2].config

            local j = card.ability.extra.currentconjecture
            if j == 1 then
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.GOLD
            end
            if j == 2 then
                border_config.colour = G.C.MULT
                text_config.colour = G.C.UI.TEXT_LIGHT
            end
            if j == 3 then
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.CHIPS
            end
            if j == 4 then
                border_config.colour = G.C.CLEAR
                text_config.colour = G.C.MULT
            end
            return true
        end
        return false
    end
}    
end