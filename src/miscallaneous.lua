SMODS.Atlas{key = "medium_fusionsuits", path = "fusionsuits.png", px = 71, py = 95}
SMODS.Atlas{key = "medium_fusionsuitsui", path = "fusionsuitsui.png", px = 18, py = 18}
SMODS.Suit{
    key = "spears",
    card_key = "SPEARS",
    lc_atlas = "medium_fusionsuits",
    hc_atlas = "medium_fusionsuits",
    hc_ui_atlas = 'medium_fusionsuitsui',
    lc_ui_atlas = 'medium_fusionsuitsui',
    lc_colour = HEX("6b4c2d"),
    hc_colour = HEX("6b4c2d"),
    pos = {y = 0},
    ui_pos = { x = 0, y = 0},
    in_pool = function (self, args)
        return false
    end
}

local card_is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    local ret = card_is_suit_ref(self, suit, bypass_debuff, flush_calc)
    if self.base.suit == "med_spears" and not flush_calc then
        if suit == "Diamonds" or suit == "Spades" then
            return true
        end
    end
    return ret
end