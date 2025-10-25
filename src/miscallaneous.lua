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

    if self.highlighted and LAB.in_lab and (self.ability.set == 'Joker' or self:is_playing_card()) then
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

function Card:is_playing_card()
    if self.ability.set == "Default" or self.ability.set == "Enhanced" then
        return true
    end
    return false
end

local click_old = Card.click
function Card:click()
    local ret = click_old(self)

    if self and self.ability.set == "med_not_for_public" then
       G.FUNCS.med_deck_info()
    end
    return ret
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
                    text = localize("ui_lab_button_merge"),
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.4,
                    shadow = true
                }
            }}
        }}
    }
end

function MEDIUM.nxt_st(card)
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
            button = 'next_suiting',
            func = 'suit_my_next'
        },
        nodes = {{
            n = G.UIT.R,
            config = {
                align = 'cm'
            },
            nodes = {{
                n = G.UIT.T,
                config = {
                    text = localize("ui_lab_button_next"),
                    colour = G.C.UI.TEXT_LIGHT,
                    scale = 0.4,
                    shadow = true
                }
            }}
        }}
    }
end

function G.FUNCS.merge_retrieve_emplace(e)
    if e.config.ref_table.area == G.jokers or e.config.ref_table.area == G.SUITS_AREA then
        e.children[1].children[1].config.text = localize("ui_lab_button_merge")
        if G.merge_1 and G.merge_1.cards and(#G.merge_1.cards > 0 and #G.merge_2.cards > 0) then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.RED
            e.config.button = 'merge_emplace'
        end
    else
        e.children[1].children[1].config.text = localize("ui_lab_button_take")
            e.config.colour = G.C.RED
            e.config.button = 'merge_retireve'
    end
end


-- animated sprites support
MEDIUM.animated_sprites = {
    j_med_achts = {
        current_frame = 1,
        max_frames = 6,
        --current_cycle = 1,
        --cycle_time = 10,
        timeperframe = 1/20,
        current_time = 0,
        yvalue = 1,
        originalpos = {x=2,y=0},
    },
    j_med_nofdix = {
        current_frame = 1,
        max_frames = 6,
        --current_cycle = 1,
        --cycle_time = 25,
        timeperframe = 1/6,
        current_time = 0,
        yvalue = 3,
        originalpos = {x=5,y=2},
    }
}

MEDIUM.merge_table = {}

MEDIUM.lab_create_merge_pattern = function(key1, key2, resultkey)
    local tab = {
        key1,
        key2,
        resultkey
    }
    if not MEDIUM.merge_table[key1] then
        MEDIUM.merge_table[key1] = {
            [key2] = resultkey
        }
    else
        MEDIUM.merge_table[key1][key2] = resultkey
    end
    -- making this a function so we can probably also do ui jank here when recipes comes out

    if not MEDIUM.MERGE_LIST then MEDIUM.MERGE_LIST = {} end

    MEDIUM.MERGE_LIST[#MEDIUM.MERGE_LIST+1] = G.P_CENTERS[key1]

    MEDIUM.MERGE_LIST[#MEDIUM.MERGE_LIST+1] = G.P_CENTERS[key2]

    MEDIUM.MERGE_LIST[#MEDIUM.MERGE_LIST+1] = G.P_CENTERS[resultkey]
end


SMODS.current_mod.reset_game_globals = function(run_start)
	if run_start then
    create_merge_list()
	end
end

function MEDIUM.merge(result_area, area1, area2, check)
    if not area1 then
        area1 = G.merge_1
    end
    if not area2 then
        area2 = G.merge_2
    end
    local card1, card2 = area1.cards[1], area2.cards[1]
    if card1 and card1.config.center.key == "j_med_elixir" then
        if check then
            return true
        end
        local crad = copy_card(card1)
        crad:add_to_deck()
        local edition
        local editions = {}
        for k, v in pairs(G.P_CENTERS) do
            if v.set == "Edition" then
                table.insert(editions, k)
            end
        end  
        edition = pseudorandom_element(editions, "elixir")
        crad:set_edition(poll_edition("elixir", nil, false, true))
        G.result:emplace(crad)
        SMODS.destroy_cards({area1.cards[1], area2.cards[1]}, true, true, true)
        return nil
    end
    if card2 and card2.config.center.key == "j_med_elixir" then
        if check then
            return true
        end
        local crad = copy_card(card1)
        crad:add_to_deck()
        local edition
        local editions = {}
        for k, v in pairs(G.P_CENTERS) do
            if v.set == "Edition" then
                table.insert(editions, k)
            end
        end  
        edition = pseudorandom_element(editions, "elixir")
        crad:set_edition(edition)
        G.result:emplace(crad)
        SMODS.destroy_cards({area1.cards[1], area2.cards[1]}, true, true, true)
        return nil
    end
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
    if _area and _area.cards then
G.E_MANAGER:add_event(Event({
    trigger = "after",
    delay = 0.1,
    func = function()
    local area = card.area
    card:remove_from_deck()

    if not card.getting_sliced then
        if _area.cards then
        area:remove_card(card)
        card:add_to_deck()
        play_sound("card1")
        
        _area:emplace(card)
        end
    end
        return true
    end
}))
end
end


    G.FUNCS.suit_my_next = function(e)
        if LAB.suit_lock then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        else
            e.config.colour = G.C.GREEN
            e.config.button = 'next_suiting'
        end
    end

    G.FUNCS.next_suiting = function(e)
       next_suit()
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
        local carda = card.area
        if card:is_playing_card() then
            MEDIUM.move_card(card, G.SUITS_AREA)
            merge_save_nil(carda)
        else
        if card.old_area and card.old_area.config.card_limit > #card.old_area.cards then
            MEDIUM.move_card(card, card.old_area or G.jokers)
            merge_save_nil(carda)
            card.old_area = nil
            
        else
            MEDIUM.move_card(card, card.old_area or G.jokers)
            merge_save_nil(carda)
            card.old_area = nil
            
        end
        end

        G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end}))
    end

    G.FUNCS.merge_can_retireve = function(e)
        local card = e.config.ref_table
        if card.old_area.cards.card_limit > #card.old_area.cards then
            e.config.colour = G.C.GREEN
            e.config.button = 'merge_retireve'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end


function ez_move(card, reverse, area)
    if not area then area = G.deck end
    if not reverse then
        draw_card(area, G.SUITS_AREA, 100, 'up', true, card)
    else
        draw_card(G.SUITS_AREA, area, 100, 'up', true, card)
    end
end



function next_suit()

    LAB.suit_lock = true

    for k, v in pairs(G.SUITS_AREA.cards) do
        if v and v.children.switch_suits then
            v.children.switch_suits = nil
        end
    end

    suit_check_merge()

    if not LAB.current_suit then
        LAB.current_suit = 0
    end

    if LAB.current_suit >= #LAB.SUITS then
        LAB.current_suit = 1
    else
        LAB.current_suit = LAB.current_suit + 1
    end

    if G.SUITS_AREA and G.SUITS_AREA.cards and #G.SUITS_AREA.cards > 0 then
        for k, v in pairs(G.SUITS_AREA.cards) do
            MEDIUM.move_card(v, G.deck)
        end
    end

    for k, v in pairs(G.deck.cards) do
        if v.base.suit == LAB.SUITS[LAB.current_suit] then
            MEDIUM.move_card(v, G.SUITS_AREA)
            v.children.switch_suits = UIBox {
                definition = MEDIUM.nxt_st(v),
                config = {
                    align = "bmi",
                    offset = {
                        x = 0,
                        y = 0.5
                    },
                    parent = G.SUITS_AREA
                }
            }
        end
    end

    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
            save_run();
            LAB.suit_lock = false;
            return true
        end
    }))

