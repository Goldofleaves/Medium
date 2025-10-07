SMODS.Joker({
	key = "milestone",
	rarity = 2,
	config = {
		extra = {
            initmult = 2,
            decmult = 0.2
		},
	},
	pos = {x=6,y=1},
	atlas = "medium_jokers",
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
        local amount = 0
        local counter = 0
        for k, v in pairs(MEDIUM.milestones) do
            if not v.unlocked then
                counter = counter + 1
            end
            amount = amount + 1
        end
		local vars = {
            hpt.initmult,
            hpt.decmult,
            counter,
            amount
		}
		return { vars = vars }
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        local amount = 0
        local counter = 0
        for k, v in pairs(MEDIUM.milestones) do
            if not v.unlocked then
                counter = counter + 1
            end
            amount = amount + 1
        end
        if context.joker_main then
            return {xmult = hpt.initmult}
        end
        if context.end_of_round then
            hpt.initmult = hpt.initmult - hpt.decmult * counter/amount
            if hpt.initmult <= 1 then
                card:start_dissolve(nil, true)
            else
                return {message = "-"..hpt.decmult * counter/amount}
            end
        end
	end
})