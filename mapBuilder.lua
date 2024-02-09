---@type Plugin
local plugin = ...
plugin.name = 'MapBuilder'
plugin.author = 'Jaden Williams'
plugin.description = 'Place items/vehicles in the world as static, phsyical objects'

--Controls:
--     Z: Rotate on YAW
--     Shift + Z: Rotate on ROLL
--     Q: Rotate on PITCH
--     R move forward
--     Shift + R: Move slightly forward
--     F move backwards
--     Shift + F: Move slightly backwards

--Each part-placement gets logged into the terminal, which can be placed in the SpawWorldPreset.lua table for world reset for saving.
--(A simple copy and paste! (: )

plugin.commands["/build"] = {
    info = "Place objects around the map",
    alias = { "/b" },
    canCall = function(ply)
        return ply.isConsole or ply.isAdmin
    end,
    ---@param ply Player
    ---@param args string[]
    call = function(ply, man, args)
        if #args ~= 1 then
            man.data.isBuilding = false
            man.data.buildingItem = { nil, nil }
            ply:sendMessage("No building part detected")
            return
        end

        man.data.buildRot = 0
        man.data.buildRotV = 0
        man.data.buildRotVH = 0
        man.data.zoomDist = 10
        man.data.isBuilding = true
        man.data.buildingItem = { tostring(args[1]), nil } --Name of item, item
    end,
}


plugin:addHook("HumanLimbInverseKinematics", function(man, _, val)
    if not man.player or val ~= 10 or not man.data.isBuilding then return end

    local pHead = man:getRigidBody(3)
    local ray = pHead.pos - pHead.rot:getRight() * (man.data.zoomDist)
    local ply = man.player

    if man.data.buildingItem[2] == nil then
        local item = getItemType(man.data.buildingItem[1])
        if item == nil then
            item = getVehicleType(man.data.buildingItem[1])
        end

        if item ~= nil then
            man.data.buildingItem[2] = item.class == "ItemType" and items.create(item, ray, pHead.rot) or
                vehicles.create(item, ray, pHead.rot, 0)

            man.data.buildingItem[2].data.part = true
            ply:sendMessage("Loading item: " .. man.data.buildingItem[2].type.name)
        else
            ply:sendMessage("Item " .. man.data.buildingItem[1] .. " does not exist")
            man.data.isBuilding = false
            return
        end
    else
        local yaw = yawToRotMatrix(math.rad(man.data.buildRot))
        local roll = rollToRotMatrix(math.rad(man.data.buildRotV))
        local pitch = pitchToRotMatrix(math.rad(man.data.buildRotVH))
        local rot = yaw * roll * pitch

        local pos = Vector(math.round(ray.x, 1), math.round(ray.y, 1), math.round(ray.z, 1))

        man.data.buildingItem[2].pos = pos
        man.data.buildingItem[2].rot = rot
        man.data.buildingItem[2].rigidBody.pos = pos
        man.data.buildingItem[2].rigidBody.rot = rot
    end

    --Place by left-click
    if inputCheck(1, man) then
        local item = getItemType(man.data.buildingItem[1])
        if item == nil then
            item = getVehicleType(man.data.buildingItem[1])
        end

        local pos = Vector(math.round(ray.x, 1), math.round(ray.y, 1), math.round(ray.z, 1))

        plugin:print(man.data.buildingItem[2].type.name .. ": ----------------------------")

        plugin:print("{ \"" ..
            man.data.buildingItem[2].type.name ..
            "\", " ..
            tostring(pos) ..
            ", " .. tostring(man.data.buildingItem[2].rot) .. ", \"" .. tostring(item.class) .. "\" }")

        man.data.buildingItem[2] = nil
    end

    --Exit by right-click
    if inputCheck(2, man) then
        man.data.isBuilding = false
        man.data.buildingItem[2]:remove()
        man.data.buildingItem[2] = nil
        man.data.buildRot = 0
    end

    --Rotate pitch by Q
    if inputCheck(32, man) then
        man.data.buildRotVH = man.data.buildRotVH + 15
        ply:sendMessage("Vertical Rotation: " .. man.data.buildRotVH)
    elseif inputCheck(524288, man) and bit32.band(man.lastInputFlags, 16) == 16 then --Rotate roll by Shift + Z
        man.data.buildRotV = man.data.buildRotV + 15
        ply:sendMessage("Vertical Rotation: " .. man.data.buildRotV)
    elseif inputCheck(524288, man) and not inputCheck(16, man) then --Rotate yaw by Z
        man.data.buildRot = man.data.buildRot + 15
        ply:sendMessage("Horizontal Rotation: " .. man.data.buildRot)
    end

    --Further by R
    if inputCheck(4096, man) and bit32.band(man.lastInputFlags, 16) == 16 then --Rotate roll by Shift + Z
        man.data.zoomDist = man.data.zoomDist + .1
        ply:sendMessage("Distance: " .. man.data.zoomDist)
    elseif inputCheck(4096, man) then
        man.data.zoomDist = man.data.zoomDist + 2.5
        ply:sendMessage("Distance: " .. man.data.zoomDist)
    end

    --Closer by F
    if inputCheck(8192, man) and bit32.band(man.lastInputFlags, 16) == 16 then --Rotate roll by Shift + Z
        man.data.zoomDist = man.data.zoomDist - .1
        ply:sendMessage("Distance: " .. man.data.zoomDist)
    elseif inputCheck(8192, man) then
        man.data.zoomDist = math.max(0, man.data.zoomDist - 2.5)
        ply:sendMessage("Distance: " .. man.data.zoomDist)
    end
end)

function inputCheck(inputVal, man)
    if bit32.band(man.inputFlags, inputVal) == inputVal and bit32.band(man.lastInputFlags, inputVal) ~= inputVal then
        return true
    end
end

plugin:addHook("Physics", function()
    for _, itm in ipairs(items.getAll()) do
        if itm.data.part then
            itm.hasPhysics = true
            itm.data.noDespawn = true
            itm.data.noHold = true
            itm.rigidBody.isSettled = true
            itm.rigidBody.vel:set(Vector())
            itm.rigidBody.rotVel:set(RotMatrix())
        end
    end

    for _, itm in ipairs(vehicles.getAll()) do
        if itm.data.part then
            itm.data.noDespawn = true
            itm.data.noHold = true
            itm.rigidBody.isSettled = true
            itm.rigidBody.vel:set(Vector())
            itm.rigidBody.rotVel:set(RotMatrix())
        end
    end
end)

--Prevents grabbing item
plugin:addHook("ItemLink", function(itm)
    if itm.data.noHold then
        return hook.override
    end
end)

--Prevents item from despawning
plugin:addHook("ItemDelete", function(itm)
    if itm.data.noDespawn then
        return hook.override
    end
end)
