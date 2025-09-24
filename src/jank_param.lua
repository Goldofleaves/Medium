SMODS.Scoring_Parameter({
  key = 'jank',
  hands = {
        ['Pair'] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ['Four of a Kind'] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Flush Five"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Flush House"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Five of a Kind"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Straight Flush"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Full House"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Flush"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Straight"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Three of a Kind"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["Two Pair"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
        ["High Card"] = {[SMODS.current_mod.prefix..'_jank'] = 1, ['l_'..SMODS.current_mod.prefix..'_jank'] = 1, ['s_'..SMODS.current_mod.prefix..'_jank'] = 1},
    },
  default_value = 0,
  colour = G.C.ORANGE,
  calculation_keys = {'jank', 'xjank'},
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
		if not SMODS.Calculation_Controls.chips then return end
	    if key == 'jank' and amount then
	        if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
	        self:modify(amount)
	        card_eval_status_text(scored_card, 'extra', nil, percent, nil,
	            {message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount}}, colour = self.colour})
	        return true
        end
        if key == 'xjank' and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(self.current * (amount - 1))
            card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                {message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {'X'..amount}}, colour = self.colour})
            return true
        end
    end
})
local fuck = function (a, b)
    print(b)
    if type(a) ~= "number" then
        a = 1
    end
    if type(b) ~="number" then
        b = 1
    end
    return math.max(a,b)
end
local fucks = function (a, b)
    if type(a) ~= "number" then
        a = 1
    end
    if type(b) ~="number" then
        b = 1
    end
    return math.min(a,b)
end

SMODS.Scoring_Calculation({
    key = "jank",
    func = function(self, chips, mult, flames)
	    return chips * fuck(mult, SMODS.get_scoring_parameter(self.mod.prefix..'_jank', flames))
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_jank'},
    replace_ui = function(self)
        local scale = 0.3
		return
		{n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
			{n=G.UIT.C, config={align = 'cm', id = 'hand_chips'}, nodes = {
				SMODS.GUI.score_container({
					type = 'chips',
					text = 'chip_text',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
			SMODS.GUI.operator(scale*0.75),
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = "max(", scale = scale * 2 * 0.75, colour = G.C.WHITE, shadow = true}},
            }},
			{n=G.UIT.C, config={align = 'cm', id = 'hand_mult'}, nodes = {
				SMODS.GUI.score_container({
					type = 'mult',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
			{n=G.UIT.C, config={align = 'cm', id = 'hand_med_jank'}, nodes = {
				SMODS.GUI.score_container({
					type = 'med_jank',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = ")", scale = scale * 2 * 0.75, colour = G.C.WHITE, shadow = true}},
            }},
		}}
	end
})

SMODS.Scoring_Calculation({
    key = "jank_improved",
    func = function(self, chips, mult, flames)
	    return chips * (mult + SMODS.get_scoring_parameter(self.mod.prefix..'_jank', flames))
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_jank'},
    replace_ui = function(self)
        local scale = 0.3
		return
		{n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
			{n=G.UIT.C, config={align = 'cm', id = 'hand_chips'}, nodes = {
				SMODS.GUI.score_container({
					type = 'chips',
					text = 'chip_text',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
			SMODS.GUI.operator(scale*0.75),
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = "(", scale = scale * 2 * 0.75, colour = G.C.WHITE, shadow = true}},
            }},
			{n=G.UIT.C, config={align = 'cm', id = 'hand_mult'}, nodes = {
				SMODS.GUI.score_container({
					type = 'mult',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = "+", scale = scale * 2 * 0.75, colour = G.C.BLUE, shadow = true}},
            }},
			{n=G.UIT.C, config={align = 'cm', id = 'hand_med_jank'}, nodes = {
				SMODS.GUI.score_container({
					type = 'med_jank',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = ")", scale = scale * 2 * 0.75, colour = G.C.WHITE, shadow = true}},
            }},
		}}
	end
})

SMODS.Scoring_Calculation({
    key = "jank_decapitated",
    func = function(self, chips, mult, flames)
	    return chips * fucks(mult, SMODS.get_scoring_parameter(self.mod.prefix..'_jank', flames))
	end,
    parameters = {'chips', 'mult', SMODS.current_mod.prefix..'_jank'},
    replace_ui = function(self)
        local scale = 0.3
		return
		{n=G.UIT.R, config={align = "cm", minh = 1, padding = 0.1}, nodes={
			{n=G.UIT.C, config={align = 'cm', id = 'hand_chips'}, nodes = {
				SMODS.GUI.score_container({
					type = 'chips',
					text = 'chip_text',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
			SMODS.GUI.operator(scale*0.75),
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = "min(", scale = scale * 2 * 0.75, colour = G.C.WHITE, shadow = true}},
            }},
			{n=G.UIT.C, config={align = 'cm', id = 'hand_mult'}, nodes = {
				SMODS.GUI.score_container({
					type = 'mult',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
			{n=G.UIT.C, config={align = 'cm', id = 'hand_med_jank'}, nodes = {
				SMODS.GUI.score_container({
					type = 'med_jank',
					align = 'cm',
					w = 1,
					scale = scale
				})
			}},
            {n=G.UIT.C, config={align = "cm", id = 'hand_operator_container'}, nodes={
                {n=G.UIT.T, config={text = ")", scale = scale * 2 * 0.75, colour = G.C.WHITE, shadow = true}},
            }},
		}}
	end
})

local start_run_ref = Game.start_run
function Game:start_run(args)
    local ret = start_run_ref(self, args)
    SMODS.set_scoring_calculation("med_jank")
    return ret
end