SMODS.Atlas{key = "medium_vouchers", path = "vouchers.png", px = 71, py = 95}

SMODS.Voucher {
	key = 'fashion',
	atlas = "medium_vouchers",
	pos = { x = 0, y = 0 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "fusion_suits" } 
	end,
	redeem = function(self, voucher)
		G.GAME.modifiers.fusion_suits_spawn = true
	end
}

SMODS.Voucher {
	key = 'vogue',
	atlas = "medium_vouchers",
	pos = { x = 1, y = 0 },
	requires = {
		'v_med_fasion'
	},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = { set = "Other", key = "fusion_enhancements" } 
        info_queue[#info_queue+1] = { set = "Other", key = "fusion_seals" } 
	end,
	redeem = function(self, voucher)
		G.GAME.modifiers.fusion_enhancements_spawn = true
	end
}