end



function reset_merge()
    if G.merge_1.cards[1] then
        if G.merge_1.cards[1]:is_playing_card() then
            MEDIUM.move_card(G.merge_1.cards[1], G.deck)
        else
            MEDIUM.move_card(G.merge_1.cards[1], G.jokers)
        end
    end
    if G.merge_2.cards[1] then
        if G.merge_2.cards[1]:is_playing_card() then
            MEDIUM.move_card(G.merge_2.cards[1], G.deck)
        else
            MEDIUM.move_card(G.merge_2.cards[1], G.jokers)
        end
    end

    if G.result.cards[1] then
        if G.result.cards[1]:is_playing_card() then
            MEDIUM.move_card(G.result.cards[1], G.deck)
        else
            MEDIUM.move_card(G.result.cards[1], G.jokers)
        end
    end

    for k, v in pairs(G.SUITS_AREA.cards) do
        MEDIUM.move_card(v, G.deck)
    end

    LAB.load_merge_1 = nil
    LAB.load_merge_2 = nil
    LAB.load_SUITS_AREA = nil
    LAB.load_result = nil

end

function suit_check_merge()
    LAB.SUITS = {}
        for k, v in pairs(SMODS.Suits) do
          for kk, vv in pairs(G.deck.cards) do
            if vv.base.suit == k then
                LAB.SUITS[#LAB.SUITS+1] = k
                break
            end
        end
      end
end

function merge_save_nil(args)
    if args == G.merge_1 then
        LAB.load_merge_1 = nil
    else
        LAB.load_merge_2 = nil
    end
end

function create_merge_list()
        if not MEDIUM.MERGE_LIST then
        MEDIUM.MERGE_LIST = {}

        MEDIUM.lab_create_merge_pattern("j_joker", "j_joker", "j_caino")
        MEDIUM.lab_create_merge_pattern("j_dusk", "j_burnt", "j_med_sunrise")
        MEDIUM.lab_create_merge_pattern("j_scholar", "j_loyalty_card", "j_med_rigor")
        MEDIUM.lab_create_merge_pattern("j_scholar", "j_dna", "j_med_chemicalequation")
        MEDIUM.lab_create_merge_pattern("j_splash", "j_erosion", "j_med_muddywater")
    end
end

function MEDIUM.INIT_COLLECTION_CARD_ALERTS()
  for j = 1, #G.merge_list do
    for _, v in ipairs(G.merge_list[j].cards) do
      v:update_alert()
    end
  end
end

G.FUNCS.aeaeae = function(e)
create_merge_list()
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu{
    definition = create_UI_merge_list(),
  }
end

G.FUNCS.your_collecion_merge_list = function(args)
  if not args or not args.cycle_config then return end
  for j = 1, #G.merge_list do
    for i = #G.merge_list[j].cards,1, -1 do
      local c = G.merge_list[j]:remove_card(G.merge_list[j].cards[i])
      c:remove()
      c = nil
    end
  end
  for i = 1, 3 do
    for j = 1, #G.merge_list do
      local center = MEDIUM.MERGE_LIST[i+(j-1)*3 + (3*#G.merge_list*(args.cycle_config.current_option - 1))]
      if not center then break end
      local card = Card(G.merge_list[j].T.x + G.merge_list[j].T.w/2, G.merge_list[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
      
      G.merge_list[j]:emplace(card)
    end
  end
  MEDIUM.INIT_COLLECTION_CARD_ALERTS()
end

function create_UI_merge_list()
  local deck_tables = {}

  table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.T, config = { text = " ENTRY", colour = G.C.UI.TEXT_DARK, scale = 0.55}},
      {n=G.UIT.T, config = { text = "     ENTRY    ", colour = G.C.UI.TEXT_DARK, scale = 0.55, padding =0.95}},  -- this is so stupid please change this im begging
      {n=G.UIT.T, config = { text = "RESULT", colour = G.C.UI.TEXT_DARK, scale = 0.55}}
    }}
  )

table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.15, no_fill = true}, nodes={}}
  )

  G.merge_list = {}
  for j = 1, 3 do
    G.merge_list[j] = CardArea(
      G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
      3*G.CARD_W,
      0.95*G.CARD_H, 
      {card_limit = 3, type = 'title', highlight_limit = 0, collection = true})
    table.insert(deck_tables, 
    {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
      {n=G.UIT.O, config={object = G.merge_list[j]}}
    }}
    )
  end

  local joker_options = {}
  for i = 1, math.ceil(#MEDIUM.MERGE_LIST/(3*#G.merge_list)) do
    table.insert(joker_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#MEDIUM.MERGE_LIST/(3*#G.merge_list))))
  end

  for i = 1, 3 do
    for j = 1, #G.merge_list do
      local center = MEDIUM.MERGE_LIST[i+(j-1)*(3)]
      local card = Card(G.merge_list[j].T.x + G.merge_list[j].T.w/2, G.merge_list[j].T.y, G.CARD_W, G.CARD_H, nil, center)
      
      G.merge_list[j]:emplace(card)
    end
  end

   MEDIUM.INIT_COLLECTION_CARD_ALERTS()
  
  local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = joker_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collecion_merge_list', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }}
    }})
  return t
