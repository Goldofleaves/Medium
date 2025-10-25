SMODS.Joker({
	key = "cardshark",
	rarity = 3,
	loc_vars = function (self, info_queue, card)
		return{vars = {G.GAME.max_injogged_cards or 4}}
	end
})
-- shuffle hook, taken from aikoyori
local function compareFirstElement(a,b)
    return a[1] < b[1]
end
local shufflingEverydayHook = CardArea.shuffle
function CardArea:shuffle(_seed)
    local r = shufflingEverydayHook(self, _seed)
    if self == G.deck then
        --print("everyday shuffling")
        local priorityqueue = {}
        local cardsPrioritised = {}
        local cardsOther = {}
        for d, joker in ipairs(G.jokers.cards) do
            if not joker.debuff then
				if joker.config.center.key == "j_med_cardshark" then
					priorityqueue[#priorityqueue+1] = {#G.jokers.cards - d + 1, "injog", true}
					print("ahhhh, injoggerer, the priority of the joker is "..(#G.jokers.cards - d + 1))
				end
                --[[if (joker.ability.immutable.akyrs_priority_draw_suit) then
                    priorityqueue[#priorityqueue+1] = {#G.jokers.cards - d + 1, "suit",joker.ability.immutable.akyrs_priority_draw_suit}
                    --print(joker.ability.akyrs_priority_draw_suit)
                end
                if joker.ability.immutable.akyrs_priority_draw_rank then
                    priorityqueue[#priorityqueue+1] = {#G.jokers.cards - d + 1, "rank",joker.ability.immutable.akyrs_priority_draw_rank}
                    --print(joker.ability.akyrs_priority_draw_rank)
                end
                if joker.ability.immutable.akyrs_priority_draw_conditions == "Face Cards" then
                    priorityqueue[#priorityqueue+1] = {#G.jokers.cards - d + 1, "face",true}
                    --print(joker.ability.akyrs_priority_draw_conditions)
                end]]
            end
        end
        table.sort(priorityqueue,compareFirstElement)
        local cards = self.cards
        for i, k in ipairs(cards) do
            local priority = 0
            
            for j, l in ipairs(priorityqueue) do
                if ((l[2] == "injog" and k.injoggen)) then
                    priority = priority + l[1]
                end
            end
            if priority > 0 then
                cardsPrioritised[#cardsPrioritised+1] = {priority,k}
            else
                cardsOther[#cardsOther+1] = k
            end
        end
        table.sort(cardsPrioritised,compareFirstElement)
        for _, card in ipairs(cardsPrioritised) do
            table.insert(cardsOther, card[2])
        end
        self.cards = cardsOther
        self:set_ranks()
    end
    return r
end
