
SMODS.Atlas{key = "conjecture", path = "conjecture.png", px = 71, py = 95}
local function uniquerandom(num)
    local result = pseudorandom("fuck", 1, 4)
    if result ~= num then
        return result
    else
        return uniquerandom(num)
    end
end
SMODS.Joker({
	key = "rigor",
	rarity = 3,
	config = {
		extra = {
			currentconjecture = 1,
            money = 25,
            xmult = 4,
            chips = 100,
            mult = 25
		},
	},
	pos = {x=0,y=0},
	atlas = "conjecture",
	loc_vars = function(self, info_queue, card)
		local hpt = card.ability.extra
		local key, vars, ret
		key = (self.key .. "_" .. hpt.currentconjecture)
		vars = {
            hpt.money,
            hpt.xmult,
            hpt.chips,
            hpt.mult
		}
		return { key = key, vars = vars }
	end,
	calculate = function(self, card, context)
		local hpt = card.ability.extra
        local list_of_conjs = {
            "squareroot",
            "difference",
            "expodentia",
            "naturalnum",
        }
        local list_of_rewards = {
            function() return { dollars = hpt.money} end,
            function() return { xmult = hpt.xmult } end,
            function() return { chips = hpt.chips } end,
            function() return { mult = hpt.mult } end,
        }
        local solved = false
        if context.individual and context.cardarea == G.play then
            if hpt.currentconjecture == 1 then
                local bool = false
                if #context.full_hand == 1 then
                    if context.full_hand[1]:get_id() == 14 then
                        bool = true
                    end
                end
                if bool then
                    solved = true
                end
            elseif hpt.currentconjecture == 2 then
                local bool = false
                if #context.full_hand == 2 then
                    if context.full_hand[1]:get_id() < context.full_hand[2]:get_id() then
                        bool = true
                    end
                end
                if bool then
                    solved = true
                end
            elseif hpt.currentconjecture == 3 then
                local bool = false
                if #context.full_hand == 2 then
                    if (context.full_hand[1]:get_id() ^ context.full_hand[2]:get_id() == context.full_hand[1]:get_id() * context.full_hand[2]:get_id()) or context.full_hand[2]:get_id() == 14 then
                        bool = true
                    end
                end
                if bool then
                    solved = true
                end
            else
                local bool = false
                if #context.full_hand == 1 then
                    if (context.full_hand[1]:get_id() == 14) or (context.full_hand[1]:get_id() == 4) or (context.full_hand[1]:get_id() == 9) then
                        bool = true
                    end
                end
                if bool then
                    solved = true
                end
            end
        end
        if solved then
            card_eval_status_text(card, 'extra', nil, nil, nil,
						{ message = localize('k_solved')})
            local g = hpt.currentconjecture
            hpt.currentconjecture = uniquerandom(hpt.currentconjecture)
		    card.children.center:set_sprite_pos { x = hpt.currentconjecture - 1, y = 0 }
            solved = false
            return list_of_rewards[g]()
        end
	end
})