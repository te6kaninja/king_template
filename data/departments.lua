return {
    police = {
        nameTemplate = 'Police Department %s',
        departments = {
            {
                zoneData = {
                    coords = vec3(462.312, -991.937, 35.122),
                    radius = 50.0,
                    debug = true
                },

                blipData = {
                    sprite = 137,
                    scale = 0.8,
                    colour = 29
                    -- name = 'Police Department' -- optional, will use nameTemplate
                },

                duty = {
                    {
                        coords = vec3(441.673, -982.071, 31.539),
                        distance = 1.5,
                        interaction = 'text' -- text, target or 3dtext
                    }
                }
            }
        }
    }
}