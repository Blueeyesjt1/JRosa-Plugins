---@type Plugin
local plugin = ...
plugin.name = 'MovingTrain'
plugin.author = 'Jaden Williams'
plugin.description = 'Train transporting system'

local delay = 500 --5 seconds at top and bottom
local topSpeed = .5
local slowSpeed = 50000

--Add all train locations in the world, that's it. Super simple.
local realTrains = {
    --1st pos, 2nd pos, rotation matrix, direction
    { Vector(2436.1, 30.000000, 1034.6999), Vector(1348.1, 30.000000, 1034.6999),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        Vector(-1, 0, 0) }
}

local function SpawnTrain(pos1, pos2, rot, dir)
    local train = vehicles.create(vehicleTypes[13], pos1, rot, 0)

    train.data.isLast1st = true    --Is last place of train at bottom
    train.data.trainDelay = 0      --Timer
    train.data.train1stPos = pos1  --Position bottom
    train.data.train2ndPos = pos2  --Position top
    train.data.trainObject = train --train train object
    train.data.isRealTrain = true  --Is this an train?
    train.data.dir = dir           --Direction train goes back and forth

    plugin:print("Created real train: " .. tostring(pos1))
end

--Have this function be called at the start of every round
function SpawnAllRealTrainsAtStart()
    for _, trainData in ipairs(realTrains) do
        SpawnTrain(trainData[1], trainData[2], trainData[3], trainData[4])
    end
end

function moveAlltrains()
    for _, vehicle in ipairs(vehicles.getAll()) do
        if vehicle.data.isRealTrain then
            movetrain(vehicle)
        end
    end
end

local function move(obj, vectorDir)
    obj.rigidBody.pos = obj.rigidBody.pos + vectorDir
    obj.pos = obj.pos + vectorDir
    obj.rigidBody.vel:set(vectorDir)
    --plugin:print("Moving: " .. tostring(vectorDir) .. tostring(obj.pos))
end

function movetrain(train)
    local trainObj = train.data.trainObject

    local rPosRounded = Vector(math.round(trainObj.rigidBody.pos.x, 0), math.round(trainObj.rigidBody.pos.y, 0),
        math.round(trainObj.rigidBody.pos.z, 0))

    local pos1Rounded = Vector(math.round(train.data.train1stPos.x, 0), math.round(train.data.train1stPos.y, 0),
        math.round(train.data.train1stPos.z, 0))

    local pos2Rounded = Vector(math.round(train.data.train2ndPos.x, 0), math.round(train.data.train2ndPos.y, 0),
        math.round(train.data.train2ndPos.z, 0))

    if train.data.trainDelay > 0 then
        train.data.trainDelay = train.data.trainDelay - 1
        move(trainObj, Vector(0, 0, 0))
        return
    end

    local distF = Vector(math.abs(rPosRounded.x - pos2Rounded.x), math.abs(rPosRounded.y - pos2Rounded.y),
        math.abs(rPosRounded.z - pos2Rounded.z))

    local distB = Vector(math.abs(rPosRounded.x - pos1Rounded.x), math.abs(rPosRounded.y - pos1Rounded.y),
        math.abs(rPosRounded.z - pos1Rounded.z))

    local speedF = Vector(math.max(.05, (distF.x * distF.x) / slowSpeed),
        math.max(.05, (distF.y * distF.y) / slowSpeed),
        math.max(.05, (distF.z * distF.z) / slowSpeed))                                                       --Set max speed
    speedF = Vector(math.min(topSpeed, speedF.x), math.min(topSpeed, speedF.y), math.min(topSpeed, speedF.z)) --Set min speed
    speedF = Vector(speedF.x * train.data.dir.x, speedF.y * train.data.dir.y, speedF.z * train.data.dir.z)    --Multiply by normalized direction

    local speedB = Vector(math.max(.05, (distB.x * distB.x) / slowSpeed),
        math.max(.05, (distB.y * distB.y) / slowSpeed),
        math.max(.05, (distB.z * distB.z) / slowSpeed))                                                                   --Set max speed
    speedB = Vector(math.min(topSpeed, speedB.x), math.min(topSpeed, speedB.y), math.min(topSpeed, speedB.z))             --Set min speed
    speedB = Vector(speedB.x * train.data.dir.x * -1, speedB.y * train.data.dir.y * -1, speedB.z * train.data.dir.z * -1) --Multiply by normalized direction

    if train.data.isLast1st and not isInTrainStopRange(rPosRounded, pos2Rounded, 1) then                                  --If not reached 2nd,
        move(trainObj,
            Vector(
                math.min(math.abs(speedF.x), math.abs(speedB.x)) * train.data.dir.x,
                math.min(math.abs(speedF.y), math.abs(speedB.y)) * train.data.dir.y,
                math.min(math.abs(speedF.z), math.abs(speedB.z)) * train.data.dir.z
            )
        )
        return
    elseif train.data.isLast1st then
        move(trainObj, Vector(0, 0, 0))
        train.data.isLast1st = false
        train.data.trainDelay = delay
        return
    end

    if not train.data.isLast1st and not isInTrainStopRange(rPosRounded, pos1Rounded, 1) then --If not reached 1st,
        move(trainObj,
            Vector(
                math.min(math.abs(speedF.x), math.abs(speedB.x)) * -1 * train.data.dir.x,
                math.min(math.abs(speedF.y), math.abs(speedB.y)) * -1 * train.data.dir.y,
                math.min(math.abs(speedF.z), math.abs(speedB.z)) * -1 * train.data.dir.z
            )
        )
        return
    elseif not train.data.isLast1st then
        move(trainObj, Vector(0, 0, 0))
        train.data.isLast1st = true
        train.data.trainDelay = delay
        return
    end
end

function isInTrainStopRange(pos, stopPos, range)
    return pos.x > stopPos.x - range and pos.x < stopPos.x + range and
        pos.y > stopPos.y - range and pos.y < stopPos.y + range and
        pos.z > stopPos.z - range and pos.z < stopPos.z + range
end

plugin:addHook("Physics", function()
    for _, vehicle in ipairs(vehicles.getAll()) do
        if vehicle.data.isRealTrain then
            vehicle.rigidBody.isSettled = true
            vehicle.rigidBody.rotVel:set(RotMatrix())
        end
    end
    moveAlltrains()
end)
