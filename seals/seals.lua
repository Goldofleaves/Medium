SMODS.Atlas{key = "medium_seals", path = "seals.png", px = 71, py = 95}
SMODS.Seal {
    key = 'orange',
    atlas = 'medium_seals',
    pos = { x = 0, y = 0 },
    config = { extra = { jank = 10 } },
	loc_vars = function(self, info_queue, card)
		local vars = {
            card.ability.seal.extra.jank
		}
		return { vars = vars }
	end,
    in_pool = function (self, args)
        if G.GAME.modifiers.fusion_enhancements_spawn then
            return true
        end
        return false
    end,
    badge_colour = copy_table(G.C.ORANGE),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand and not context.end_of_round then
            return {jank = card.ability.seal.extra.jank}
        end
    end,
}
