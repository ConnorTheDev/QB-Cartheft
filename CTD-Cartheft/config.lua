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
        car = vector4(977.09, -1826.25, 30.87, 355.1),
        npc = {
            [1] = vector3(972.79, -1827.91, 31.13),
            [2] = vector3(980.9, -1828.12, 31.21),
            [3] = vector3(981.89, -1822.9, 31.22),
            [4] = vector3(973.14, -1819.64, 31.13),
            [5] = vector3(977.72, -1817.36, 31.16),
        }
    },
    [3] = {
        car = vector4(-827.83, -1264.1, 4.71, 140.21),
        npc = {
            [1] = vector3(-823.57, -1264.35, 5.0),
            [2] = vector3(-826.99, -1268.08, 5.0),
            [3] = vector3(-830.28, -1261.91, 5.0),
            [4] = vector3(-827.74, -1257.86, 6.6),
            [5] = vector3(-832.26, -1267.86, 5.0),
        }
    },
}

Config.Vehicles = {
    [1] = {model = "gp1", label ="Gp1"},
    [2] = {model = "turismo2", label ="Turismo2"},
    [3] = {model = "nero2", label ="Nero2"},
}
