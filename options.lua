local profile = Game.GetProfile()

local function split_string(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function update_gui(menu, metric, value)
    menu[metric].value = value
    menu[metric .. '_text'].text = string.format("%.0f%%", value)
end

local Mod_layout =
[[
<VerticalList child_padding=8>
    <Text fill=false text="Health" style=hl textalign=left />
    <HorizontalList child_fill=true>
        <Text text="0" fill=false valign=center textalign=right width=50 margin_right=5 id=health_text/>
        <Slider height=36 min=0 max=100 step=1 id=health on_change={on_slider_changed}/>
    </HorizontalList>

    <Text fill=false text="Damage" style=hl textalign=left />
    <HorizontalList child_fill=true>
        <Text text="0" fill=false valign=center textalign=right width=50 margin_right=5 id=damage_text/>
        <Slider height=36 min=0 max=100 id=damage on_change={on_slider_changed}/>
    </HorizontalList>
</VerticalList>
]]

return UI.New(Mod_layout, {
    construct = function(menu)
        if not profile.Mod_Weak_Bug then
            profile.Mod_Weak_Bug = {}
            profile.Mod_Weak_Bug.health = 0
            profile.Mod_Weak_Bug.damage = 0
        end
        for metric, value in pairs(profile.Mod_Weak_Bug) do
            update_gui(menu, metric, value)
        end
    end,
    on_slider_changed = function(menu, slider)
        local metric = slider.id
        local value = math.floor(slider.value)
        print(value)
        if not value then
            value = 0
        end
        profile.Mod_Weak_Bug[metric] = value
        update_gui(menu, metric, value)
    end,
    on_input_changed = function(menu, input)
        local parts = split_string(input.id, "_")

        local metric = parts[1]
        local value = tonumber(input.text)
        print(value)
        if not value then
            value = 0
        end
        profile.Mod_Weak_Bug[metric] = value
        update_gui(menu, metric, value)
    end,
})
