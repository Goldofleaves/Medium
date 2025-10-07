SMODS.Atlas{key = "medium_enhancements", path = "enhancements.png", px = 71, py = 95}

SMODS.Enhancement { -- wild ^ 2
    key = 'plus_four',
    atlas = "medium_enhancements",
    pos = { x = 0, y = 0 },
    config = { bonus = 10, extra = { drawn_cards = 4} },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.drawn_cards } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            SMODS.draw_cards(card.ability.extra.drawn_cards)
            return {message = localize("k_drawn")}
        end
    end,
    in_pool = function (self, args)
        if G.GAME.modifiers.fusion_enhancements_spawn then
            return true
        end
        return false
    end
}

local card_is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local ret = card_is_suit_ref(self, suit, bypass_debuff, flush_calc)
    if SMODS.get_enhancements(self)["m_med_plus_four"] then
        return true
    end
    return ret
end