return {
    Tutorials = {
        medium_lab = {
            name = "The Labratory",
            text = {
                {
                    name = "Overview",
                    text = {
                        {
                            "The {C:green}Lab{} is a new event type",
                            "added by {C:purple}MEDIUM{}.",
                            "It allows the fusion of certain {C:attention}cards{}",
                            "with a small cost."
                        },
                        {
                            "Merged things are usually {C:attention}stronger{}",
                            "than both things being used for merging.",
                            "Merging requires not only money,",
                            "but also {C:green}science equipment{}.",
                            "You can get these by {C:attention}fishing in the dock{},",
                            "{C:attention}exchanging in the marketplace{},",
                            "and more!"
                        },
                    }
                },
            },
        },
    },
    descriptions = {
        Spectral = {
            c_med_vscode = {
                name = "VSCode",
                text = {
                    "Choose one of ",
                    "{C:attention}any interface{}",
                    "{C:attention}card to spawn.",
                    "{C:inactive}(Must have room)"
                }
            },
        },
        Interface = {
            c_med_chrome = {
                name = "Chrome",
                text = {
                    "TBD."
                }
            },
        },
        Edition = {
            e_med_reflective = {
                name = "Reflective",
                text = {
                    "{X:attention,C:white}X#1#{} Jank"
                }
            },
        },
        Voucher = {
            v_med_fashion = {
                name = 'Fashion',
                text = {
                    "Cards with",
                    "{C:attention}fusion suits{} are",
                    "allowed to be spawned",
                    "naturally"
                }
            },
            v_med_vogue = {
                name = 'Vogue',
                text = {
                    "Cards with",
                    "{C:attention}fusion enhancements{} and",
                    "{C:attention}fusion seals{} are",
                    "allowed to be spawned",
                    "naturally"
                }
            },
            v_med_dilettante = {
                name = 'The Dilettante',
                text = {
                        "You can now {C:attention}injog",
                        "{C:attention}1{} more card",
                }
            },
            v_med_gambler = {
                name = 'The Gambler',
                text = {
                        "You can now {C:attention}injog",
                        "{C:attention}1{} more card",
                }
            },
        },
        Milestones = {
            undiscovered = {
                name = "Locked Milestone",
                text = {
                    "You have yet to",
                    "{C:attention}achieve{} this Milestone."
                }
            },
            mile_med_cassette_death = {
                name = "Massive Headache",
                text = {
                    "What was that?!",
                    "{C:inactive}(End a run with {C:attention,T:j_med_cassette}Cassette{C:inactive} in deck)"
                }
            },
            mile_med_cheat = {
                name = "Cheat",
                text = {
                    "Did I see what I think I saw?",
                    "{C:inactive}(Play an {C:attention}injogged{C:inactive} card)"
                }
            },
            --[[mile_med_test = {
                name = "Test",
                text = {
                    "This Milestone Is For",
                    "{C:attention}Testing{} Perposes."
                }
            },
            mile_med_test_other = {
                name = "Test 2",
                text = {
                    "This Milestone Is For",
                    "{C:attention}Testing{} Perposes."
                }
            },]]
        },
        Enhanced={
            m_med_plus_four={
                name="Wild +4 Card",
                text={
                    "This card counts as",
                    "{C:attention}all suits{}.",
                    "Draw {C:attention}#1#{} cards when",
                    "This card is played.",
                    "No rank, Always scored."
                },
            },
        },
        Other = {
            -- seals
            med_orange_seal = {
                name = "Orange Seal",
                text = {
                    "{C:attention}+#1#{} Jank",
                    "while held in hand",
                },
            },
            med_taupe_seal = {
                name = "Taupe Seal",
                text = {
                    "If this is the only",
                    "played card,",
                    "{C:attention}create{} an",
                    "{C:attention}Interface{} card."
                },
            },
            undiscovered_interface = {
                name = "Not Discovered",
                text = {
                    "Purchase or use this",
                    "card in an",
                    "unseeded run to",
                    "learn what it does",
                },
            },
            fusion_enhancements = {
                name = "Fusion Enhancements",
                text = {
                    "{C:attention}Enhancements {}created",
                    "by {C:attention}merging{}",
                    "2 or more enhancements."
                }
            },
            fusion_seals = {
                name = "Fusion Seals",
                text = {
                    "{C:attention}Seals {}created",
                    "by {C:attention}merging{}",
                    "2 or more seals."
                }
            },
            fusion_suits = {
                name = "Fusion Suits",
                text = {
                    "{C:attention}Suits {}created",
                    "by {C:attention}merging{}",
                    "2 or more suits."
                }
            },
            average = {
                name = "Averaging Suits",
                text = {
                    "Set all suits",
                    "of all cards ",
                    "being {C:attention}averaged{}",
                    "to the {C:attention}fusion{} of",
                    "them."
                }
            },
            decapitated_jank = {
                name = "Decapitated Operator",
                text = {
                    "Score = {C:mult}Mult{} x min({C:chips}Chips{}, {C:attention}Jank{})"
                }
            },
            improved_jank = {
                name = "Improved Operator",
                text = {
                    "Score = {C:mult}Mult{} x ({C:chips}Chips{} + {C:attention}Jank{})"
                }
            },
            injogged_cards = {
                name = "Injogged Cards",
                text = {
                        "Injogged cards are",
                        "{C:attention}drawn first{}",
                        "{C:attention}Right click{} to injog",
                }
            },
            high_valued_cards = {
                name = "High-Valued Cards",
                text = {
                    "{C:attention}Aces{}, {C:attention}Kings{},",
                    "{C:attention}Queens{} and {C:attention}Jacks{}."
                }
            },
            low_valued_cards = {
                name = "Low-Valued Cards",
                text = {
                    "{C:attention}2s{}, {C:attention}3s{},",
                    "{C:attention}4s{} and {C:attention}5s{}."
                }
            },
        },
        Joker = {
            j_med_ionization = {
                name = "Ionization",
                text = {
                    {
                        "Enhance the first {C:attention}#1#",
                        "in played hand",
                        "to a {C:attention}#3#"
                    },
                    {
                        "{C:attention}Convert{} the first two",
                        "played cards with a",
                        "rank difference of {C:attention}#2#{}",
                        "than {C:attention}#1#{} to {C:attention}#1#s{}"
                    }
                    }
                },
            j_med_cardshark = {
                name = "Card Shark",
                text = {
                        "You can now {C:attention}injog",
                        "{C:attention}#1#{} more cards",
                    }
                },
            j_med_nofdix = {
                name = "Nøf Dix",
                text = {
                    "Each scored {C:attention}enhanced",
                    -- "card gives {C:med_currency,f:med_currency}_2{}"
                    "card gives {C:gold}$#1#{}"
                    }
                },
            j_med_elixir = {
                name = "Elixir",
                text = {
                    "When {C:attention}merging{} in the {C:green}LAB{},",
                    "{C:attention}merge this card{} with any",
                    "other card to add",
                    "an {C:dark_edition}edition{} to it"
                    }
                },
            j_med_blue = {
                name = "Blue",
                text = {
                    "{X:chips,C:white}X#1#{} Chips",
                    "{C:inactive}The worst joker",
                    "{C:inactive}in this mod",
                    }
                },
            j_med_kevin_haas = {
                name = "Kevin Haas",
                text = {
                    "{C:green}#1# in #2#{} Chance to",
                    "permanantly {C:blue}+#3# Hand#4#{} ",
                    "at the {C:attention}start of round",
                    "{C:inactive}Having Fun?",
                    }
                },
            j_med_branching_tree = {
                name = "Commit Tree",
                text = {
                    "If this run is not {C:attention}Seeded{},",
                    "Return {C:attention}1 10^#1#ths{} of",
                    "the seed of the run",
                    "in {C:attention}Base 36{} as {V:1}Jank"
                    }
                },
            j_med_milestone = {
                name = "Milestone",
                text = {
                    "{X:mult,C:white}X#1#{} Mult,",
                    "lose {X:mult,C:white}X#2#{} Mult times",
                    "the total amount of",
                    "{C:attention}milestones not unlocked{},",
                    "divided by the total",
                    "amount of milestones {C:inactive}(#3#/#4#)",
                    "{C:attention}at the end of round{}."
                    }
                },
            j_med_sunrise = {
                name = "Sunrise",
                text = {
                    "On the {C:attention}first #1# hands{}",
                    "of round, {C:attention}upgrade{}",
                    "played hands",
                    }
                },
            j_med_achts = {
                name = "A Coin Has Two Sides",
                text = {
                    "{C:attention}Flip a coin{} when",
                    "{C:attention}selecting blind{},",
                    "{B:1,C:white}Increment{} the default value",
                    "of {V:1}Jank{} by {C:attention}#2#{} if landed on {C:attention}Tails,{}",
                    "{V:1}+#3# {}Jank if",
                    "landed on {C:attention}Heads.{}",
                    "{C:inactive}(Currently: {C:attention}#1#{C:inactive})"
                    }
                },
            j_med_cassette = {
                name = "Cassette",
                text = {
                    "When you {C:attention}lose{},",
                    "go back to when",
                    "this Joker was {C:attention}bought{},",
                    "and {C:attention}change something{}..."
                    }
                },
            j_med_chiptunetracker = {
                name = "Chiptune Tracker",
                text = {
                    "{V:1}+#1# {}Jank",
                    }
                },
            j_med_chemicalequation = {
                name = "Chemical Equation",
                text = {
                    "When {C:attention}entering a blind{},",
                    "{C:green}#1# in #2# {}Chance to",
                    "{B:1,C:white}Decapitate{} the current jank operator.",
                    "Else, {B:1,C:white}Improve{} the current jank operator"
                    }
                },
            j_med_muddywater = {
                name = "Muddy Water",
                text = {
                    "If {C:attention}played{} hand contains only 2 cards",
                    "and their {C:attention}suits{} are both",
                    "{C:attention}different{} and not {C:attention}fusion{} suits,",
                    "{X:green,C:white}Average{} the 2 suits."
                    }
                },
            j_med_rigor_1 = {
                name = "Rigor",
                text = {
                    {
                        "{C:attention}Disprove{} the following",
                        "{C:attention}conjecture{} to win {C:attention}a reward!{}",
                        "{C:attention}Disprove{} the {C:attention}conjecture{} ",
                        "by playing a counterexample.",
                        "{C:inactive,s:0.7}(Changes conjecture when the current one is solved.)"
                    },
                    {
                        "Current Conjecture:",
                        "The {C:attention}Square Root{} of",
                        "a natural number is always",
                        "smaller than the original number."
                    },
                    {
                        "Reward:{C:gold} +#1#$"
                    }
                },
            },
            j_med_rigor_2 = {
                name = "Rigor",
                text = {
                    {
                        "{C:attention}Disprove{} the following",
                        "{C:attention}conjecture{} to win {C:attention}a reward!{}",
                        "{C:attention}Disprove{} the {C:attention}conjecture{} ",
                        "by playing a counterexample.",
                        "{C:inactive,s:0.7}(Changes conjecture when the current one is solved.)"
                    },
                    {
                        "Current Conjecture:",
                        "If a is a natural number,",
                        "and b is a natural number,",
                        "then a - b is a natural number."
                    },
                    {
                        "Reward: {X:mult,C:white}X#2#{} Mult"
                    }
                },
            },
            j_med_rigor_3 = {
                name = "Rigor",
                text = {
                    {
                        "{C:attention}Disprove{} the following",
                        "{C:attention}conjecture{} to win {C:attention}a reward!{}",
                        "{C:attention}Disprove{} the {C:attention}conjecture{} ",
                        "by playing a counterexample.",
                        "{C:inactive,s:0.7}(Changes conjecture when the current one is solved.)"
                    },
                    {
                        "Current Conjecture:",
                        "For any natural number a and b,",
                        "a raised to the bth power is always",
                        "different than the product of a and b."
                    },
                    {
                        "Reward: +{C:chips} #3# {}Chips"
                    }
                },
            },
            j_med_rigor_4 = {
                name = "Rigor",
                text = {
                    {
                        "{C:attention}Disprove{} the following",
                        "{C:attention}conjecture{} to win {C:attention}a reward!{}",
                        "{C:attention}Disprove{} the {C:attention}conjecture{} ",
                        "by playing a counterexample.",
                        "{C:inactive,s:0.7}(Changes conjecture when the current one is solved.)"
                    },
                    {
                        "Current Conjecture:",
                        "If a is a natural number,",
                        "then the square root of a",
                        "must not be a natural number."
                    },
                    {
                        "Reward: + {C:mult}#4#{} Mult"
                    }
                },
            },
        },
    },
    misc = {
        labels = {
            med_orange_seal = "Orange Seal",
            med_taupe_seal = "Taupe Seal",
            med_reflective = "Reflective",
        },
        dictionary={
            --config
            k_destroyed = "Destroyed!",
            k_blue1 = "X",
            k_blue2 = " Chips",
            k_config_lab = "Lab",
            k_config_test = "Test",
            k_config_test2 = "Test2",
            k_config_custom_music = "Enable custom music",
            k_config_animatedjokers = "Animate certain jokers",
            k_config_shop_adjacent_events = "Shop Adjacent Events:",
            k_config_general = "General:",
            k_hand = "Hand",
            k_plural = "s",
            b_interface_cards = 'Interface Cards',
            k_interface = 'Interface',
            k_list_of_milestones = "List of Milestones:",
            k_seeded = "Seeded!",
			k_incremented = "Incremented!",
			k_converted = "Converted!",
			k_enhanced = "Enhanced!",
			k_coins_heads = "Heads!",
			k_coins_tails = "Tails!",
			k_coins_heads_display = "Heads",
			k_coins_tails_display = "Tails",
			k_solved = "Solved!",
			k_event = "Blind event: ",
            k_jdisplay_incdefjank = "Inc. Def. Jank by ",
            k_jdisplay_jank = "Jank",
            k_improved = "Improved!",
            k_decapitated = "Decapitated...",
            k_averaged = "Averaged!",
            k_drawn = "Drawn!",
            ui_labtext = "Merge your items!",
            ui_lab_indication_temp = "This is the lab but i havent made anything yet so this is used as an indication",
            ui_lab_merge = "Merge",
            ui_lab_recipes = "Recipes",
            ui_lab_button_merge = "MERGE",
            ui_lab_button_next = "NEXT",
            ui_lab_button_take = "TAKE",
        },
        suits_plural = {
            med_spears = "Spears"
        },
        suits_singular = {
            med_spears = "Spear"
        },
    }
}
