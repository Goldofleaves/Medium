function G.UIDEF.milestones()
   local janknk = function (a)
      local tablet = {}
      for k, v in ipairs(a) do
         table.insert(tablet,{n = G.UIT.R, nodes = SMODS.localize_box(v, {})})
      end
      return {n = G.UIT.C, config = {align = "tl", colour = G.C.CLEAR, padding = 0.02}, nodes = tablet}
   end
   local shitfuck = {}
   local jank = function (key, unlocked, milestone)
      table.insert(shitfuck, {n = G.UIT.R, nodes = {{n = G.UIT.C, config = {r = 0.05,minw = 1,align = "cm", padding = 0.1, colour = G.C.WHITE}, nodes = {{n = G.UIT.O,
            config = {
               object = unlocked and Sprite(0, 0, 0.95, 0.95, G.ASSET_ATLAS[milestone.atlas], { x = 1, y = 0 }) or Sprite(0, 0, 0.95, 0.95, G.ASSET_ATLAS["med_milestones"], { x = 0, y = 0 })
            }},{n = G.UIT.C, config = {align = "tl", colour = G.C.CLEAR, padding = 0.02}, nodes = {
               {n = G.UIT.R, nodes = {{n=G.UIT.T, config={text = unlocked and localize_milestone(key).name or localize_milestone("undiscovered").name, scale = 0.37, colour = G.C.UI.TEXT_DARK, shadow = true}}}},
               janknk(unlocked and localize_milestone(key).text_parsed or localize_milestone("undiscovered").text_parsed),
            }}}
         }}})
      table.insert(shitfuck, {n = G.UIT.R, nodes = {{n=G.UIT.B, config = {h = 0.1, w = 0.1}}}})
   end
   for k, v in pairs(MEDIUM.milestones) do
      jank(k, v.unlocked, v)
   end
   local t =
   {n = G.UIT.ROOT, config = {r = 0.1, minw = 8, minh = 6, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
      {n = G.UIT.C, config = {r = 0.1, minw = 8, minh = 6, align = "cm", colour = G.C.CLEAR}, nodes = shitfuck}
	}}
   return {n = G.UIT.ROOT, config = {
					colour = G.C.CLEAR
				}, nodes = {
               t
            }}
end