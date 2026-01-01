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
	rarity = "crv_p",
	pos = {x = 0, y = 0},
	atlas = "medium_Revo's Vault_crossmod",
    loc_txt = {
        name = "AE Printer",
        text = {
            "Print a card with",
            "a {C:attention}fusion{} suit",
            "when {C:attention}first hand is drawn{}"
        }
    },
	calculate = function (self, card, context)
        local pool_of_fusions = {"med_spears"}
        if context.first_hand_drawn then
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
})
else
    create_default_crossmod_joker("Revo's Vault", "ae_printer")
end

if next(SMODS.find_mod("RevosVault")) then
SMODS.Joker({
	key = "poison",
	rarity = "crv_va",
	pos = {x = 0, y = 1},
	atlas = "medium_Revo's Vault_crossmod",
    config = {
		extra = {
            gmult = 2,
            xmult = 1
		},
    },
    loc_txt = {
        name = "Poison",
        text = {
            "{X:mult,C:white}X#2#{} Mult,",
            "In the {C:green}LAB{},",
            "{C:attention}Destroy{} cards used in",
            "{C:attention}fusion{}, and gain",
            "{X:mult,C:white}X#1#{} Mult."
        }
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra.gmult, card.ability.extra.xmult}}
    end,
	calculate = function (self, card, context)
        if context.joker_main then
            return {xmult = card.ability.extra.xmult}
        end
    end
})

else
    create_default_crossmod_joker("Revo's Vault", "poison")
end
