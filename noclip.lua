---@type Plugin
local plugin = ...
plugin.name = 'noclip'
plugin.author = 'Jaden'
plugin.description = 'Noclip as an admin'

plugin.commands['/noclip'] = {
    info = 'Enter noclip mode',
    alias = { "/nc" },
    canCall = function(ply) return ply.isAdmin end,
    call = function(ply, _, args)
        ply:sendMessage("Calling no-clip")
        if ply.human then
            if ply.data.isNoclip ~= true then
                ply:sendMessage("You entered noclip mode.")
                plugin:print(ply.name .. " entered no-clip.")
                ply.data.isNoclip = true
                ply.data.isNoclipToggled = true
            elseif ply.data.isNoclip == true then
                ply:sendMessage("You exited noclip mode.")
                plugin:print(ply.name .. " exited no-clip.")
                ply.data.isNoclip = false
                ply.data.isNoclipToggled = false
            end
        end
    end
}

function MakeStatic(man)
    local pelvis = man:getRigidBody(0)

    pelvis.isSettled = true --Makes body part static

    pelvis.rot = pitchToRotMatrix(man.viewPitch) * yawToRotMatrix(man.viewYaw)
    pelvis.vel = Vector()       --Remove velocity
    pelvis.rotVel = RotMatrix() --Remove torque
end

function Movement(man)
    local walk = man.walkInput
    local strafe = man.strafeInput

    local up = Vector(0, 1, 0) * bit32.band(man.inputFlags, 4) / 4
    local down = Vector(0, -1, 0) * bit32.band(man.inputFlags, 8) / 8

    local mult = math.max(bit32.band(man.inputFlags, 16) / 16 * 10, 1)

    local forward = -man:getRigidBody(0).rot:getRight()
    local left = man:getRigidBody(0).rot:getForward()

    HeadCameraFix(man)

    teleportHumanWithItems(man, man.pos + ((forward * walk) + (left * strafe) + up + down) * (.2 * mult))
end

function HeadCameraFix(man)
    local memTable = { { 0x54, 0 }, { 0x7c, 1 }, { 0x58, 5 } }
    for i = 1, #memTable do
        memory.writeInt(memory.getAddress(man) + memTable[i][1], memTable[i][2])
    end
end

plugin:addHook("HumanLimbInverseKinematics", function(man, _, val)
    if not man.player or not man.player.data.isNoclip or val ~= 10 then return end

    if man.player.data.isNoclipToggled then
        MakeStatic(man)
        Movement(man)
    end

    if bit32.band(man.inputFlags, 262144) == 262144 and bit32.band(man.lastInputFlags, 262144) ~= 262144 then
        man.player.data.isNoclipToggled = not man.player.data.isNoclipToggled
        man.player:sendMessage("Toggled noclip mode: " .. tostring(man.player.data.isNoclipToggled))
    end
end)


-- if man.player and val == 10 and man.player.data.canNoclip and bit32.band(man.inputFlags, 262144) == 262144 and bit32.band(man.lastInputFlags, 262144) ~= 262144 then
--     man.data.isNoclipping = not man.data.isNoclipping
--     man.player:sendMessage(man.player.data.noclipstfu and "" or string.format("noclip: %s", man.data.isNoclipping))
-- end
