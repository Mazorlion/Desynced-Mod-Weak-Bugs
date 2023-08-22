local package = ...

local profile = Game.GetProfile()

-- called when mod is initializing
function package:init()
    if not profile.Mod_Weak_Bug then
        profile.Mod_Weak_Bug = {}
        profile.Mod_Weak_Bug.health = 0
        profile.Mod_Weak_Bug.damage = 0
    end

    for key, frame in pairs(data.frames) do
        if frame.slot_type == "bughole" then
            frame.health_points = math.ceil(frame.health_points * (profile.Mod_Weak_Bug.health / 100))
            if frame.health_points < 1 then
                frame.health_points = 1
            end
            if frame.components then
                for c_key, c_val in pairs(frame.components) do
                    local component = data.components[c_val[1]]
                    if component and component.damage and component.damage > 0 then
                        component.damage = math.ceil(component.damage * (profile.Mod_Weak_Bug.damage / 100))
                    end
                end
            end
        end

        if frame.components then
            for c_key, c_val in pairs(frame.components) do
                local component_name = c_val[1]
                if component_name and component_name == "c_bug_spawn" then
                    frame.health_points = math.ceil(math.floor(frame.health_points * (profile.Mod_Weak_Bug.health / 100)))
                    if frame.health_points < 1 then
                        frame.health_points = 1
                    end
                end
            end
        end
    end
end
