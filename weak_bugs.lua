local package = ...

-- package.includes = {
--     "main/data/components.lua",
--     "main/data/data.lua",
--     "main/data/frames.lua"
-- }

-- 4183041537
-- called when mod is initializing
function package:init()
    for key, frame in pairs(data.frames) do
        if frame.slot_type == "bughole" then
            frame.health_points = 1
            if frame.components then
                for c_key, c_val in pairs(frame.components) do
                    local component = data.components[c_val[1]]
                    if component and component.damage then
                        component.damage = 0
                    end
                end
            end
        end

        if frame.components then
            for c_key, c_val in pairs(frame.components) do
                local component_name = c_val[1]
                if component_name and component_name == "c_bug_spawn" then
                    frame.health_points = 1
                end
            end
        end
    end
end
