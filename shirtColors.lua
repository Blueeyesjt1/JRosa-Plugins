---@type Plugin
local plugin = ...
plugin.name = 'ShirtColors'
plugin.author = 'Jaden'
plugin.description = 'Changes shirt colors'

plugin:addHook("PostHumanCreate", function(man)
    ChangeShirt(man)
end)

local function ApparelChance(pieceRange, noneMax)
    local noneChance = math.random(0, noneMax)                  --None piece chance
    local randPiece = math.random(pieceRange[1], pieceRange[2]) --Random piece chance

    if noneChance ~= 0 then
        return randPiece
    end

    return 0
end

function ChangeShirt(man)
    if not IsPerson(man) then return end --If not player, return.

    man.model = 0
    man.suitColor = math.random(1, 10)

    local tie = ApparelChance({ 1, 10 }, 5)
    man.tieColor = tie --Tie 1/5 chance, 10 pieces

    local necklace = tie == 0 and ApparelChance({ 1, 2 }, 5) or 0
    man.necklace = necklace         --Necklace 1/5 chance, 2 pieces

    man.lastUpdatedWantedGroup = -1 --Updates across network
end

function IsPerson(man) return man.player and not man.player.isBot end --Check if player is a true person in-game