end
--


jank = jank or 0

function mod_jank(_jank)
  SMODS.calculate_context({ jank_modified = true, jank_value = _jank})
  SMODS.Scoring_Parameters.med_jank:modify(nil, _jank - (_jank or 0))
  return _jank
end

local mod_mult_ref = mod_mult
function mod_mult(_mult, ...)
  SMODS.calculate_context({ mult_modified = true, mult_value = _mult})
  return mod_mult_ref(_mult, ...)
end

local mod_chips_ref = mod_chips
function mod_chips(_chips, ...)
  SMODS.calculate_context({ chips_modified = true, chips_value = _chips})
  return mod_chips_ref(_chips, ...)
end

--- Adds a custom return value to calculate funtions
---@param key_table table|string  The keys/indexes you want to return in a calculate's function 
---@param funct function The function you want to execute when this is returned in a calculate function, taking in the passed value for the index as the first and only arguement. 
---@param display_message_func function A function that returns a string as its display message, taking in the passed value for the index as the first and only arguement. 
---@param color table|Color The color that you want the display message background to be.
---@param eval_card boolean Whether you want to display an message at all. Ignores previous 2 arguements if set to false specifically. Defaults to true.
function add_calc_effect(key_table, funct, display_message_func, color, eval_card)
    eval_card = eval_card == nil and true or eval_card
    if type(key_table) ~= "table" then
        key_table = tostring(key_table)
        key_table = {key_table}
    end
    for k, v in pairs(key_table) do
        table.insert(SMODS.scoring_parameter_keys or SMODS.calculation_keys or {}, v)
    end
    local scie = SMODS.calculate_individual_effect
    function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
        local ret
        ret = scie(effect, scored_card, key, amount, from_edition)
        if ret then
            return ret
        end
        local bool = false
        for k, v in pairs(key_table) do
            if key == v then
                bool = true
            end
        end
        if bool then 
            funct(amount)
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
    		if eval_card then card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, {message = tostring(display_message_func(amount)), colour = copy_table(color)}) end
            return true
        end
    end
end
-- animated sprite jank