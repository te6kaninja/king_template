local config, instances = police.config, {}
police.instances = instances

-- Class

---@class PoliceDepartment : OxClass
---@field id number The ID of the police department.
---@field name string The name of the police department.
---@field _departmentType string The type of the police department.
---@field zoneData { coords: vector3, radius: number, debug: boolean } The zone data for the police department.
local PoliceDepartment = lib.class('PoliceDepartment')

---@param data PoliceDepartment
function PoliceDepartment:constructor(data)
    local id, name, departmentType = data.id, data.name, data._departmentType

    -- Prevent duplicate instances
    if instances[id] then
        return lib.print.warn(('[PoliceDepartment] Duplicate instance with ID %s'):format(id))
    end

    -- Type checks
    if type(id) ~= 'number' then
        return lib.print.warn(('[PoliceDepartment] Invalid ID type for department %s'):format(id))
    end

    if type(name) ~= 'string' then
        return lib.print.warn(('[PoliceDepartment] Invalid name type for department %s'):format(id))
    end

    if type(departmentType) ~= 'string' then
        return lib.print.warn(('[PoliceDepartment] Invalid department type for department %s'):format(id))
    end

    -- Department creation
    self.private.id = id
    self.name = name
    self._departmentType = departmentType

    self:createBlip(data)
    self:createZone(data)

    instances[id] = self
    lib.print.debug(('[PoliceDepartment] Created department %s (%s)'):format(name, departmentType))
end

function PoliceDepartment:createBlip(data)
    
end

function PoliceDepartment:createZone(data)
    local id, zoneData = data.id, data.zoneData

    -- Data check
    if not zoneData or type(zoneData) ~= 'table' then
        return lib.print.warn(('[PoliceDepartment] You must provide zoneData. (%s)'):format(id))
    end

    if not zoneData.coords or type(zoneData.coords) ~= 'vector3' then
        return lib.print.warn(('[PoliceDepartment] You must provide coords in zoneData. (%s)'):format(id))
    end

    if not zoneData.radius or type(zoneData.radius) ~= 'number' then
        lib.print.warn(('[PoliceDepartment] Radius not provided for PD (%s)! Setting default radius.'):format(id))
        zoneData.radius = 50.0
    end
    zoneData.debug = zoneData.debug or false

    -- Zone creation
    zoneData.id = lib.points.new({
        coords = zoneData.coords,
        distance = zoneData.radius,
        debug = zoneData.debug, ---@todo
        onEnter = function()
            self:enterZone()
        end,

        onExit = function()
            self:exitZone()
        end
    })

    self.zoneData = zoneData
end

function PoliceDepartment:enterZone()
    lib.print.info(('[PoliceDepartment] Entered zone %s (%s)'):format(self.name, self._departmentType))
end

function PoliceDepartment:exitZone()
    lib.print.info(('[PoliceDepartment] Exited zone %s (%s)'):format(self.name, self._departmentType))
end

-- Loader

do
    for departmentType, departmentData in pairs(require('data.departments')) do
        local departments, nameTemplate = departmentData.departments or {}, departmentData.nameTemplate or 'Police Department %s'

        for id = 1, #departments do
            local department = departments[id]
            PoliceDepartment:new(lib.table.merge({
                id = id,
                name = nameTemplate:format(id),
                _departmentType = departmentType
            }, department))
        end
    end
end