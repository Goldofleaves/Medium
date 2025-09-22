SMODS.Scoring_Parameter({
  key = 'juice',
  default_value = 0,
  colour = mix_colours(G.C.PURPLE, G.C.YELLOW, 0.5),
  calculation_keys = {'juice', 'xjuice'},
  hands = {
        ['Pair'] = {[SMODS.current_mod.prefix..'_juice'] = 10, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 10},
        ['Four of a Kind'] = {[SMODS.current_mod.prefix..'_juice'] = 10, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 10},
        ["Flush Five"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Flush House"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Five of a Kind"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Straight Flush"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Full House"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Flush"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Straight"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Three of a Kind"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["Two Pair"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
        ["High Card"] = {[SMODS.current_mod.prefix..'_juice'] = 1, ['l_'..SMODS.current_mod.prefix..'_juice'] = 5, ['s_'..SMODS.current_mod.prefix..'_juice'] = 1},
    },
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
		if not SMODS.Calculation_Controls.chips then return end
	    if key == 'juice' and amount then
	        if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
	        self:modify(amount)
	        card_eval_status_text(scored_card, 'extra', nil, percent, nil,
	            {message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount}}, colour = self.colour})
	        return true
        end
        if key == 'xjuice' and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(self.current * (amount - 1))
            card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                {message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {'X'..amount}}, colour = self.colour})
            return true
        end
    end
})

SMODS.Scoring_Calculation({
    key = "juice",
    func = function(self, chips, mult, flames)
	    return chips * mult * SMODS.get_scoring_parameter(self.mod.prefix..'_juice', flames)
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_juice'},
    replace_ui = function(self)
        local scale = 0.3
		return
		{n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
			{n=G.UIT.C, config={align = 'cm', id = 'hand_chips'}, nodes = {
				SMODS.GUI.score_container({
					type = 'chips',
					text = 'chip_text',
					align = 'cr',
					w = 1.1,
					scale = scale
				})
			}},
			SMODS.GUI.operator(scale*0.75),
			{n=G.UIT.C, config={align = 'cm', id = 'hand_mult'}, nodes = {
				SMODS.GUI.score_container({
					type = 'mult',
					align = 'cm',
					w = 1.1,
					scale = scale
				})
			}},
			SMODS.GUI.operator(scale*0.75),
			{n=G.UIT.C, config={align = 'cm', id = 'hand_med_juice'}, nodes = {
				SMODS.GUI.score_container({
					type = 'med_juice',
					align = 'cl',
					w = 1.1,
					scale = scale
				})
			}},
		}}
	end
})