SMODS.Sound{
    key = "sfx_pjank",
    path = "sfx_pjank.ogg",
}
SMODS.Sound{
    key = "sfx_xjank",
    path = "sfx_xjank.ogg",
}
SMODS.Sound{
    key = "sfx_ijank",
    path = "sfx_ijank.ogg",
}
SMODS.Scoring_Parameter({
  key = 'jank',
  default_value = G.GAME and G.GAME.jankvalue or 0,
  colour = G.C.ORANGE,
  calculation_keys = {'jank', 'xjank'},
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
		if not SMODS.Calculation_Controls.chips then return end
	    if key == 'jank' and amount then
	        if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
	        self:modify(amount)
	        card_eval_status_text(scored_card, 'extra', nil, percent, nil,
	            {sound = "med_sfx_pjank", message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount}}, colour = self.colour})
	        return true
        end
        if key == 'xjank' and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(self.current * (amount - 1))
            card_eval_status_text(scored_card, 'extra', nil, percent, nil,
                {sound = "med_sfx_xjank", message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {'X'..amount}}, colour = self.colour})
            return true
        end
    end
})
function increment_jank_default_value(num)
    SMODS.calculate_context({ jank_default_value_incremented = true, jank_default_increment_val = num})
	G.GAME.jankvalue = G.GAME.jankvalue + num
	SMODS.Scoring_Parameters.med_jank.default_value = G.GAME.jankvalue
	local fuck = get_current_jank_operator()
	SMODS.set_scoring_calculation(fuck)
end
function set_jank_default_value(num)
    SMODS.calculate_context({ jank_default_value_set = true, jank_default_set_val = num})
	G.GAME.jankvalue =num
	SMODS.Scoring_Parameters.med_jank.default_value = G.GAME.jankvalue
	local fuck = get_current_jank_operator()
	SMODS.set_scoring_calculation(fuck)
end
local fuck = function (a, b)
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

function set_current_jank_operator(operator)
    SMODS.calculate_context({ jank_operator_set = true, jank_operator_key = operator})
    SMODS.set_scoring_calculation(operator)
    G.GAME.jankop = operator
end
function get_current_jank_operator()
    return G.GAME.jankop
end