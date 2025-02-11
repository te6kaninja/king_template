_ENV[select(2, string.strsplit('_', cache.resource))] = {
    exports = setmetatable({}, {
        __newindex = function(_, key, value)
            if type(value) == 'function' then
                exports(key, value)
            end
        end
    }),
    config = require('data.config')
    -- Shared values
}