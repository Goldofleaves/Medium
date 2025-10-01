return {
    descriptions = {
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
                    "{C:attention}fusion enhancments{} are",
                    "allowed to be spawned",
                    "naturally"
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
                    "{C:inactive}(End a run with Cassette in deck)"
                }
            },
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
            fusion_enhancements = {
                name = "Fusion Enhancements",
                text = {
                    "{C:attention}Enhancements {}created",
                    "by {C:attention}merging{}",
                    "2 or more enhancements."
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
        },
        Joker = {
            j_med_branching_tree = {
                name = "Commit Tree",
                text = {
                    "If this run is not {C:attention}Seeded{},",
                    "Return {C:attention}1 10^#1#ths{} of the seed of the run",
                    "in {C:attention}Base 36{} as {V:1}Jank"
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
        dictionary={
            k_seeded = "Seeded!",
			k_incremented = "Incremented!",
			k_coins_heads = "Heads!",
			k_coins_tails = "Tails!",
			k_coins_heads_display = "Heads",
			k_coins_tails_display = "Tails",
			k_solved = "Solved!",
			k_event = "Blind event: ",
            k_improved = "Improved!",
            k_decapitated = "Decapitated...",
            k_averaged = "Averaged!",
            k_drawn = "Drawn!",
            ui_labtext = "Merge your items!",
            ui_lab_indication_temp = "This is the lab but i havent made anything yet so this is used as an indication"
        },
        suits_plural = {
            med_spears = "Spears"
        },
        suits_singular = {
            med_spears = "Spear"
        },
    }
}
