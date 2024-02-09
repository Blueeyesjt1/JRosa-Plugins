---@type Plugin
local plugin = ...
plugin.name = 'Elevator'
plugin.author = 'Jaden Williams'
plugin.description = 'Elevator system using train collision'

local delay = 500 --5 seconds at top and bottom

--Add all elevator locations in the world, that's it. Super simple.
local elevators = {
    --Bottom pos, top position, rotation matrix
    { Vector(1129.4, 22.1, 1183.9), Vector(1129.4, 166, 1183.9),
        RotMatrix(-1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, -0.000000, 0.000000, -1.000000) },
    { Vector(2529.300049, 26.100000, 1480.000000), Vector(2529.300049, 122, 1480.000000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000) },
    { Vector(1088.000000, 22.100000, 1881.300049), Vector(1088.000000, 142, 1881.300049),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -0.000000) },
    { Vector(1272.099976, 22.299999, 1166.699951), Vector(1272.099976, 39.1, 1166.699951),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000) },
    { Vector(1496.000000, 23.500000, 1166.699951), Vector(1496.000000, 46, 1166.699951),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000) },
    { Vector(1494.699951, 46.099998, 1184.000000), Vector(1494.699951, 142, 1184.000000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000) },
    { Vector(1129.300049, 30.1, 1472.000000), Vector(1129.300049, 222.000000, 1472.000000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000) },
    { Vector(1364.000000, 34.099998, 1881.300049), Vector(1364.000000, 174, 1881.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000) },
    { Vector(1847.800049, 46.299999, 1873.300049), Vector(1847.800049, 142, 1873.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000) }
}

local function SpawnElevator(posB, posT, rot)
    local elevator = vehicles.create(vehicleTypes[13], posB, rot, 0)

    elevator.data.isLastBottom = true       --Is last place of elevator at bottom
    elevator.data.elevDelay = 0             --Timer
    elevator.data.elevBottom = posB         --Position bottom
    elevator.data.elevTop = posT            --Position top
    elevator.data.elevatorObject = elevator --Elevator train object
    elevator.data.isElevator = true         --Is this an elevator?

    plugin:print("Created elevator: " .. tostring(posB))
end

--Have this function be called at the start of every round
function SpawnAllElevatorsAtStart()
    for _, elevatorData in ipairs(elevators) do
        SpawnElevator(elevatorData[1], elevatorData[2], elevatorData[3])
    end
end

function moveAllElevators()
    for _, vehicle in ipairs(vehicles.getAll()) do
        if vehicle.data.isElevator then
            moveElevator(vehicle)
        end
    end
end

local function moveVertical(obj, val)
    obj.rigidBody.pos.y = obj.rigidBody.pos.y + val
    obj.pos.y = obj.pos.y + val
    obj.rigidBody.vel:set(Vector(0, val, 0))
end

function moveElevator(elevator)
    local elevatorObj = elevator.data.elevatorObject

    if elevator.data.elevDelay > 0 then
        elevator.data.elevDelay = elevator.data.elevDelay - 1
        elevator.rigidBody.vel:set(Vector(0, 0, 0))
    elseif elevator.data.isLastBottom and elevatorObj.rigidBody.pos.y < elevator.data.elevTop.y then --If not reached top,
        moveVertical(elevatorObj, .05)
        --plugin:print("Moving up: " .. tostring(elevatorObj.rigidBody.pos.y))
        if elevatorObj.rigidBody.pos.y >= elevator.data.elevTop.y then
            elevator.data.isLastBottom = false
            elevator.data.elevDelay = delay
        end
    elseif not elevator.data.isLastBottom and elevatorObj.rigidBody.pos.y > elevator.data.elevBottom.y then --If not reached bottom,
        moveVertical(elevatorObj, -.05)
        --plugin:print("Moving down: " .. tostring(elevatorObj.rigidBody.pos.y))
        if elevatorObj.rigidBody.pos.y <= elevator.data.elevBottom.y then
            elevator.data.isLastBottom = true
            elevator.data.elevDelay = delay
        end
    end
end

plugin:addHook("Physics", function()
    for _, vehicle in ipairs(vehicles.getAll()) do
        if vehicle.data.isElevator then
            vehicle.rigidBody.isSettled = true
            vehicle.rigidBody.rotVel:set(RotMatrix())
        end
    end
    moveAllElevators()
end)
