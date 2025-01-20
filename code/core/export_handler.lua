CreateThread(function()
    for name, func in pairs(_ENV[select(2, string.strsplit('_', cache.resource))].exports) do
        if type(func) == 'function' then
            exports(name, func)
        end
    end
end)