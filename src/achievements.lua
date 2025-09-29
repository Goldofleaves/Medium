
SMODS.Achievement({
    key = "cassette_death",
    hidden_text = true,
    unlock_condition = function(self, args)
        return args.type == "badheadache"
    end
})

SMODS.Achievement({
    key = "test",
    hidden_text = true,
    unlock_condition = function(self, args)
        print(args)
        print(args.type == "test")
        return args.type == "test"
    end
})