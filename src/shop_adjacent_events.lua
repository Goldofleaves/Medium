MEDIUM.sajeventpool = { Shop = 3, Lab = 1} -- weights, must be integers
function generate_shop_adjacent_event()
    local table = {}
    for k, v in pairs(MEDIUM.sajeventpool) do
        for i = 1, v do
            table[#table+1] = k
        end
    end
    return pseudorandom_element(table, "shitfuck")
end
function generate_saj_for_curante()
    G.GAME.sajevents = {}
    for i = 1, 3 do
        G.GAME.sajevents[i] = generate_shop_adjacent_event()
    end
end
function get_color_from_saj_event(thing)
    if thing == "Shop" then
        return G.C.GOLD
    elseif thing == "Lab" then
        return G.C.GREEN
    else
        return G.C.WHITE
    end
end
-- ui

local ref = SMODS.calculate_context
SMODS.calculate_context = function(context, return_table, no_resolve)
  if (not context.ending_shop) or G.GAME.current_sajevent == "Shop" then -- ensuring ending shop only works for shop
    return ref(context, return_table, no_resolve)
  end
end

function G.UIDEF.lab()
    G.shop_jokers = CardArea(
      G.hand.T.x+0,
      G.hand.T.y+G.ROOM.T.y + 9,
      G.GAME.shop.joker_max*1.02*G.CARD_W,
      1.05*G.CARD_H, 
      {card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 1})


    G.shop_vouchers = CardArea(
      G.hand.T.x+0,
      G.hand.T.y+G.ROOM.T.y + 9,
      2.1*G.CARD_W,
      1.05*G.CARD_H, 
      {card_limit = 1, type = 'shop', highlight_limit = 1})

    G.shop_booster = CardArea(
      G.hand.T.x+0,
      G.hand.T.y+G.ROOM.T.y + 9,
      2.4*G.CARD_W,
      1.15*G.CARD_H, 
      {card_limit = 2, type = 'shop', highlight_limit = 1, card_w = 1.27*G.CARD_W})

    local shop_sign = AnimatedSprite(0,0, 4.4, 2.2, G.ANIMATION_ATLAS['med_lab_sign'])
    shop_sign:define_draw_steps({
      {shader = 'dissolve', shadow_height = 0.05},
      {shader = 'dissolve'}
    })
    G.SHOP_SIGN = UIBox{
      definition = 
        {n=G.UIT.ROOT, config = {colour = G.C.DYN_UI.MAIN, emboss = 0.05, align = 'cm', r = 0.1, padding = 0.1}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0.1, minw = 4.72, minh = 3.1, colour = G.C.DYN_UI.DARK, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = shop_sign}}
            }},
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {localize('ui_labtext')}, colours = {lighten(G.C.GREEN, 0.3)},shadow = true, rotate = true, float = true, bump = true, scale = 0.5, spacing = 1, pop_in = 1.5, maxw = 4.3})}}
            }},
          }},
        }},
      config = {
        align="cm",
        offset = {x=0,y=-15},
        major = G.HUD:get_UIE_by_ID('row_blind'),
        bond = 'Weak'
      }
    }
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = (function()
          G.SHOP_SIGN.alignment.offset.y = 0
          return true
      end)
    }))
    local t = {n=G.UIT.ROOT, config = {align = 'cl', colour = G.C.CLEAR}, nodes={
            UIBox_dyn_container({
                {n=G.UIT.C, config={align = "cm", padding = 0.1, emboss = 0.05, r = 0.1, colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                      {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                        {n=G.UIT.R,config={id = 'next_round_button', align = "cm", minw = 2.8, minh = 1.5, r=0.15,colour = G.C.RED, one_press = true, button = 'toggle_shop', hover = true,shadow = true}, nodes = {
                          {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                              {n=G.UIT.T, config={text = localize('b_next_round_1'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                              {n=G.UIT.T, config={text = localize('b_next_round_2'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }}   
                          }},              
                        }},
                        {n=G.UIT.R, config={align = "cm", minw = 2.8, minh = 1.6, r=0.15,colour = G.C.GREEN, button = 'reroll_shop', func = 'can_reroll', hover = true,shadow = true}, nodes = {
                          {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                              {n=G.UIT.T, config={text = localize('ui_lab_indication_temp'), scale = 0.4, colour = G.C.WHITE, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
                              {n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
                              {n=G.UIT.T, config={ref_table = G.GAME.current_round, ref_value = 'reroll_cost', scale = 0.75, colour = G.C.WHITE, shadow = true}},
                            }}
                          }}
                        }},
                      }},
                      {n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.L_BLACK, emboss = 0.05, minw = 8.2}, nodes={
                          {n=G.UIT.O, config={object = G.shop_jokers}},
                      }},
                    }},
                    {n=G.UIT.R, config={align = "cm", minh = 0.2}, nodes={}},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                      {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                        {n=G.UIT.C, config={align = "cm", padding = 0.2, r=0.2, colour = G.C.BLACK, maxh = G.shop_vouchers.T.h+0.4}, nodes={
                          {n=G.UIT.T, config={text = localize{type = 'variable', key = 'ante_x_voucher', vars = {G.GAME.round_resets.ante}}, scale = 0.45, colour = G.C.L_BLACK, vert = true}},
                          {n=G.UIT.O, config={object = G.shop_vouchers}},
                        }},
                      }},
                      {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                        {n=G.UIT.O, config={object = G.shop_booster}},
                      }},
                    }}
                }
              },
              
              }, false)
        }}
    return t
