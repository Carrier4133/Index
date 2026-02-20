local files = {
	jokers = {
		"KingsChariot",
		"WarioMan"
	}
}

for folder, list in pairs(files) do
    for _, name in ipairs(list) do
        sendTraceMessage("Loading file: "..folder..'/'..name..'.lua', "Index")
        local loaded,errormessage = pcall(SMODS.load_file(folder..'/'..name..'.lua'))
        if not loaded then
            sendErrorMessage("File '"..folder.."/"..name..".lua' failed to load!", "Index")
            sendErrorMessage(errormessage, "Index")
        end
    end
end

SMODS.Rarity{
    key = "unavailable",
    badge_colour = G.C.RED,
    default_weight = 0
}