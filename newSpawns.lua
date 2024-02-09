---@type Plugin
local plugin = ...
plugin.name = 'NewWorldSpawns'
plugin.author = 'Jaden'
plugin.description = 'Changes spawns from normal train spawn point'

local spawns = { Vector(2438, 25, 1065), Vector(1368, 25, 2072), Vector(1327, 25, 1052),
    Vector(1959, 73, 1574), Vector(2940, 25, 1533) }
local spawnOffset = Vector(2950, 25, 1540)

local function RandomSpawn(man)
    if not man.player or man.player.name == "" then return end

    local rSpawn = spawns[math.random(1, #spawns)]
    man:teleport(rSpawn - spawnOffset)
    plugin:print(man.player.name .. " spawned: " .. tostring(rSpawn))
end

plugin:addHook("PostHumanCreate", function(man)
    RandomSpawn(man)
end)
