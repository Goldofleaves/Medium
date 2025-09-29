-- Revo's Vault
SMODS.Atlas{key = "medium_revo_crossmod", path = "revosvault_crossmod.png", px = 71, py = 95}

local position = { x = 1, y = 0 }

local calc = function (self, card, context)
    
end

local localvars = function (self, info_queue, card)
    
end

local localization = {
    name = "Revo's Vault Crossmod Joker",
    text = {
        "This joker will be available",
        "if you have",
        "{C:attention}Revo's Vault{} enabled."
    }
}

if next(SMODS.find_mod("RevosVault")) then
    position.x = 0
    localization = {
        name = "AE Printer",
        text = {
            "{C:green} #1# in #2# {}chance to",
            "print a card with a {C:attention}fusion{} suit",
            "when {C:attention}first hand is drawn{}."
        }
    }
    localvars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "fusion_suits" } 
		local hpt = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, hpt.odds, "med_revo_ae")
		local vars = {
            numerator,
            denominator
		}
		return { vars = vars }
    end
    calc = function (self, card, context)
        local pool_of_fusions = {"med_spears"}
        if context.first_hand_drawn then
            if SMODS.pseudorandom_probability(card, "med_revo_ae", 1, card.ability.extra.odds) then
            local _card = SMODS.create_card { set = "Base", suit = pseudorandom_element(pool_of_fusions, "med_revo_ae"), area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            _card.playing_card = G.playing_card
            table.insert(G.playing_cards, _card)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand:emplace(_card)
                    _card:start_materialize()
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    if context.blueprint_card then
                        context.blueprint_card:juice_up()
                    else
                        card:juice_up()
                    end
                    SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                    save_run()
                    return true
                end
            }))
            end
        end
    end
end
SMODS.Joker({
	key = "ae_printer",
	rarity = 2,
	config = {
		extra = {
			odds = 2
		},
	},
    in_pool = function (self, args)
        if next(SMODS.find_mod("RevosVault")) then
            return true
        end
        return false 
    end,
	pos = position,
	atlas = "medium_revo_crossmod",
    loc_txt = localization,
	loc_vars = function(self, info_queue, card)
		return localvars(self, info_queue, card)
	end,
	calculate = function(self, card, context)
        return calc(self, card, context)
	end
})