local pool = { Shop = 3, Lab = 1} -- weights, must be integers
function generate_shop_adjacent_event()
    local table = {}
    for k, v in pairs(pool) do
        for i = 1, v do
            table[#table+1] = k
        end
    end
    return pseudorandom_element(table, "shitfuck")
end
function generate_saj_for_curante()
    G.GAME.sajevents = {}
    for i = 1, 3 do
        G.GAME.sajevents[i] = generate_shop_adjacent_event()
    end
end
function get_color_from_saj_event(thing)
    if thing == "Shop" then
        return G.C.GOLD
    elseif thing == "Lab" then
        return G.C.GREEN
    else
        return G.C.WHITE
    end
end
