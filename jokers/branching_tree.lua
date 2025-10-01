-- G.GAME.pseudorandom.seed
SMODS.Joker({
	key = "branching_tree",
	rarity = 2,
	pos = {x = 7, y = 0},
	config = {
		extra = {
            scalingfactor = 1e-8
		},
	},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
        local jank = math.log(1/hpt.scalingfactor, 10)
		local vars = {
            jank,
            colours = {G.C.ORANGE}
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if context.joker_main then
            if not G.GAME.seeded then
            return {jank = math.floor(hpt.scalingfactor * tonumber(G.GAME.pseudorandom.seed,36))}
            else
                return {message = localize("k_seeded"), colour = G.C.RED}
            end
        end
	end
})