function MEDIUM.ease_currency(mod, instant)
    local function _mod(mod)
        local dollar_UI = G.HUD:get_UIE_by_ID('med_currency_text_UI')
        mod = mod or 0
        local text = '+'.. "_"
        local col = G.C.MONEY
        if mod < 0 then
            text = '-'.."_"
            col = G.C.RED              
        else
          -- inc_career_stat('c_dollars_earned', mod)
        end
        --Ease from current chips to the new number of chips
        G.GAME.med_currency2 = G.GAME.med_currency2 + mod
        -- check_and_set_high_score('most_money', G.GAME.med_currency2)
        -- check_for_unlock({type = 'money'})
        dollar_UI.config.object:update()
        G.HUD:recalculate()
        --Popup text next to the chips in UI showing number of chips gained/lost
        attention_text({
          font = SMODS.Fonts.med_currency,
          text = text..tostring(math.abs(mod)),
          scale = 0.8, 
          hold = 0.7,
          cover = dollar_UI.parent,
          cover_colour = col,
          align = 'cm',
          })
        --Play a chip sound
        play_sound('coin1')
    end
    if instant then
        _mod(mod)
    else
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            _mod(mod)
            return true
        end
        }))
    end
end