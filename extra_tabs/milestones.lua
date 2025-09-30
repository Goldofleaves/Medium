
function G.UIDEF.milestones()
    local text = "Shitfuck"
    return {n = G.UIT.ROOT, config = {
					colour = G.C.CLEAR
				}, nodes = {
					{n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
                        {n = G.UIT.C, config = {r = 0.1, minw = 8, minh = 6, align = "cm", colour = G.C.CLEAR}, nodes = {
                            {n = G.UIT.R, config = {r = 0.1,minw = 1,align = "cm", padding = 0.2, colour = G.C.CLEAR}, nodes = {
                               {n=G.UIT.T, config={text = text, scale = 0.75, colour = G.C.WHITE, shadow = true}},
                               {n=G.UIT.T, config={text = "Fuck Everyone", scale = 0.75, colour = G.C.WHITE, shadow = true}},
                            }},
                    }}
				}}
            }}
end