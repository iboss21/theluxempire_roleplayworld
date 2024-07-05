Config = {}

Config.Debug = false
Config.UseOxInventory = false -- Set to true if using ox_inventory

Config.Activities = {
    Lumberjacking = {
        enabled = true,
        locations = {
            {coords = vector3(100.0, 100.0, 30.0), radius = 50.0, trees = 50},
            {coords = vector3(-500.0, 1500.0, 50.0), radius = 75.0, trees = 75},
        },
        trees = {
            {model = `prop_tree_pine_02`, woodYield = {min = 1, max = 3}, xp = 5},
            {model = `prop_tree_oak_01`, woodYield = {min = 2, max = 4}, xp = 7},
            {model = `prop_palm_huge_01`, woodYield = {min = 3, max = 5}, xp = 10},
        },
        tools = {
            {name = "basic_axe", efficiency = 1.0},
            {name = "steel_axe", efficiency = 1.5},
            {name = "diamond_axe", efficiency = 2.0},
        },
    },
    Mining = {
        enabled = true,
        locations = {
            {coords = vector3(200.0, 200.0, 40.0), radius = 30.0, nodes = 30},
            {coords = vector3(2000.0, -2000.0, 20.0), radius = 50.0, nodes = 50},
        },
        ores = {
            {name = "iron_ore", chance = 50, yield = {min = 1, max = 3}, xp = 5},
            {name = "gold_ore", chance = 30, yield = {min = 1, max = 2}, xp = 10},
            {name = "diamond", chance = 10, yield = {min = 1, max = 1}, xp = 20},
            {name = "uranium", chance = 5, yield = {min = 1, max = 1}, xp = 30},
        },
        tools = {
            {name = "basic_pickaxe", efficiency = 1.0},
            {name = "steel_pickaxe", efficiency = 1.5},
            {name = "diamond_pickaxe", efficiency = 2.0},
        },
    },
    Hunting = {
        enabled = true,
        locations = {
            {coords = vector3(1000.0, 1000.0, 50.0), radius = 100.0},
            {coords = vector3(-1500.0, -1500.0, 30.0), radius = 150.0},
        },
        animals = {
            {model = `a_c_deer`, lootTable = "deer_loot", xp = 10},
            {model = `a_c_boar`, lootTable = "boar_loot", xp = 15},
            {model = `a_c_mtlion`, lootTable = "mountainlion_loot", xp = 25},
        },
        weapons = {
            {name = "WEAPON_BOW", efficiency = 1.5},
            {name = "WEAPON_MUSKET", efficiency = 1.2},
        },
    },
    Fishing = {
        enabled = true,
        locations = {
            {coords = vector3(500.0, -500.0, 5.0), radius = 20.0, type = "lake"},
            {coords = vector3(-2000.0, 1000.0, 0.0), radius = 50.0, type = "ocean"},
        },
        fish = {
            {name = "common_fish", chance = 50, xp = 5},
            {name = "rare_fish", chance = 30, xp = 10},
            {name = "exotic_fish", chance = 15, xp = 20},
            {name = "legendary_fish", chance = 5, xp = 50},
        },
        tools = {
            {name = "basic_fishingrod", efficiency = 1.0},
            {name = "pro_fishingrod", efficiency = 1.5},
        },
    },
    Foraging = {
        enabled = true,
        locations = {
            {coords = vector3(300.0, 300.0, 20.0), radius = 30.0, type = "forest"},
            {coords = vector3(-300.0, 700.0, 10.0), radius = 25.0, type = "beach"},
        },
        items = {
            {name = "berry", chance = 40, xp = 3},
            {name = "mushroom", chance = 30, xp = 5},
            {name = "herb", chance = 20, xp = 7},
            {name = "truffle", chance = 10, xp = 15},
        },
    },
}

Config.ProcessingLocations = {
    WoodProcessor = {coords = vector3(300.0, 300.0, 50.0), radius = 2.0},
    OreSmelter = {coords = vector3(400.0, 400.0, 60.0), radius = 2.0},
    MeatProcessor = {coords = vector3(500.0, 500.0, 70.0), radius = 2.0},
    FishProcessor = {coords = vector3(600.0, 600.0, 80.0), radius = 2.0},
}

