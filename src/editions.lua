--[[SMODS.Shader {
    key = "reflective",
    path = "reflective.fs"
}

SMODS.Edition {
    key = "reflective",
    shader = "reflective",
    config = { extra = { jank = 3 } },
    weight = 3,
    extra_cost = 5,
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.jank } }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {xjank = card.ability.extra.jank}
        end
    end
}
]]