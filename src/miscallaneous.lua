SMODS.Atlas {
    key = "medium_fusionsuits",
    path = "fusionsuits.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "medium_fusionsuitsui",
    path = "fusionsuitsui.png",
    px = 18,
    py = 18
}
SMODS.Suit { -- diamonds + spades
    key = "spears",
    card_key = "SPEARS",
    lc_atlas = "medium_fusionsuits",
    hc_atlas = "medium_fusionsuits",
    hc_ui_atlas = 'medium_fusionsuitsui',
    lc_ui_atlas = 'medium_fusionsuitsui',
    lc_colour = HEX("6b4c2d"),
    hc_colour = HEX("6b4c2d"),
    pos = {
        y = 0
    },
    ui_pos = {
        x = 0,
        y = 0
    },
    in_pool = function(self, args)
        if G.GAME.modifiers.fusion_suits_spawn then
            return true
        end
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

local highlight_old = Card.highlight
function Card:highlight(highlighted)
    highlight_old(self, highlighted)
    if not self.highlighted then
        if self.children.med_merge_button then
            self.children.med_merge_button:remove()
            self.children.med_merge_button = nil
        end
    end

    if self.highlighted and LAB.in_lab and self.ability.set == 'Joker' then
        self.children.med_merge_button = UIBox {
            definition = MEDIUM.merge_emplace(self),
            config = {
                align = "bmi",
                offset = {
                    x = 0,
                    y = 0.5
                },
                parent = self
            }
        }
    end
end

function MEDIUM.merge_emplace(card)
    return {
        n = G.UIT.R,
        config = {
            ref_table = card,
            r = 0.08,
            padding = 0.1,
            align = "bm",
            minh = 0.2 * card.T.h,
            hover = true,
            shadow = true,
            colour = G.C.RED,
            one_press = true,
            button = 'merge_emplace',
            func = 'merge_retrieve_emplace'
        },
        nodes = {{
            n = G.UIT.R,
            config = {
                align = 'cm'
            },
            nodes = {{
                n = G.UIT.T,
                config = {
                    text = "MERGE",
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.4,
                    shadow = true
                }
            }}
        }}
    }
end

function G.FUNCS.merge_retrieve_emplace(e)
    if e.config.ref_table.area == G.jokers then
        e.children[1].children[1].config.text = "MERGE"
        if G.merge_1 and G.merge_1.cards and(#G.merge_1.cards > 0 and #G.merge_2.cards > 0) then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.RED
            e.config.button = 'merge_emplace'
        end
    else
        e.children[1].children[1].config.text = "TAKE"
            e.config.colour = G.C.RED
            e.config.button = 'merge_retireve'
    end
end

-- animated sprites support
MEDIUM.animated_sprites = {
    achts = {
        current_frame = 1,
        max_frames = 6,
        current_cycle = 1,
        cycle_time = 10
    }
}

MEDIUM.merge_table = {}

MEDIUM.lab_create_merge_pattern = function(key1, key2, resultkey)
    if not MEDIUM.merge_table[key1] then
        MEDIUM.merge_table[key1] = {
            [key2] = resultkey
        }
    else
        MEDIUM.merge_table[key1][key2] = resultkey
    end
    -- making this a function so we can probably also do ui jank here when recipes comes out
end

MEDIUM.lab_create_merge_pattern("j_joker", "j_joker", "j_caino")
MEDIUM.lab_create_merge_pattern("j_dusk", "j_burnt", "j_med_sunrise")
MEDIUM.lab_create_merge_pattern("j_scholar", "j_loyalty_card", "j_med_rigor")
MEDIUM.lab_create_merge_pattern("j_scholar", "j_dna", "j_med_chemicalequation")

function MEDIUM.merge(result_area, area1, area2, check)
    if not area1 then
        area1 = G.merge_1
    end
    if not area2 then
        area2 = G.merge_2
    end
    local card1, card2 = area1.cards[1], area2.cards[1]
    local destroy_cards = {area1.cards[1], area2.cards[1]}
    for k, v in pairs(MEDIUM.merge_table) do
        if card1 and k == card1.config.center.key then
            for kk, vv in pairs(v) do
                if card2 and kk == card2.config.center.key then
                    if not check then
                    SMODS.destroy_cards(destroy_cards)
                    SMODS.add_card({
                        key = vv,
                        area = result_area
                    })
                else
                    return true
                end
                end
            end
        elseif card2 and k == card2.config.center.key then
            for kk, vv in pairs(v) do
                if card1 and kk == card1.config.center.key then
                if not check then
                    SMODS.destroy_cards(destroy_cards)
                    SMODS.add_card({
                        key = vv,
                        area = result_area
                    })
                else
                    return true
                end

                end
            end
        end
    end
    return nil
end

function MEDIUM.move_card(card, _area)
    local area = card.area
    card:remove_from_deck()

    if not card.getting_sliced then
        area:remove_card(card)
        card:add_to_deck()
        _area:emplace(card)

    end
end


    G.FUNCS.med_can_merge = function(e)
        if ((G.GAME.dollars - G.GAME.bankrupt_at) - LAB.merge_cost < 0) or not MEDIUM.merge(G.result, nil, nil, true) or
            (#G.merge_1.cards == 0 or #G.merge_2.cards == 0) then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.GREEN
            e.config.button = 'med_lab_merge'
        end
    end

    G.FUNCS.med_lab_merge = function(e)
        ease_dollars(-LAB.merge_cost)
        LAB.merge_cost = LAB.merge_cost + LAB.merge_cost_increase
        MEDIUM.merge(G.result)

        G.result.cards[1].old_area = G.merge_1.cards[1].old_area or G.jokers
    end

    G.FUNCS.merge_emplace = function(e)
        local card = e.config.ref_table
        if #G.merge_1.cards == 0 then
            card.old_area = card.area
            MEDIUM.move_card(card, G.merge_1)
        else
            card.old_area = card.area
            MEDIUM.move_card(card, G.merge_2)
        end
    end

    G.FUNCS.merge_can_emplace = function(e)
        if G.merge_1 and G.merge_2 and (#G.merge_1.cards > 0 and #G.merge_2.cards > 0) then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.GREEN
            e.config.button = 'merge_emplace'
        end
    end

    G.FUNCS.merge_retireve = function(e)
        local card = e.config.ref_table
        if card.old_area and card.old_area.config.card_limit > #card.old_area.cards then
            MEDIUM.move_card(card, card.old_area or G.jokers)
            card.old_area = nil
        else
            MEDIUM.move_card(card, card.old_area or G.jokers)
            card.old_area = nil
        end
    end

    G.FUNCS.merge_can_retireve = function(e)
        local card = e.config.ref_table
        if card.old_area.cards.card_limit > #card.old_area.cards then
            e.config.colour = G.C.GREEN
            e.config.button = 'mmerge_retireve'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end

function move_deck()
    
    LAB.old_deck_pos = G.deck.T.y

    G.deck.T.y = 25
    
    G.deck:align_cards()

end

function reset_deck()

    if LAB.old_deck_pos then
        G.deck.T.y = LAB.old_deck_pos

        LAB.old_deck_pos = nil

        G.deck:align_cards()
    end

end