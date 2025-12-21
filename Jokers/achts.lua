local getdisplay = function (num)
    if num == 0 then
        return localize("k_coins_tails_display")
    end
    return localize("k_coins_heads_display")
end
local getdisplay2 = function (num)
    if num == 0 then
        return localize("k_coins_tails")
    end
    return localize("k_coins_heads")
end
SMODS.Joker({
	key = "achts",
	rarity = 2,
	config = {
		extra = {
            currentroll = 0, -- 0: tails, 1: heads
            incrementval = 1,
            plusjankval = 12,
            jokerdisplayval = "Fuck"
		},
	},
	pos = {x=0,y=1},
    soul_pos = {x=3,y=0},
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local vars = {
            getdisplay(hpt.currentroll),
            hpt.incrementval,
            hpt.plusjankval,
            colours = {G.C.ORANGE}
		}
		return { vars = vars }
	end,
	atlas = "medium_jokers",
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        if hpt.jokerdisplayval == "Fuck" then
            hpt.jokerdisplayval = getdisplay(hpt.currentroll)
        end
        if context.setting_blind then
            hpt.currentroll = math.floor(pseudorandom("fuck", 0, 2))
            if hpt.currentroll == 2 then
                hpt.currentroll = 1
            end
            hpt.jokerdisplayval = getdisplay(hpt.currentroll)
            return {message = getdisplay2(hpt.currentroll)}
        end
        local table = {
            [0] = function ()
                return {ijank = hpt.incrementval}
            end,
            [1] = function ()
                return {jank = hpt.plusjankval}
            end
        }
        if context.joker_main then
            return table[hpt.currentroll]()
        end
	end
})