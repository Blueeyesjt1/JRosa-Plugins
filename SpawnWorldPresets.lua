---@type Plugin
local plugin = ...
plugin.name = 'Jaden\'s World Map'
plugin.author = 'Jaden Williams'
plugin.description = 'Jaden\'s modifications and additions to World Mode'


--Item/Vehicle name, position, rotation, item/vehicle type (Lets the script know what to spawn)
local itemsData = {
    { "Train", Vector(2941.500000, 26.500000, 1543.500000),
        RotMatrix(1.000000, 0.000000, -0.000000, -0.000000,
            0.866025, -0.500000, 0.000000, 0.500000, 0.866025), "VehicleType" },
    { "Train", Vector(2922.300049, 27.299999, 1529.000000),
        RotMatrix(1.000000, -0.000000, 0.000000, -0.000000,
            -0.866025, -0.500000, 0.000000, 0.500000, -0.866025), "VehicleType" },
    { "Train", Vector(2941.000000, 24.200001, 1521.300049),
        RotMatrix(-0.000000, 0.000000, -1.000000, 1.000000,
            0.000000, 0.000000, 0.000000, -1.000000, -0.000000), "VehicleType" },
    { "Train", Vector(2940.699951, 24.200001, 1550.699951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 1.000000,
            0.000000, 0.000000, 0.000000, -1.000000, -0.000000), "VehicleType" },
    { "Train", Vector(2932.000000, 30.200001, 1521.300049),
        RotMatrix(-0.000000, 0.000000, -1.000000, -0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "VehicleType" },
    { "Train", Vector(2931.800049, 30.200001, 1550.699951),
        RotMatrix(-0.000000, 0.000000, -1.000000, -0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "VehicleType" },
    { "Train", Vector(2921.899902, 24.200001, 1550.699951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 1.000000,
            0.000000, 0.000000, 0.000000, -1.000000, -0.000000), "VehicleType" },
    { "Train", Vector(2922.000000, 24.200001, 1521.300049),
        RotMatrix(-0.000000, 0.000000, -1.000000, 1.000000, 0.000000, -0.000000, -0.000000, -1.000000, -0.000000),
        "VehicleType" },
    { "Train", Vector(2929.800049, 31.000000, 1529.900024),
        RotMatrix(0.000000, -1.000000, 0.000000, 1.000000,
            0.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(2929.800049, 31.000000, 1542.800049),
        RotMatrix(0.000000, -1.000000, 0.000000, 1.000000,
            0.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Table", Vector(2447.100098, 24.799999, 1060.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(2447.100098, 24.799999, 1063.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "computer", Vector(2447.100098, 25.500000, 1060.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(1335.099976, 24.799999, 1048.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(1335.099976, 24.799999, 1051.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "computer", Vector(1335.199951, 25.500000, 1048.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(1364.800049, 24.799999, 2064.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "Table", Vector(1367.300049, 24.799999, 2064.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "computer", Vector(1364.800049, 25.500000, 2064.699951),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "Table", Vector(1956.800049, 72.800003, 1568.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "Table", Vector(1959.300049, 72.800003, 1568.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "computer", Vector(1956.800049, 73.500000, 1568.699951),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "Train", Vector(1347.099976, 25.200001, 1009.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1372.599976, 27.299999, 1037.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(2435.500000, 27.100000, 1010.299988),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(2459.300049, 27.100000, 1038.099976),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000, 0.000000, 0.000000, -0.000000, 1.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1346.900024, 25.000000, 2033.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1371.500000, 25.600000, 2062.000000),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "cubewall", Vector(1334.099976, 27.299999, 1043.500000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, -0.500000, -0.866025, 0.000000, 0.866025, -0.500000),
        "ItemType" },
    { "cubewall", Vector(1336.500000, 27.299999, 1045.900024),
        RotMatrix(0.000000, 0.000000, -1.000000, 0.866025, -0.500000, -0.000000, -0.500000, -0.866025, -0.000000),
        "ItemType" },
    { "cubewall", Vector(2446.100098, 27.299999, 1055.400024),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            -0.500000, -0.866025, 0.000000, 0.866025, -0.500000), "ItemType" },
    { "cubewall", Vector(2448.600098, 27.299999, 1057.900024),
        RotMatrix(-0.000000, 0.000000, -1.000000, -0.866025,
            0.500000, 0.000000, 0.500000, 0.866025, 0.000000), "ItemType" },
    { "Train", Vector(2417.300049, 26.299999, 1050.099976),
        RotMatrix(1.000000, 0.000000, -0.000000, -0.000000, 0.866025, -0.500000, 0.000000, 0.500000, 0.866025),
        "VehicleType" },
    { "Train", Vector(1341.900024, 26.299999, 1074.699951),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.500000, 0.866025, 0.000000, -0.866025, 0.500000, 0.000000),
        "VehicleType" },
    { "cubewall", Vector(1951.500000, 75.300003, 1569.800049),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.866025, 0.500000, 0.000000, 0.500000, -0.866025, -0.000000),
        "ItemType" },
    { "cubewall", Vector(1953.900024, 75.199997, 1567.400024),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000, 0.500000, 0.866025, -0.000000, 0.866025, -0.500000),
        "ItemType" },
    { "Train", Vector(1945.599976, 75.099998, 1598.599976),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.500000, -0.866025, -0.000000, 0.866025, 0.500000, -0.000000),
        "VehicleType" },
    { "cubewall", Vector(1359.400024, 27.200001, 2065.800049),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.866025,
            0.500000, 0.000000, -0.500000, 0.866025, 0.000000), "ItemType" },
    { "cubewall", Vector(1362.000000, 27.200001, 2063.399902),
        RotMatrix(-1.000000, -0.000000, -0.000000, -0.000000,
            0.500000, 0.866025, -0.000000, 0.866025, -0.500000), "ItemType" },
    { "Train", Vector(1354.099976, 26.299999, 2079.699951),
        RotMatrix(0.000000, 0.000000, 1.000000, -0.500000, 0.866025, 0.000000, -0.866025, -0.500000, 0.000000),
        "VehicleType" },
    { "Train", Vector(2925.199951, 22.200001, 1528.000000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(2927.699951, 22.200001, 1528.000000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(2925.199951, 22.200001, 1544.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(2927.699951, 22.200001, 1544.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "cubewall", Vector(2933.800049, 24.6, 1520.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2937.300049, 24.6, 1520.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2939.300049, 24.6, 1520.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2927.199951, 24.6, 1520.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2925.300049, 24.6, 1520.099976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2927.199951, 24.600000, 1551.900024),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2924.199951, 24.600000, 1551.900024),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2933.800049, 24.6, 1551.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2934.800049, 24.6, 1551.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2938.199951, 24.6, 1551.800049),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 26.299999, 1520.099976),
        RotMatrix(-0.000000, 1.000000, 0.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 26.299999, 1520.099976),
        RotMatrix(-0.000000, 1.000000, 0.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1521.800049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000, 0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1521.80),
        RotMatrix(-0.000000, 0.000000, -1.000000, 1.000000,
            0.000000, 0.000000, 0.000000, -1.000000, -0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1525.300049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1525.199951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1528.699951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1532.199951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1535.599976),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1538.699951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1542.099976),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1545.300049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1548.699951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 26.299999, 1551.900024),
        RotMatrix(-0.000000, 1.000000, 0.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1535.400024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1531.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1528.699951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1538.800049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1541.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1545.300049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1548.500000),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.199951, 28.000000, 1550.199951),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 26.299999, 1551.800049),
        RotMatrix(-0.000000, 1.000000, 0.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2932.800049, 28.000000, 1550.099976),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2930.399902, 28.000000, 1551.099976),
        RotMatrix(1.000000, 0.000000, -0.000000, 0.000000,
            -0.000000, 1.000000, 0.000000, -1.000000, -0.000000), "ItemType" },
    { "cubewall", Vector(2930.600098, 28.000000, 1520.800049),
        RotMatrix(1.000000, 0.000000, -0.000000, 0.000000,
            -0.000000, 1.000000, 0.000000, -1.000000, -0.000000), "ItemType" },
    { "cubewall", Vector(2930.600098, 28.000000, 1549.599976),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -0.000000, 1.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2930.300049, 28.000000, 1522.300049),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -0.000000, 1.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2930.300049, 28.000000, 1523.800049),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -0.000000, 1.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2930.699951, 28.000000, 1548.099976),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -0.000000, 1.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2930.399902, 28.000000, 1546.800049),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -0.000000, 1.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2930.500000, 28.000000, 1525.300049),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -0.000000, 1.000000, -0.000000, 1.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.199951, 24.600000, 1521.900024),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.199951, 24.600000, 1550.099976),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 24.600000, 1550.099976),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 24.600000, 1521.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 24.600000, 1525.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.199951, 24.600000, 1525.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.199951, 24.600000, 1546.599976),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 24.600000, 1546.699951),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 24.600000, 1546.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.199951, 26.200001, 1526.300049),
        RotMatrix(0.000000, 1.000000, 0.000000, 0.000000,
            0.000000, -1.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 26.200001, 1526.300049),
        RotMatrix(0.000000, 1.000000, 0.000000, 0.000000,
            0.000000, -1.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2928.800049, 26.200001, 1545.500000),
        RotMatrix(0.000000, 1.000000, 0.000000, 0.000000,
            0.000000, -1.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2932.199951, 26.299999, 1545.599976),
        RotMatrix(0.000000, 1.000000, 0.000000, 0.000000,
            0.000000, -1.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(2932.899902, 24.799999, 1526.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(2932.899902, 24.799999, 1546.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "Table", Vector(2932.800049, 24.799999, 1521.199951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "ItemType" },
    { "Table", Vector(2932.899902, 24.8, 1550.599976),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "ItemType" },
    { "computer", Vector(2932.9, 25.500000, 1526.000000),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "ItemType" },
    { "computer", Vector(2932.899902, 25.500000, 1546.099976),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "ItemType" },
    { "Train", Vector(1801.500000, 80.099998, 1542.000000),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1801.400024, 80.000000, 1530.099976),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1813.300049, 80.000000, 1529.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1813.400024, 80.000000, 1541.800049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, 0.000000, -0.000000, 1.000000, 0.000000), "VehicleType" },
    { "cubewall", Vector(1233.699951, 24.799999, 1112.400024),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(1233.599976, 25.000000, 1119.599976),
        RotMatrix(-1.000000, -0.000000, 0.000000, 0.000000,
            -1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "ItemType" },
    { "cubewall", Vector(1528.400024, 25.000000, 1038.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1535.599976, 25.000000, 1038.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(2382.300049, 41.000000, 1207.599976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            -1.000000, 0.000000, 0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2382.600098, 41.000000, 1200.400024),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            -1.000000, 0.000000, 0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2158.500000, 57.000000, 1712.400024),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            -1.000000, 0.000000, 0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(2158.399902, 57.000000, 1719.599976),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            -1.000000, 0.000000, 0.000000, 0.000000, -1.000000), "ItemType" },
    { "cubewall", Vector(1832.400024, 41.000000, 1934.300049),
        RotMatrix(-0.000000, -0.000000, 1.000000, 0.000000,
            -1.000000, 0.000000, 1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1839.599976, 41.000000, 1934.400024),
        RotMatrix(-0.000000, -0.000000, 1.000000, 0.000000,
            -1.000000, 0.000000, 1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1080.400024, 25.000000, 2062.300049),
        RotMatrix(-0.000000, -0.000000, 1.000000, 0.000000,
            -1.000000, 0.000000, 1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1087.599976, 25.000000, 2062.300049),
        RotMatrix(-0.000000, -0.000000, 1.000000, 0.000000,
            -1.000000, 0.000000, 1.000000, 0.000000, 0.000000), "ItemType" },
    { "Train", Vector(1072.500000, 25.00000, 2065.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1824.500000, 41.099998, 1937.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "VehicleType" },
    { "Train", Vector(2161.399902, 57.099998, 1727.500000),
        RotMatrix(1.000000, 0.000000, -0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(2385.399902, 41.099998, 1215.500000),
        RotMatrix(1.000000, 0.000000, -0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(1520.500000, 25.000000, 1041.400024),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1230.599976, 25.00000, 1104.500000),
        RotMatrix(-1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, -0.000000, 0.000000, -1.000000), "VehicleType" },
    { "Train", Vector(1223.800049, 25.00000, 1120.699951),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1223.800049, 25.00001, 1120.800049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1536.800049, 25.00000, 1048.199951),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(1088.800049, 25.00000, 2072.199951),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(1840.800049, 41.200001, 1944.199951),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000),
        "VehicleType" },
    { "Train", Vector(2168.199951, 57.200001, 1711.199951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -0.000000),
        "VehicleType" },
    { "Train", Vector(2392.199951, 41.200001, 1199.199951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -0.000000),
        "VehicleType" },
    { "Train", Vector(2398.899902, 41.200001, 1206.199951),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(2175.000000, 57.200001, 1718.400024),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, 0.000000, 0.000000, 1.000000), "VehicleType" },
    { "Train", Vector(1833.699951, 41.200001, 1950.900024),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1081.800049, 25.00001, 2079.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1217.000000, 25.00001, 1113.699951),
        RotMatrix(-1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, -0.000000, 0.000000, -1.000000),
        "VehicleType" },
    { "Train", Vector(1529.699951, 25.00000, 1055.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1866.800049, 34.299999, 1039.000000),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.500000, 0.866025, 0.000000, -0.866025, 0.500000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1852.900024, 38.000000, 1039.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1891.699951, 20.000000, 1038.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.500000,
            0.866025, 0.000000, -0.866025, 0.500000, 0.000000), "VehicleType" },
    { "Train", Vector(1880.000000, 26.700001, 1039.000000),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.500000,
            0.866025, 0.000000, -0.866025, 0.500000, 0.000000), "VehicleType" },
    { "Train", Vector(1891.699951, 20.000000, 1038.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 0.500000,
            0.866025, 0.000000, -0.866025, 0.500000, 0.000000), "VehicleType" },
    { "Train", Vector(1853.500000, 36.000000, 1030.500000),
        RotMatrix(1.000000, 0.000000, 0.000000, 0.000000, 0.965926, -0.258819, 0.000000, 0.258819, 0.965926),
        "VehicleType" },
    { "Train", Vector(1853.199951, 33.900002, 1023.299988),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000, 1.000000, 0.000000, -1.000000, 0.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1839.000000, 34.299999, 1039.000000),
        RotMatrix(-0.000000, -0.000000, -1.000000, -0.500000,
            0.866025, 0.000000, 0.866025, 0.500000, -0.000000), "VehicleType" },
    { "Train", Vector(1825.300049, 26.400000, 1039.000000),
        RotMatrix(-0.000000, -0.000000, -1.000000, -0.500000,
            0.866025, 0.000000, 0.866025, 0.500000, -0.000000), "VehicleType" },
    { "Train", Vector(1037.500000, 28.100000, 1991.300049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000, 0.000000, 0.000000, -0.000000, 1.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1078.500000, 27.299999, 2033.900024),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000, 0.000000, 0.000000, -0.000000, 1.000000, 0.000000),
        "VehicleType" },
    { "Train", Vector(1080.599976, 27.500000, 1037.800049),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, -0.000000, 0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1037.599976, 27.100000, 1079.099976),
        RotMatrix(0.000000, -0.000000, 1.000000, 1.000000,
            0.000000, -0.000000, 0.000000, 1.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1816.000000, 142.000000, 1870.699951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "VehicleType" },
    { "Train", Vector(1800.000000, 142.000000, 1870.699951),
        RotMatrix(-0.000000, 0.000000, -1.000000, 0.000000,
            1.000000, 0.000000, 1.000000, 0.000000, -0.000000), "VehicleType" },
    { "Train", Vector(1816.000000, 142.000000, 1841.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1800.000000, 142.000000, 1841.300049),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "VehicleType" },
    { "Train", Vector(1525.300049, 142.000000, 1222.199951),
        RotMatrix(-0.866025, 0.000000, 0.500000, 0.000000,
            1.000000, 0.000000, -0.500000, 0.000000, -0.866025), "VehicleType" },
    { "Train", Vector(1521.500000, 142.000000, 1207.900024),
        RotMatrix(-1.000000, 0.000000, 0.000000, 0.000000,
            1.000000, 0.000000, -0.000000, 0.000000, -1.000000), "VehicleType" },
    { "cubewall", Vector(1212.199951, 25.000000, 1090.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 26.900000, 1090.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.799999, 1090.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.000000, 1086.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 26.900000, 1086.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.799999, 1086.50000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.000000, 1083.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 26.900000, 1083.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.799999, 1083.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.000000, 1079.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 26.900000, 1079.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.799999, 1079.500000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.000000, 1076.000000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 26.900000, 1076.0000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
    { "cubewall", Vector(1212.199951, 25.799999, 1076.000),
        RotMatrix(0.000000, 0.000000, 1.000000, 0.000000,
            1.000000, 0.000000, -1.000000, 0.000000, 0.000000), "ItemType" },
}

function LoadModdedMap()
    for _, mapDataPoint in ipairs(itemsData) do
        local item
        if mapDataPoint[4] == "VehicleType" then
            item = getVehicleType(mapDataPoint[1])
            local itemPart = vehicles.create(item, mapDataPoint[2], mapDataPoint[3], 0)
            itemPart.data.worldModPart = true
        elseif mapDataPoint[4] == "ItemType" then
            item = getItemType(mapDataPoint[1])
            local itemPart = items.create(item, mapDataPoint[2], mapDataPoint[3])
            itemPart.data.worldModPart = true
            itemPart.data.isComputer = mapDataPoint[1] == "computer"
        end
    end
end

plugin:addHook("Physics", function()
    for _, itm in ipairs(items.getAll()) do
        if itm.data.worldModPart then
            itm.hasPhysics = true
            itm.rigidBody.isSettled = true
            itm.rigidBody.vel:set(Vector())
            itm.rigidBody.rotVel:set(RotMatrix())
        end
    end

    for _, itm in ipairs(vehicles.getAll()) do
        if itm.data.worldModPart then
            itm.rigidBody.isSettled = true
            itm.rigidBody.vel:set(Vector())
            itm.rigidBody.rotVel:set(RotMatrix())
        end
    end
end)

--Prevents grabbing item
plugin:addHook("ItemLink", function(itm)
    if itm.data.worldModPart and not itm.data.isComputer then
        return hook.override
    end
end)

--Prevents item from despawning
plugin:addHook("ItemDelete", function(itm)
    if itm.data.worldModPart then
        return hook.override
    end
end)