local modules <const>, resource <const>, context <const> = {
    'main',
    'misc'
}, cache.resource, lib.context

local globalVarName <const>, modsPath <const> = select(2, string.strsplit('_', resource)), ('@%s/code/modules'):format(resource)
_ENV[globalVarName] = {
    bridge = lib.require(('%s/bridge/%s'):format(modsPath, context)),
    config = lib.require(('%s/config/config'):format(resource)),
    -- Shared values
}

CreateThread(function()
    local defaultPath <const> = ('%s/%s/%s'):format(modsPath, '%s', context)
    for i = 1, #modules do
        _ENV[globalVarName][modules[i]] = {}
        lib.require(defaultPath:format(modules[i]))
    end

    for name, func in pairs(_ENV[globalVarName]) do
        if type(func) == 'function' then
            exports(name, func)
        end
    end
end)