Config.Items = {
    -- Resources
    wood = {label = "Wood", weight = 1, stack = true, close = false},
    iron_ore = {label = "Iron Ore", weight = 2, stack = true, close = false},
    gold_ore = {label = "Gold Ore", weight = 2, stack = true, close = false},
    diamond = {label = "Diamond", weight = 1, stack = true, close = false},
    uranium = {label = "Uranium", weight = 5, stack = true, close = false},
    deer_pelt = {label = "Deer Pelt", weight = 3, stack = true, close = false},
    boar_tusk = {label = "Boar Tusk", weight = 1, stack = true, close = false},
    lion_fang = {label = "Mountain Lion Fang", weight = 1, stack = true, close = false},
    common_fish = {label = "Common Fish", weight = 1, stack = true, close = false},
    rare_fish = {label = "Rare Fish", weight = 2, stack = true, close = false},
    exotic_fish = {label = "Exotic Fish", weight = 3, stack = true, close = false},
    legendary_fish = {label = "Legendary Fish", weight = 5, stack = true, close = false},
    berry = {label = "Berry", weight = 0.1, stack = true, close = false},
    mushroom = {label = "Mushroom", weight = 0.2, stack = true, close = false},
    herb = {label = "Herb", weight = 0.1, stack = true, close = false},
    truffle = {label = "Truffle", weight = 0.5, stack = true, close = false},

    -- Processed Items
    wooden_planks = {label = "Wooden Planks", weight = 2, stack = true, close = false},
    iron_ingot = {label = "Iron Ingot", weight = 3, stack = true, close = false},
    gold_ingot = {label = "Gold Ingot", weight = 3, stack = true, close = false},
    cut_diamond = {label = "Cut Diamond", weight = 1, stack = true, close = false},
    enriched_uranium = {label = "Enriched Uranium", weight = 7, stack = true, close = false},
    leather = {label = "Leather", weight = 2, stack = true, close = false},
    jerky = {label = "Jerky", weight = 1, stack = true, close = false},
    canned_fish = {label = "Canned Fish", weight = 1, stack = true, close = false},
    medicine = {label = "Medicine", weight = 0.5, stack = true, close = false},

    -- Tools
    basic_axe = {label = "Basic Axe", weight = 5, stack = false, close = false},
    steel_axe = {label = "Steel Axe", weight = 7, stack = false, close = false},
    diamond_axe = {label = "Diamond Axe", weight = 6, stack = false, close = false},
    basic_pickaxe = {label = "Basic Pickaxe", weight = 5, stack = false, close = false},
    steel_pickaxe = {label = "Steel Pickaxe", weight = 7, stack = false, close = false},
    diamond_pickaxe = {label = "Diamond Pickaxe", weight = 6, stack = false, close = false},
    basic_fishingrod = {label = "Basic Fishing Rod", weight = 3, stack = false, close = false},
    pro_fishingrod = {label = "Pro Fishing Rod", weight = 4, stack = false, close = false},
}

Config.Crafting = {
    WoodenPlanks = {
        items = {wood = 4},
        result = {item = "wooden_planks", amount = 1},
        time = 5000,
        requiredSkill = {name = "lumberjacking", level = 1}
    },
    IronIngot = {
        items = {iron_ore = 3},
        result = {item = "iron_ingot", amount = 1},
        time = 8000,
        requiredSkill = {name = "mining", level = 5}
    },
    GoldIngot = {
        items = {gold_ore = 2},
        result = {item = "gold_ingot", amount = 1},
        time = 10000,
        requiredSkill = {name = "mining", level = 10}
    },
    CutDiamond = {
        items = {diamond = 1},
        result = {item = "cut_diamond", amount = 1},
        time = 15000,
        requiredSkill = {name = "mining", level = 20}
    },
    EnrichedUranium = {
        items = {uranium = 2},
        result = {item = "enriched_uranium", amount = 1},
        time = 30000,
        requiredSkill = {name = "mining", level = 50}
    },
    Leather = {
        items = {deer_pelt = 2},
        result = {item = "leather", amount = 1},
        time = 7000,
        requiredSkill = {name = "hunting", level = 5}
    },
    Jerky = {
        items = {boar_tusk = 1},
        result = {item = "jerky", amount = 2},
        time = 6000,
        requiredSkill = {name = "hunting", level = 10}
    },
    CannedFish = {
        items = {common_fish = 2},
        result = {item = "canned_fish", amount = 1},
        time = 5000,
        requiredSkill = {name = "fishing", level = 5}
    },
    Medicine = {
        items = {herb = 3, mushroom = 2},
        result = {item = "medicine", amount = 1},
        time = 10000,
        requiredSkill = {name = "foraging", level = 15}
    },
    SteelAxe = {
        items = {iron_ingot = 3, wooden_planks = 2},
        result = {item = "steel_axe", amount = 1},
        time = 15000,
        requiredSkill = {name = "crafting", level = 10}
    },
    DiamondPickaxe = {
        items = {cut_diamond = 2, iron_ingot = 3, wooden_planks = 1},
        result = {item = "diamond_pickaxe", amount = 1},
        time = 20000,
        requiredSkill = {name = "crafting", level = 25}
    },
}

Config.Skills = {
    lumberjacking = {maxLevel = 100, xpPerLevel = 1000},
    mining = {maxLevel = 100, xpPerLevel = 1000},
    hunting = {maxLevel = 100, xpPerLevel = 1000},
    fishing = {maxLevel = 100, xpPerLevel = 1000},
    foraging = {maxLevel = 100, xpPerLevel = 1000},
    crafting = {maxLevel = 100, xpPerLevel = 1500},
}

Config.Market = {
    locations = {
        {coords = vector3(1000.0, -1000.0, 30.0), name = "City Market"},
        {coords = vector3(-1500.0, 1500.0, 20.0), name = "Rural Market"},
    },
    updateInterval = 3600, -- Market prices update every hour (in seconds)
    priceFluctuation = 0.2, -- 20% max price fluctuation
}

Config.Events = {
    GoldRush = {
        duration = 1800, -- 30 minutes
        cooldown = 14400, -- 4 hours
        bonus = {
            mining = 2.0, -- Double mining yield and XP
        }
    },
    HuntingFrenzy = {
        duration = 1200, -- 20 minutes
        cooldown = 10800, -- 3 hours
        bonus = {
            hunting = 1.5, -- 50% increase in hunting yield and XP
        }
    },
    FishingTournament = {
        duration = 3600, -- 1 hour
        cooldown = 86400, -- 24 hours
        bonus = {
            fishing = 2.0, -- Double fishing XP
        }
    },
}

return Config
