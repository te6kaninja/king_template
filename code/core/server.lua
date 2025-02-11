local config = require('data.config')

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        SetConvarReplicated(('ox:printlevel:%s'):format(resource), config.debug and 'debug' or 'info')
    end
end)