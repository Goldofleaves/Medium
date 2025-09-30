-- Revo's Vault
function create_default_crossmod_joker(mod_name, key)
SMODS.Joker({
	key = key,
	rarity = 1,
    in_pool = function (self, args)
        return false 
    end,
	pos = {x = 1, y = 0},
	atlas = "medium_"..mod_name.."_crossmod",
    loc_txt = {
    name = mod_name.." Crossmod Joker",
    text = {
        "This joker will be available",
        "if you have",
        "{C:attention}"..mod_name.."{} enabled."
    },
}
})
end
SMODS.Atlas{key = "medium_Revo's Vault_crossmod", path = "revosvault_crossmod.png", px = 71, py = 95}

if next(SMODS.find_mod("RevosVault")) then
SMODS.Joker({
	key = "ae_printer",
	rarity = 2,
	config = {
		extra = {
			odds = 2
		},
	},
	pos = {x = 0, y = 0},
	atlas = "medium_Revo's Vault_crossmod",
    loc_txt = {
        name = "AE Printer",
        text = {
            "{C:green} #1# in #2# {}chance to",
            "print a card with a {C:attention}fusion{} suit",
            "when {C:attention}first hand is drawn{}."
        }
    },
	loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "fusion_suits" } 
		local hpt = card.ability.extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, hpt.odds, "med_revo_ae")
		local vars = {
            numerator,
            denominator
		}
		return { vars = vars }
    end,
	calculate = function (self, card, context)
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
})
else
    create_default_crossmod_joker("Revo's Vault", "ae_printer")
end