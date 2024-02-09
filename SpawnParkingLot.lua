---@type Plugin
local plugin = ...
plugin.name = 'SpawnParkingLot'
plugin.author = 'Jaden'
plugin.description = 'Spawn cars in designated parking grids'

local validCarTable = { 0, 5, 6, 7 }
local validCarColorTable = { 0, 1, 2, 3 }

local distX = 5
local distZ = 8

function SpawnWorldParkedCars()
    GenerateCarGrid(2453, 25, 1057, 4, 8)       --Main gun store
    GenerateCarGrid(1341, 25, 1046, 4, 7)       --Pentacom gun store
    GenerateCarGrid(1299, 25, 2067, 2, 12)      --Mansota gun store
    GenerateCarGrid(1939, 75, 1608, 5, 6)       --Central gun store
    GenerateCarGrid(2949.84, 25, 1523.16, 5, 4) --Main spawn
end

function GenerateCarGrid(lotX, lotY, lotZ, totRows, rowLength)
    for j = 0, totRows - 1 do
        for i = 0, rowLength - 1 do
            if math.random(1, 5) ~= 1 then goto continue end

            local randCarSelected = validCarTable[math.random(1, #validCarTable)]
            local randCarColorSelected = validCarColorTable[math.random(1, #validCarColorTable)]

            local car = vehicles.create(vehicleTypes[randCarSelected],
                Vector(lotX + (distX * i), lotY, lotZ + (distZ * j)),
                RotMatrix(1, 0, 0, 0, 1, 0, 0, 0, 1), randCarColorSelected
            )

            --if math.random(1, 3) == 1 then car.numSeats = 0 end --Prevents them from getting in car.

            ::continue::
        end
    end
end
