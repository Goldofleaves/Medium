local ref = SMODS.Scoring_Parameters.mult.modify
function SMODS.Scoring_Parameters.mult:modify(a, amount, ...)
    local ret = ref(self, a, amount, ...)
    local prref = MEDIUM.penrose_triangle_func
    MEDIUM.penrose_triangle_func = function (a)
        local reta = prref(a)
        if amount then
        reta = reta + amount
        end
        return reta
    end
    return ret
end
local refa = Medium.calculate
Medium.calculate = function (self, context)
    if context.before then
        MEDIUM.penrose_triangle_func = function (a)
            return a
        end
    end
    return refa(self, context)
end
SMODS.Joker({
	key = "penrose_triangle",
	rarity = 3,
	pos = {x=0,y=4},
	config = {
		extra = {
            multval = 3
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            hpt.multval,
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.joker_main then
            local chips = MEDIUM.penrose_triangle_func(hand_chips)/hpt.multval
            local modify = math.ceil(chips - hand_chips)
            return {
                chips = modify,
                message = localize("k_prf_applied")
            }
        end
	end
})