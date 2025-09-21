--(idk if this has to go here, but i assume its better if this is done before any files are loaded so nothing crashes because of it not being called yet)
--for adding custom loc_colours, dont touch this!
loc_colour()

-- CONFIG
--#region Config

Medium = SMODS.current_mod

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
local path = SMODS.current_mod.path

load_files(path, true)
--#endregion

-- MISC
--#region Miscelaneous
--[[
-- Add optional features here
Medium.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
}

Medium.extra_tabs = function ()
	return {
		--nxclicker
		{
			label = "Kill Nxkoo",
			tab_definition_function = G.UIDEF.nxclicker
		},
		-- Jukebox
		{
			label = "Jukebox",
			tab_definition_function = JTJukebox.MusicTab
		},
	}
end
]]
--#endregion

if not MediumConfig then MediumConfig = {} end
MediumConfig = SMODS.current_mod.config

SMODS.Atlas{
	key = "modicon",
	path = "modicon.png",
	px = 34,
	py = 34
}
