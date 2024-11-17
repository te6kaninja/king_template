local modules <const>, resource <const>, context <const> = {
    'main',
    'misc'
}, cache.resource, lib.context

local globalVarName <const>, modulesPath <const> = select(2, string.strsplit('_', resource)), ('@%s/code/modules'):format(resource)
_ENV[globalVarName] = {
    bridge = lib.require(('%s/bridge/%s'):format(modulesPath, context)),
    config = lib.require(('%s/config/config'):format(resource)),
    -- Shared values
}

CreateThread(function()
    for i = 1, #modules do
        local moduleName <const> = modules[i]

        _ENV[globalVarName][moduleName] = {
            requireMod = function(mod)
                return lib.require(('%s/%s/mods/%s'):format(modulesPath, moduleName, mod))
            end
        }

        lib.require(('%s/%s/%s'):format(modulesPath, '%s', context):format(moduleName))
    end

    for name, func in pairs(_ENV[globalVarName]) do
        if type(func) == 'function' then
            exports(name, func)
        end
    end
end)