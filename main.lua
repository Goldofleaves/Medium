MEDIUM = {}
--(idk if this has to go here, but i assume its better if this is done before any files are loaded so nothing crashes because of it not being called yet)
--for adding custom loc_colours, dont touch this!
loc_colour()

-- CONFIG
--#region Config

Medium = SMODS.current_mod
Medium.calculate = function (self, context)

end
--#endregion

-- FILE LOADING
--#region File Loading
local nativefs = NFS

local function load_file_native(path, id)
    if not path or path == "" then
        error("No path was provided to load.")
    end
    local file_path = path
    local file_content, err = NFS.read(file_path)
    if not file_content then return  nil, "Error reading file '" .. path .. "' for mod with ID '" .. SMODS.current_mod.id .. "': " .. err end
    local chunk, err = load(file_content, "=[SMODS " .. SMODS.current_mod.id .. ' "' .. path .. '"]')
    if not chunk then return nil, "Error processing file '" .. path .. "' for mod with ID '" .. SMODS.current_mod.id .. "': " .. err end
    return chunk
end
local blacklist = {
	assets = true,
	lovely = true,
	[".github"] = true,
	[".git"] = true,
	["localization"] = true
}
local function load_files(path, dirs_only)
	local info = nativefs.getDirectoryItemsInfo(path)
	for i, v in pairs(info) do
		if v.name ~= "main.lua" and v.name ~= "config.lua" then
		if v.type == "directory" and not blacklist[v.name] then	
			load_files(path.."/"..v.name)
		elseif not dirs_only then
			if string.find(v.name, ".lua") then -- no X.lua.txt files or whatever unless they are also lua files
				local f, err = load_file_native(path.."/"..v.name)
				if f then f() 
				else error("error in file "..v.name..": "..err) end
			end
		end
	end
	end
end
local path = SMODS.current_mod.path

load_files(path, false)


SMODS.Atlas({
    key = 'backdrop', -- internally as med_backdrop. How unfortunate!
    path = 'backdrop.png',
    px = 613,
    py = 346,
})

SMODS.Atlas({
    key = 'milestones', -- internally as med_milestones. How unfortunate!
    path = 'milestones.png',
    px = 20,
    py = 20,
})

Medium.extra_tabs = function ()
	return {
		{
			label = "Milestones",
			tab_definition_function = G.UIDEF.milestones
		},
	}
end
if not MediumConfig then MediumConfig = {} end
MediumConfig = SMODS.current_mod.config

SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}

SMODS.Atlas {
  key = "lab_sign",
  path = "labsign.png",
  px = 113,py = 57,
  frames = 4, atlas_table = 'ANIMATION_ATLAS'
}

Medium.ui_config = {
    colour = HEX("4c2177"),
    bg_colour = adjust_alpha(HEX("b609f1"), 0.3),
    back_colour = HEX("b609f1"),
    tab_button_colour = HEX("b609f1"),
    collection_option_cycle_colour = HEX("b609f1"),
    author_colour = HEX("b609f1")
}

Medium.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
end

-- config
MEDIUM.config = SMODS.current_mod.config

Medium.config_tab = function()
	local nodes = {}
	local funk = {{n=G.UIT.C, config = {minw = 0.05}}}
	for k, v in pairs(MEDIUM.config.shop_adjecent_events) do
	funk[#funk + 1] = create_toggle({
		label = localize("k_config_"..string.lower(k)),
		active_colour = HEX("b609f1"),
		ref_table = MEDIUM.config.shop_adjecent_events,
		ref_value = k,
		callback = function()
		end
	})
	end
	nodes[#nodes + 1] = {n = G.UIT.R, nodes = {
                    {n=G.UIT.C, config = { align = "tm", colour = G.C.L_BLACK, padding = 0.2, maxh = 2.7, minw = 2.3, minh = 1.9, r = 0.2 }, nodes = {
                        {n=G.UIT.R, config = { align = "cm", minw = G.CARD_W }, nodes = {
                            {n=G.UIT.T, config = { text = localize('k_config_shop_adjacent_events'), scale = 0.5, colour = G.C.BLACK } },
                        }},
                        {n=G.UIT.R, config = { align = "cm", colour = G.C.BLACK, minh = G.CARD_H - 0.4, r = 0.2}, nodes = funk}
                    }},
                }}
	nodes[#nodes + 1] = {n=G.UIT.R, config = {minw = 0.05, minh = 0.1}}
	nodes[#nodes + 1] = {n = G.UIT.R, nodes = {
                    {n=G.UIT.C, config = { align = "tm", colour = G.C.L_BLACK, padding = 0.2, maxh = 2.7, minw = 2.3, minh = 1.9, r = 0.2 }, nodes = {
                        {n=G.UIT.R, config = { align = "cm", minw = G.CARD_W }, nodes = {
                            {n=G.UIT.T, config = { text = localize('k_config_general'), scale = 0.5, colour = G.C.BLACK } },
                        }},
                        {n=G.UIT.R, config = { align = "cm", colour = G.C.BLACK, minh = G.CARD_H - 0.4, r = 0.2}, nodes = {create_toggle({
                        	label = localize("k_config_custom_music"),
                        	active_colour = HEX("b609f1"),
                        	ref_table = MEDIUM.config,
                        	ref_value = "custom_music",
                        	callback = function()
                        	end,
                        }),
						create_toggle({
                        	label = localize("k_config_animatedjokers"),
                        	active_colour = HEX("b609f1"),
                        	ref_table = MEDIUM.config,
                        	ref_value = "animjokers",
                        	callback = function()
                        	end,
                        })
					}}
                    }},
                }}
	return {
		n = G.UIT.ROOT,
		config = {
			emboss = 0.05,
			minh = 6,
			r = 0.1,
			minw = 10,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = {{n = G.UIT.C, nodes = nodes}},
	}
end

SMODS.Font {
  key = "currency", -- oh NO
  path = "currency.ttf"
}

SMODS.Gradient {
    key = 'currency',
    colours = {G.C.RED, G.C.ORANGE, HEX("d5d645"), G.C.GREEN, G.C.BLUE, G.C.PURPLE, HEX("d64ac3")},
    cycle = 5
}
MEDIUM.penrose_triangle_func = function (a)
    return a
end