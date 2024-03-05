---@type Plugin
local plugin = ...
plugin.name = 'Jaden\'s World Map'
plugin.author = 'Jaden Williams'
plugin.description = 'Jaden\'s modifications and additions to World Mode'

--SAVE OBJECTS IN THIS ARRAY:
--Item/Vehicle name, position, rotation, item/vehicle type (Lets the script know what to spawn)
local itemsData = {
    { "Train", Vector(2941.500000, 26.500000, 1543.500000),
        RotMatrix(1.000000, 0.000000, -0.000000, -0.000000,
            0.866025, -0.500000, 0.000000, 0.500000, 0.866025), "VehicleType" },
    { "Train", Vector(2922.300049, 27.299999, 1529.000000),
        RotMatrix(1.000000, -0.000000, 0.000000, -0.000000,
            -0.866025, -0.500000, 0.000000, 0.500000, -0.866025), "VehicleType" },
    { "Train", Vector(2941.000000, 24.200001, 1521.300049),
        RotMatrix(-0.000000, 0.000000, -1.000000, 1.000000,
            0.000000, 0.000000, 0.000000, -1.000000, -0.000000), "VehicleType" }
    { "Table", Vector(2447.100098, 24.799999, 1060.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(2447.100098, 24.799999, 1063.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "computer", Vector(2447.100098, 25.500000, 1060.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(1335.099976, 24.799999, 1048.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" }
}

function LoadModdedMap()
    for _, mapDataPoint in ipairs(itemsData) do
        local item
        if mapDataPoint[4] == "VehicleType" then
            item = getVehicleType(mapDataPoint[1])
            local itemPart = vehicles.create(item, mapDataPoint[2], mapDataPoint[3], 0)
            itemPart.data.worldModPart = true
        elseif mapDataPoint[4] == "ItemType" then
            item = getItemType(mapDataPoint[1])
            local itemPart = items.create(item, mapDataPoint[2], mapDataPoint[3])
            itemPart.data.worldModPart = true
            itemPart.data.isComputer = mapDataPoint[1] == "computer"
        end
    end
end

plugin:addHook("Physics", function()
    for _, itm in ipairs(items.getAll()) do
        if itm.data.worldModPart then
            itm.hasPhysics = true
            itm.rigidBody.isSettled = true
            itm.rigidBody.vel:set(Vector())
            itm.rigidBody.rotVel:set(RotMatrix())
        end
    end

    for _, itm in ipairs(vehicles.getAll()) do
        if itm.data.worldModPart then
            itm.rigidBody.isSettled = true
            itm.rigidBody.vel:set(Vector())
            itm.rigidBody.rotVel:set(RotMatrix())
        end
    end
end)

--Prevents grabbing item
plugin:addHook("ItemLink", function(itm)
    if itm.data.worldModPart and not itm.data.isComputer then
        return hook.override
    end
end)

--Prevents item from despawning
plugin:addHook("ItemDelete", function(itm)
    if itm.data.worldModPart then
        return hook.override
    end
end)
