localize_milestone = function (key)
    return G.localization.descriptions.Milestones["mile_"..key] or G.localization.descriptions.Milestones.undiscovered
end
MEDIUM.milestones = {}
MEDIUM.Milestone = function (args)
    local table_jank = {
        unlocked = false,
        atlas = args.atlas or "med_milestone_default",
        pos = args.pos or {x = 0, y = 0},
        key = "mile_"..args.key,
        name = localize_milestone(args.key).name,
        text = localize_milestone(args.key).text,
    }
    table.insert(MEDIUM.milestones, table_jank)
end
unlock_milestone = function (key)
    MEDIUM.milestones[key].unlocked = true
end
MEDIUM.Milestone{
    key = "med_cassette_death"
}

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