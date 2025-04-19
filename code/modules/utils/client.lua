police.utils = {}

-- Debug zone

local debuggedZones = {}

local debugLoopState = false
local function drawDebugZone()
    if not debugLoopState then
        debugLoopState = true
        while #debuggedZones > 0 do
            for i = 1, #debuggedZones do
                local zone = debuggedZones[i]
                local distance, x, y, z = zone.distance, table.unpack(zone.coords)
                DrawMarker(28, x, y, z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, distance, distance, distance,
                ---@diagnostic disable-next-line: param-type-mismatch
                24.0, 42.0, 255.0, 100.0, false, false, 2, false, nil, nil, false)
            end

            Wait(4)
        end
        debugLoopState = false
    end
end

---@param toggle boolean
---@param data CPoint
function police.utils.debugZone(toggle, data)
    if toggle then
        if not data or not data.id then
            return lib.print.warn(('[PoliceDepartment] Zone data not found for department %s'):format(data.id))
        end

        if not debuggedZones[data.id] then
            debuggedZones[data.id] = data
        end
    else
        if debuggedZones[data.id] then
            debuggedZones[data.id] = nil
        end
    end
    lib.print.debug(('[Utils] Debug zone %s for department (%s)'):format(toggle and 'enabled' or 'disabled', data.id))

    CreateThread(drawDebugZone)
end