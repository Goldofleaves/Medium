MEDIUM.sajeventpool = {Shop = 1, Lab = 1} -- weights, must be integers

--TODO: Make in_lab be set automatically,
--TODO: Make merge cost reset by patching new_round() // done
--TODO: Put buttons behind cards
--TODO: Make a function to check if a fusion exists to enable the merge button in the first place, or make it so the order doesnt Majority of the {C:attention}art
--TODO: Make playing cards fusable
-- i hope this is all
-- some functions are in misc.lua
LAB = {
    merge_cost = 5,
    merge_cost_increase = 2,
    merge_cost_reset = 5,
    in_lab = false,
}


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
    G.GAME.sajevents[3] = "Shop"
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

SMODS.Atlas{
	key = "lab_ui_stuff",
	path = "lab_ui_stuff.png",
	px = 20,
	py = 20
}
local ref = SMODS.calculate_context
SMODS.calculate_context = function(context, return_table, no_resolve)
  if context.ending_shop and G.GAME.current_sajevent ~= "Shop" then
    context.ending_shop = nil
  end
    return ref(context, return_table, no_resolve)
end

function G.UIDEF.lab()
      local stake_sprite = Sprite(0, 0, 0.5, 0.5, G.ASSET_ATLAS["med_lab_ui_stuff"], { x = 1, y = 0 }) --get_stake_sprite(G.GAME.stake or 1, 0.5)
      local stake_sprite2 = Sprite(0, 0, 0.5, 0.5, G.ASSET_ATLAS["med_lab_ui_stuff"], { x = 0, y = 0 }) -- get_stake_sprite(G.GAME.stake or 1, 0.5) 
      
      local stake_spriteb = get_stake_sprite(G.GAME.stake or 1, 0.5)
      local stake_spritebb = get_stake_sprite(G.GAME.stake or 1, 0.5)
      local stake_spritebbb = get_stake_sprite(G.GAME.stake or 1, 0.5)

      local m = 0.87
    G.merge_1 = CardArea(
      G.hand.T.x+0,
      G.hand.T.y+G.ROOM.T.y + 9,
      G.CARD_W * m,
      G.CARD_H * m, 
      {card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 1})

    G.merge_2 = CardArea(
      G.hand.T.x+0,
      G.hand.T.y+G.ROOM.T.y + 9,
      G.CARD_W * m,
      G.CARD_H * m, 
      {card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 1})

    G.result = CardArea(
      G.hand.T.x+0,
      G.hand.T.y+G.ROOM.T.y + 9,
      G.CARD_W * m,
      G.CARD_H * m, 
      {card_limit = G.GAME.shop.joker_max, type = 'shop', highlight_limit = 1})


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
    local n = 1.9
    local k = 0.46
    local t = {n=G.UIT.ROOT, config = {align = 'cl', colour = G.C.CLEAR}, nodes={
            UIBox_dyn_container({
                {n=G.UIT.C, config={align = "cm", padding = 0.1, emboss = 0.05, r = 0.1, colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                  MEDIUM.help_button("medium_lab"),
                    {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
                      {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                        {n=G.UIT.R,config={id = 'next_round_button', align = "cm", minw = 2.3, minh = 1.5, r=0.15,colour = G.C.RED, one_press = true, button = 'toggle_shop', hover = true,shadow = true}, nodes = {
                          {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'y', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                              {n=G.UIT.T, config={text = localize('b_next_round_1'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                              {n=G.UIT.T, config={text = localize('b_next_round_2'), scale = 0.4, colour = G.C.WHITE, shadow = true}}
                            }}   
                          }},              
                        }},
                        {n=G.UIT.R, config={align = "cm", minw = 2.3, minh = 1.6, r=0.15,colour = G.C.GREEN, button = 'med_lab_merge', func = 'med_can_merge', hover = true,shadow = true}, nodes = {
                          {n=G.UIT.R, config={align = "cm", padding = 0.07, focus_args = {button = 'x', orientation = 'cr'}, func = 'set_button_pip'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3}, nodes={
                              {n=G.UIT.T, config={text = localize('ui_lab_merge'), scale = 0.4, colour = G.C.WHITE, shadow = true}},
                            }},
                            {n=G.UIT.R, config={align = "cm", maxw = 1.3, minw = 1}, nodes={
                              {n=G.UIT.T, config={text = localize('$'), scale = 0.7, colour = G.C.WHITE, shadow = true}},
                              {n=G.UIT.T, config={ref_table = LAB, ref_value = 'merge_cost', scale = 0.75, colour = G.C.WHITE, shadow = true}},
                            }}
                          }}
                        }},
                      }},
                      {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05, minw = 8.2}, nodes={

                        {n=G.UIT.C, config={align = "cm", padding = 0.1,r=0.2,colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                          {n=G.UIT.C, config={align = "cm", padding = 0.1,r=0.2, colour = G.C.L_BLACK}, nodes={
                            {n=G.UIT.O, config = {padding = 0,object = G.merge_1, align = "cm", id = "merge_area_1" }},
                          }},
                        }},

                          {n=G.UIT.O, config={w=k,h=k, colour = G.C.BLUE, object = stake_sprite2, hover = true, can_collide = false}},

                        {n=G.UIT.C, config={align = "cm", padding = 0.1,r=0.2,colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                          {n=G.UIT.C, config={align = "cm", padding = 0.1,r=0.2, colour =  G.C.L_BLACK}, nodes={
                            {n=G.UIT.O, config = {padding = 0,object = G.merge_2, align = "cl", id = "merge_area_2" }},
                          }},
                        }},

                        {n=G.UIT.O, config={ w=k,h=k, colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false}},

                        {n=G.UIT.C, config={align = "cm", padding = 0.1,r=0.2,colour = G.C.DYN_UI.BOSS_MAIN}, nodes={
                          {n=G.UIT.C, config={align = "cm", padding = 0.1,r=0.2,colour = G.C.L_BLACK}, nodes={
                            {n=G.UIT.O, config = {padding = 0,object = G.result, align = "cl", id = "merge_area_3" }},
                          }},
                        }},
                      }},
                    }},
                    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
                      {n=G.UIT.C, config={align = "cm", padding = 0.15, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                        {n=G.UIT.C, config={align = "cm", padding = 0.1, r=0.2, colour = G.C.BLACK, maxh = 1.05*G.CARD_H+0.4}, nodes={
                          {n=G.UIT.R,config={align = "cm",padding = 0.1, minh =  1.05*G.CARD_H, minw = 1.12*G.CARD_W, r=0.15,colour = G.C.MONEY, button = 'med_lab_merge', hover = true,shadow = true}, nodes = {
                            {n=G.UIT.T, config={text = localize("ui_lab_recipes"), scale = 0.5, colour = G.C.WHITE,}},
		                      }},
                        }},
                      }},
                      {n=G.UIT.C, config={align = "cm", padding = 0.6, r=0.2, colour = G.C.L_BLACK, emboss = 0.05}, nodes={
                        {n=G.UIT.O, config={padding = 0.6,w=n,h=n, colour = G.C.BLUE, object = stake_spriteb, hover = true, can_collide = false}},
                        {n=G.UIT.O, config={padding = 0.6,w=n,h=n, colour = G.C.BLUE, object = stake_spritebb, hover = true, can_collide = false}},
                        {n=G.UIT.O, config={padding = 0.6,w=n,h=n, colour = G.C.BLUE, object = stake_spritebbb, hover = true, can_collide = false}},
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
        LAB.in_lab = true
        move_deck()
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
                                
                                  --[[  if G.load_merge then 
                                        nosave_shop = true
                                        G.merge_1:load(G.load_shop_jokers)
                                        G.merge_2:load(G.load_shop_jokers_2)
                                        for k, v in ipairs(G.shop_jokers.cards) do
                                            create_shop_card_ui(v)
                                            if v.ability.consumeable then v:start_materialize() end
                                            for _kk, vvv in ipairs(G.GAME.tags) do
                                                if vvv:apply_to_run({type = 'store_joker_modify', card = v}) then break end
                                            end
                                        end
                                        G.load_merge = nil
                                    else
                                        for i = 1, G.GAME.shop.joker_max - #G.merge_1.cards do
                                            G.merge_1:emplace(create_card_for_shop(G.merge_1))

                                        end
                                    end]]
                                    
                     --[[               if G.load_shop_vouchers then 
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
                                                local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,]]
                                          --      G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[i]], {bypass_discovery_center = true, bypass_discovery_ui = true})
                                            --[[    create_shop_card_ui(card, 'Booster', G.shop_booster)
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
                                    end ]]
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