end
function Game:update_lab(dt)
    if not G.STATE_COMPLETE then
        stop_use()
        ease_background_colour_blind(G.STATES.LAB)
        local shop_exists = not not G.shop
        G.shop = G.shop or UIBox{
            definition = G.UIDEF.lab(),
            config = {align='tmi', offset = {x=0,y=G.ROOM.T.y+11},major = G.hand, bond = 'Weak'}
        }
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.shop.alignment.offset.y = -5.3
                    G.shop.alignment.offset.x = 0
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        blockable = false,
                        func = function()
                            if math.abs(G.shop.T.y - G.shop.VT.y) < 3 then
                                G.ROOM.jiggle = G.ROOM.jiggle + 3
                                play_sound('cardFan2')
                                for i = 1, #G.GAME.tags do
                                    G.GAME.tags[i]:apply_to_run({type = 'shop_start'})
                                end
                                local nosave_shop = nil
                                if not shop_exists then
                                
                                    if G.load_shop_jokers then 
                                        nosave_shop = true
                                        G.shop_jokers:load(G.load_shop_jokers)
                                        for k, v in ipairs(G.shop_jokers.cards) do
                                            create_shop_card_ui(v)
                                            if v.ability.consumeable then v:start_materialize() end
                                            for _kk, vvv in ipairs(G.GAME.tags) do
                                                if vvv:apply_to_run({type = 'store_joker_modify', card = v}) then break end
                                            end
                                        end
                                        G.load_shop_jokers = nil
                                    else
                                        for i = 1, G.GAME.shop.joker_max - #G.shop_jokers.cards do
                                            G.shop_jokers:emplace(create_card_for_shop(G.shop_jokers))
                                        end
                                    end
                                    
                                    if G.load_shop_vouchers then 
                                        nosave_shop = true
                                        G.shop_vouchers:load(G.load_shop_vouchers)
                                        for k, v in ipairs(G.shop_vouchers.cards) do
                                            create_shop_card_ui(v)
                                            v:start_materialize()
                                        end
                                        G.load_shop_vouchers = nil
                                    else
                                        if G.GAME.current_round.voucher and G.P_CENTERS[G.GAME.current_round.voucher] then
                                            local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
                                            G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.voucher],{bypass_discovery_center = true, bypass_discovery_ui = true})
                                            card.shop_voucher = true
                                            create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
                                            card:start_materialize()
                                            G.shop_vouchers:emplace(card)
                                        end
                                    end
                                    

                                    if G.load_shop_booster then 
                                        nosave_shop = true
                                        G.shop_booster:load(G.load_shop_booster)
                                        for k, v in ipairs(G.shop_booster.cards) do
                                            create_shop_card_ui(v)
                                            v:start_materialize()
                                        end
                                        G.load_shop_booster = nil
                                    else
                                        for i = 1, 2 do
                                            G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
                                            if not G.GAME.current_round.used_packs[i] then
                                                G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
                                            end

                                            if G.GAME.current_round.used_packs[i] ~= 'USED' then 
                                                local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
                                                G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
                                                create_shop_card_ui(card, 'Booster', G.shop_booster)
                                                card.ability.booster_pos = i
                                                card:start_materialize()
                                                G.shop_booster:emplace(card)
                                            end
                                        end

                                        for i = 1, #G.GAME.tags do
                                            G.GAME.tags[i]:apply_to_run({type = 'voucher_add'})
                                        end
                                        for i = 1, #G.GAME.tags do
                                            G.GAME.tags[i]:apply_to_run({type = 'shop_final_pass'})
                                        end
                                    end
                                end

                                G.CONTROLLER:snap_to({node = G.shop:get_UIE_by_ID('next_round_button')})
                                if not nosave_shop then G.E_MANAGER:add_event(Event({ func = function() save_run(); return true end})) end
                                return true
                            end
                        end}))
                    return true
                end
            }))
          G.STATE_COMPLETE = true
    end  
    if self.buttons then self.buttons:remove(); self.buttons = nil end          
end
