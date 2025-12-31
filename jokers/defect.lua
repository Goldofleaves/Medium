local function get_orb_from_index(i)
    local all_orbs = {[0] = "none", "dark", "lightning", "plasma"}
   return all_orbs[i]
end
local function transform_name_to_num(name)
   local array = {
        none = 0,
        dark = 1,
        lightning = 2,
        plasma = 3
   } 
   return array[name]
end


SMODS.Joker({
	key = "defect",
	rarity = 3,
	config = {
        extra = {
            orbs = {
                0, 0, 0
            },
            speed = 1
        }
	},
    add_to_deck = function (self, card, from_debuff)
        card.ability.extra.speed = 0.5 + pseudorandom("defspeed") 
    end,
	pos = {x=2,y=4},
    soul_pos = {x=3,y=4},
	loc_vars = function(self, info_queue, card)
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
        local hpt = card.ability.extra
        local orb_evoke_funcs = {
            none = function ()
                
            end,
            dark = function ()
                ease_discard(2)
            end,
            lightning = function ()
                ease_dollars(10)
            end,
            plasma = function ()
                ease_hands_played(2)
            end,
        }
        local orb_funcs = {
            none = function (self, card, context)
                local hpt = card.ability.extra
                
            end,
            dark = function (self, card, context)
                local hpt = card.ability.extra
                if context.joker_main then
                    if G.GAME.current_round.hands_left < 1 then
                        return {mult = 6 * G.GAME.round_resets.hands}
                    end
                end
            end,
            lightning = function (self, card, context)
                local hpt = card.ability.extra
                if context.joker_main then
                    return {mult = 10}
                end
            end,
            plasma = function (self, card, context)
                local hpt = card.ability.extra
                if context.setting_blind then
                    ease_hands_played(1)
                end
            end,
        }
        if context.setting_blind then
            local changed = false
            for k, v in ipairs(hpt.orbs) do
                if v == 0 and not changed then
                    local c = pseudorandom("pingas", 1, 3)
                    local old_v = v
                    hpt.orbs[k] = c
                    changed = true
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                    { message = localize('k_defect_channeled')})
                end
            end
            if not changed then
                local c = pseudorandom("pingas", 1, 3)
                local old_v = hpt.orbs[c]
                hpt.orbs[c] = pseudorandom("pingas", 1, 3)
                local effect = get_orb_from_index(old_v)
                orb_evoke_funcs[effect]()
                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_defect_evoked')})
            end
        end
        for k, v in ipairs(hpt.orbs) do
            local effect = get_orb_from_index(v)
            SMODS.calculate_effect(orb_funcs[effect](self, card, context) or {}, card)
        end
	end
})

local gcu = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local ret = gcu(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if card and card.config and card.config.center and card.config.center.key and card.config.center.key == "j_med_defect" then
        for i = 1, 3 do
            generate_card_ui({
                set = "Other",
                key = "defect_"..get_orb_from_index(card.ability.extra.orbs[i])
            }, ret)
        end
    end
    return ret
end

SMODS.Atlas({
    key = 'defect_orbs',
    path = 'defect_orbs.png',
    px = 20,
    py = 20
})

SMODS.Atlas({
    key = 'defect_ring',
    path = 'defect_ring.png',
    px = 100,
    py = 100
})
MEDIUM.defect_vars = {}
SMODS.DrawStep(
    {
        key = 'defect_ring',
        order = -25,
        func = function(card, layer)
            if card.config.center.key == "j_med_defect" and (card.config.center.discovered or card.bypass_discovery_center) then
                local _xOffset = (71 - 100) / 2 / 30 + 4/60
                local _yOffset = (95 - 100) / 2 / 30
                MEDIUM.defect_vars.defect_ring = MEDIUM.defect_vars.defect_ring or
                Sprite(card.T.x + 0, card.T.y + 0, 100, 100, G.ASSET_ATLAS["med_defect_ring"], { x = 0, y = 0 })
                MEDIUM.defect_vars.defect_ring.role.draw_major = card
                MEDIUM.defect_vars.defect_ring:draw_shader('dissolve', 0, nil, nil, card.children.center, 0,
                    0, _xOffset, 0.1 + 0.03 + _yOffset, nil, 0.6)
                MEDIUM.defect_vars.defect_ring:draw_shader('dissolve', nil, nil, nil, card.children.center,
                    0, 0, _xOffset, _yOffset)
            end
        end,
    }
)
local r = 80
local tau = math.pi * 2
-- x += cos(theta) * r
-- y += sin(theta) * r
SMODS.DrawStep(
    {
        key = 'defect_orbs',
        order = 10,
        func = function(card, layer)
            if card.config.center.key == "j_med_defect" and (card.config.center.discovered or card.bypass_discovery_center) then
                for i = 1, 3 do
                    local _xOffset = 71 / 2 / 2 / 30 + math.cos((G.TIMERS.REAL * card.ability.extra.speed + tau/3 * i)) * r/60 + 3/60
                    local _yOffset = 95 / 2 / 2 / 30 + math.sin((G.TIMERS.REAL * card.ability.extra.speed + tau/3 * i)) * r/60 + 10/60
                    MEDIUM.defect_vars["defect_orbs"..i] = MEDIUM.defect_vars["defect_orbs"..i] or
                    Sprite(card.T.x + 0, card.T.y + 0, 20, 20, G.ASSET_ATLAS["med_defect_orbs"], { x = card.ability.extra.orbs[i] or 0, y = 0 })
                    MEDIUM.defect_vars["defect_orbs"..i]:set_sprite_pos({ x = card.ability.extra.orbs[i] or 0, y = 0 })
                    MEDIUM.defect_vars["defect_orbs"..i].role.draw_major = card
                    MEDIUM.defect_vars["defect_orbs"..i]:draw_shader('dissolve', 0, nil, nil, card.children.center, 0,
                        0, _xOffset, 0.1 + 0.03 + _yOffset, nil, 0.6)
                    MEDIUM.defect_vars["defect_orbs"..i]:draw_shader('dissolve', nil, nil, nil, card.children.center,
                        0, 0, _xOffset, _yOffset)
                end
            end
        end,
    }
)