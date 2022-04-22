Config = Config or {}

Config.Payment = math.random(1500, 3000)

Config.Police = 1 -- for when i add this

Config.marker = vector3(1208.6, -3114.88, 4.56)

Config.Delivery = vector3(1692.11, 3286.02, 40.48)

Config.Repair = vector3(1564.18, -2166.11, 76.56)

Config.CarSpawns = {
    [1] = {
        car = vector4(796.29, -2911.52, 5.24, 267.64),
        npc = {
            [1] = vector3(795.9, -2917.23, 5.88),
            [2] = vector3(795.36, -2905.78, 5.9),
            [3] = vector3(803.88, -2917.44, 5.9),
            [4] = vector3(806.44, -2906.5, 5.9),
            [5] = vector3(809.45, -2912.83, 5.9),
        }
    },
    [2] = {
        car = vector4(1211.8, -3098.26, 5.55, 42.18),
        npc = {
            [1] = vector3(1209.2, -3120.64, 5.54),
            [2] = vector3(1199.75, -3120.57, 5.54),
            [3] = vector3(1199.6, -3112.56, 5.54),
        }
    }
}

Config.Vehicles = {
    [1] = {model = "gp1", label ="Gp1"},
    [2] = {model = "turismo2", label ="Turismo2"},
    [3] = {model = "nero2", label ="Nero2"},
}
