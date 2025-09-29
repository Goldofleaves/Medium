SMODS.Sound{
    key = "sfx_milestone",
    path = "sfx_milestone.ogg",
}
G.PROFILES[G.SETTINGS.profile].milestones = G.PROFILES[G.SETTINGS.profile].milestones or {}
localize_milestone = function (key)
    local jank = G.localization.descriptions.Milestones or {
        undiscovered = {
                name = "Locked Milestone",
                text = {
                    "You have yet to",
                    "{C:attention}achieve{} this Milestone."
                }
            },}
    return jank["mile_"..key] or jank.undiscovered
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
    G.PROFILES[G.SETTINGS.profile].milestones["mile_"..args.key] = false
end
trigger_milestone_ui = function(key)
    
        ease_background_colour{new_colour = G.C.ORANGE, special_colour = G.C.PURPLE, contrast = 1.5}
        attention_text({text = "Completed Milestone with key "..key, hold = 12})
        MEDIUM.milestonetimer = 400
        play_sound("med_sfx_milestone") 
    --[[G.SPLASH_BACK:define_draw_steps({
            {
                shader = "splash",
                send = {
                    { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                    { name = "vort_speed", val = 0.7 },
                    { name = "colour_1",   ref_table = G.C,      ref_value = "ORANGE" },
                    { name = "colour_2",   ref_table = G.C,      ref_value = "GREEN" },
                },
            },
        })]]
end
unlock_milestone = function (key)
    MEDIUM.milestones[key].unlocked = true
    G.PROFILES[G.SETTINGS.profile].milestones[key] = true
    trigger_milestone_ui()
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