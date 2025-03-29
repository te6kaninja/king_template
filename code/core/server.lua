local config = require('data.config')

AddEventHandler('onResourceStart', function(rsc)
    if rsc == cache.resource then
        if config.debug then
            SetConvarReplicated(('ox:printlevel:%s'):format(rsc), 'debug')
        end
    end
end)