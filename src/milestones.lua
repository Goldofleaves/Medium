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
    return jank[key] or jank.undiscovered
end
MEDIUM.milestones = {}
MEDIUM.Milestone = function (args)
    local table_jank = {
        unlocked = G.PROFILES[G.SETTINGS.profile].milestones["mile_"..args.key] or false,
        atlas = args.atlas or "med_milestones",
        pos = args.pos or {x = 0, y = 0},
    }
    MEDIUM.milestones["mile_"..args.key] = table_jank
end
forget_all_milestones = function ()
    G.PROFILES[G.SETTINGS.profile].milestones = {}
    for k, v in pairs(MEDIUM.milestones) do
        v.unlocked = false
    end
end
trigger_milestone_ui = function(key)
    
        ease_background_colour{new_colour = G.C.ORANGE, special_colour = G.C.PURPLE, contrast = 1.5}
        attention_text({text = "Milestone \""..localize_milestone(key).name.."\" Achieved!", hold = 12, scale = 0.5, emboss = true,})
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
    if not MEDIUM.milestones[key] then
        return "There exists no milestone with passed key "..key.."."
    else
    if G.PROFILES[G.SETTINGS.profile].milestones[key] ~= true then
    MEDIUM.milestones[key].unlocked = true
    G.PROFILES[G.SETTINGS.profile].milestones[key] = true
    trigger_milestone_ui(key)
    else
        return "Milestone with key "..key.." has already been achieved."
    end
end
end

MEDIUM.Milestone{
    key = "med_test_other"
}


MEDIUM.Milestone{
    key = "med_cassette_death"
}

SMODS.Atlas({
    key = 'test_mile',
    path = 'temp_milestone.png',
    px = 20,
    py = 20,
})

MEDIUM.Milestone{
    key = "med_test",
    atlas = "med_test_mile"
}
