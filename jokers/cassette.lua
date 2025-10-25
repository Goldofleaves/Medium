SMODS.Joker({
	key = "cassette",
	rarity = 3,
	in_pool = function(self, args)
    return not args or args.source ~= "jud"
    end,
	pos = {x=4,y=0},
	atlas = "medium_jokers",
	add_to_deck = function (self, card, from_debuff)
		if not from_debuff then
            if G.STAGE == G.STAGES.RUN then
                if not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.PLANET_PACK or G.STATE ==
                    G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.STANDARD_PACK or G.STATE == G.STATES.BUFFOON_PACK or
                    G.STATE == G.STATES.SMODS_BOOSTER_OPENED) then
                    save_run()
                end
                compress_and_save(G.SETTINGS.profile .. '/cassette_save.jkr', G.ARGS.save_run)
			end
		end
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over and context.main_eval then
			MEDIUM.cassettetimer = 25
			MEDIUM.cassetterevived = true
		end
	end
})