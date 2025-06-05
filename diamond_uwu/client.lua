-- Optimized Client Script for Uwu Cats (Performance Target: 0.03ms)

local ESX = exports["es_extended"]:getSharedObject()
local cats = {}
local catSpawnPoints = {
    vector3(-582.435181, -1051.556030, 22.337769),
    vector3(-577.503296, -1060.443970, 22.337769),
    vector3(-583.701111, -1067.037354, 22.337769),
    vector3(-576.329651, -1054.905518, 22.421997),
    vector3(-582.791199, -1062.316528, 22.337769),
    vector3(-582.224182, -1056.079102, 22.421997)
}

local availableCatAnimations = {
    {dict = "amb@lo_res_idles@", anim = "creatures_world_cat_ground_sleep_lo_res_base"},
    {dict = "creatures@cat@move", anim = "dead_left"},

    -- Sleeping ground
    {dict = "creatures@cat@amb@world_cat_sleeping_ground@base", anim = "base"},
    {dict = "creatures@cat@amb@world_cat_sleeping_ground@enter", anim = "enter"},
    {dict = "creatures@cat@amb@world_cat_sleeping_ground@exit", anim = "exit"},
    {dict = "creatures@cat@amb@world_cat_sleeping_ground@idle_a", anim = "idle_a"},

    -- Sleeping ledge
    {dict = "creatures@cat@amb@world_cat_sleeping_ledge@base", anim = "base"},
    {dict = "creatures@cat@amb@world_cat_sleeping_ledge@exit", anim = "exit_l"},
    {dict = "creatures@cat@amb@world_cat_sleeping_ledge@exit", anim = "exit_r"},
    {dict = "creatures@cat@amb@world_cat_sleeping_ledge@idle_a", anim = "idle_a"},

    -- Movement & idle
    {dict = "creatures@cat@getup", anim = "getup_l"},
    {dict = "creatures@cat@move", anim = "canter"},
    {dict = "creatures@cat@move", anim = "canter_fwd_upp"},
    {dict = "creatures@cat@move", anim = "canter_turn_l"},
    {dict = "creatures@cat@move", anim = "canter_turn_r"},
    {dict = "creatures@cat@move", anim = "dead_left"},
    {dict = "creatures@cat@move", anim = "gallop"},
    {dict = "creatures@cat@move", anim = "gallop_fwd_dwn"},
    {dict = "creatures@cat@move", anim = "gallop_start_0_l"},
    {dict = "creatures@cat@move", anim = "gallop_start_180_r"},
    {dict = "creatures@cat@move", anim = "gallop_start_90_l"},
    {dict = "creatures@cat@move", anim = "gallop_turn_l"},
    {dict = "creatures@cat@move", anim = "gallop_turn_r"},
    {dict = "creatures@cat@move", anim = "idle_dwn"},
    {dict = "creatures@cat@move", anim = "idle_turn_r"},
    {dict = "creatures@cat@move", anim = "idle_upp"},
    {dict = "creatures@cat@move", anim = "walk"},
    {dict = "creatures@cat@move", anim = "walk_fwd_upp"},
    {dict = "creatures@cat@move", anim = "walk_start_0_l"},
    {dict = "creatures@cat@move", anim = "walk_start_0_r"},
    {dict = "creatures@cat@move", anim = "walk_start_180_l"},
    {dict = "creatures@cat@move", anim = "walk_start_180_r"},
    {dict = "creatures@cat@move", anim = "walk_turn_l"},
    {dict = "creatures@cat@move", anim = "walk_turn_r"},

    -- Steps and actions
    {dict = "creatures@cat@step", anim = "step_bwd"},
    {dict = "creatures@cat@step", anim = "step_fwd"},
    {dict = "creatures@cat@player_action@", anim = "action_a"}
}

local availableCatNames = { "Mochi", "Luna", "Whiskers", "Neko", "Tama", "Mia" }

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
end

local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
end

local function getUniqueCatName()
    if #availableCatNames == 0 then
        availableCatNames = { "Mochi", "Luna", "Whiskers", "Neko", "Tama", "Mia" }
    end
    local idx = math.random(1, #availableCatNames)
    return table.remove(availableCatNames, idx)
end

local function spawnCatAt(i)
    local catModel = `a_c_cat_01`
    local coords = catSpawnPoints[i]
    loadModel(catModel)

    local ped = CreatePed(28, catModel, coords.x, coords.y, coords.z, 0.0, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, false)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false)

    -- TaskWanderStandard removed to allow proper animation and targeting
    -- TaskWanderStandard(ped, 10.0, 10)

    cats[i] = {
        ped = ped,
        lastSeen = GetGameTimer(),
        name = getUniqueCatName()
    }

    exports.ox_target:addLocalEntity(ped, {
        {
            label = cats[i].name,
            icon = 'fas fa-cat',
            onSelect = function() end
        },
        {
            label = 'Pet the Cat',
            icon = 'fas fa-paw',
            onSelect = function()
                local playerPed = PlayerPedId()
                TaskTurnPedToFaceEntity(playerPed, ped, 1000)
                Wait(1000)

                loadAnimDict("anim@amb@business@weed@weed_inspecting_lo_med_hi@")
                TaskPlayAnim(playerPed, "anim@amb@business@weed@weed_inspecting_lo_med_hi@", "weed_stand_checkingleaves_kneeling_02_inspectorfemale", 8.0, -8.0, -1, 35, 0, false, false, false)

                local reaction = math.random(1, 3)
                if reaction == 1 then
                    loadAnimDict("creatures@cat@getup")
                    TaskPlayAnim(ped, "creatures@cat@getup", "getup_l", 8.0, -8.0, 2000, 0, 0, false, false, false)
                elseif reaction == 2 then
                    loadAnimDict("creatures@cat@step")
                    TaskPlayAnim(ped, "creatures@cat@step", "step_fwd", 8.0, -8.0, 1500, 0, 0, false, false, false)
                else
                    loadAnimDict("creatures@cat@amb@world_cat_sleeping_ground@exit")
                    TaskPlayAnim(ped, "creatures@cat@amb@world_cat_sleeping_ground@exit", "exit", 8.0, -8.0, 2000, 0, 0, false, false, false)
                end

                Wait(14000)
                ClearPedTasks(playerPed)
                TriggerServerEvent('hud:server:RelieveStress', 2)
            end
        }
    })
end

-- Cat management loop (spawn/despawn)
CreateThread(function()
    while true do
        Wait(5000) -- Every 5 seconds
        local playerCoords = GetEntityCoords(PlayerPedId())

        for i, spawnPos in ipairs(catSpawnPoints) do
            local cat = cats[i]
            local dist = #(playerCoords - spawnPos)

            if dist < 30.0 then
                if not cat or not DoesEntityExist(cat.ped) then
                    spawnCatAt(i)
                else
                    cats[i].lastSeen = GetGameTimer()
                end
            elseif cat and DoesEntityExist(cat.ped) and GetGameTimer() - cat.lastSeen > 60000 then
                DeleteEntity(cat.ped)
                cats[i] = nil
            end
        end
    end
end)

-- Global behavior thread for all cats
CreateThread(function()
    while true do
        Wait(math.random(10000, 15000))
        for i, cat in pairs(cats) do
            if cat.ped and DoesEntityExist(cat.ped) then
                ClearPedTasks(cat.ped)
                local dest = catSpawnPoints[math.random(1, #catSpawnPoints)]
                TaskGoStraightToCoord(cat.ped, dest.x, dest.y, dest.z, 1.0, -1, 0.0, 0.0)
                Wait(1000)
                local anim = availableCatAnimations[math.random(1, #availableCatAnimations)]
                loadAnimDict(anim.dict)
                TaskPlayAnim(cat.ped, anim.dict, anim.anim, 8.0, -8.0, math.random(3000, 5000), 1, 0, false, false, false)
            end
        end
    end
end)
-- {END OF CAT LOGIC} --   

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

-- Refresh EntityZones for the cars/tow trucks & Draw Blips
Citizen.CreateThread(function()

if Config.EnableBlip then
		blip = AddBlipForCoord(-588.5400, -1067.1752, 22.3442)
		SetBlipSprite(blip, 106)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Uwu")
		EndTextCommandSetBlipName(blip)
end   

    exports.ox_target:addBoxZone({
        coords = vec3(-596.11, -1052.67, 22.55),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'BossMenu',
                event = "diamond_uwu:openBossMenu",
                icon = 'fas fa-users',
                label = "Open Boss Menu",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

    exports.ox_target:addBoxZone({
        coords = vec3(-587.97, -1058.99, 22.36),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = '1',
                event = "diamond_uwu:makeUwu1",
                icon = "fas fa-hamburger",
                label = "Uwu combo meal 1",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = '2',
                event = "diamond_uwu:makeUwu2",
                icon = "fas fa-hamburger",
                label = "Uwu combo meal 2",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = '3',
                event = "diamond_uwu:makeUwu3",
                icon = "fas fa-hamburger",
                label = "Uwu combo meal 3",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = '4',
                event = "diamond_uwu:makeUwu4",
                icon = "fas fa-hamburger",
                label = "Uwu combo meal 4",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

	-- Cash Register
    exports.ox_target:addBoxZone({
        coords = vec3(-584.20, -1058.76, 22.54),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'bill',
                event = "billing_ui:openBillingMenu", -- change to whatever billing trigger you have
                icon = "fas fa-clipboard",
                label = "Interact",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

    exports.ox_target:addBoxZone({
        coords = vec3(-584.16, -1061.41, 22.44),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'bill2',
                event = "billing_ui:openBillingMenu", -- change to whatever billing trigger you have
                icon = "fas fa-clipboard",
                label = "Interact",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

-- Storage Freezer
    exports.ox_target:addBoxZone({
        coords = vec3(-588.07, -1067.76, 22.94),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'boba',
                event = "diamond_uwu:grabBoba",
                icon = "fas fa-hand-paper",
                label = "Grab Boba Tea Ingredients",
                groups = {"uwu"},
                distance = 0.8
            },        	
            {
                name = 'cookie',
                event = "diamond_uwu:grabCookie",
                icon = "fas fa-hand-paper",
                label = "Grab Cookie Ingredients",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'cupcake',
                event = "diamond_uwu:grabCupcake",
                icon = "fas fa-hand-paper",
                label = "Grab Cupcake Ingredients",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'eggroll',
                event = "diamond_uwu:grabEggroll",
                icon = "fas fa-hand-paper",
                label = "Grab Egroll Ingredients",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'salad',
                event = "diamond_uwu:grabSalad",
                icon = "fas fa-hand-paper",
                label = "Grab Coleslaw Ingredients",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'sushi',
                event = "diamond_uwu:grabSushi",
                icon = "fas fa-hand-paper",
                label = "Grab Sushi Ingredients",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'pork',
                event = "diamond_uwu:grabPork",
                icon = "fas fa-hand-paper",
                label = "Grab a Ground Pork",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

-- Frier
    exports.ox_target:addBoxZone({
        coords = vec3(-590.89, -1056.47, 22.36),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'eggroll',
                event = "diamond_uwu:makeEggrolls",
                icon = "fas fa-temperature-high",
                label = "Fry Egg Rolls",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'pork',
                event = "diamond_uwu:cookPork",
                icon = "fas fa-temperature-high",
                label = "Cook the ground pork",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

    
    --Prep Station
    exports.ox_target:addBoxZone({
        coords = vec3(-590.99, -1063.05, 22.36),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'cookies',
                event = "diamond_uwu:prepareCookie",
                icon = "fas fa-hamburger",
                label = "Prepare Cookies",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'cupcakes',
                event = "diamond_uwu:prepareCupcake",
                icon = "fas fa-hamburger",
                label = "Prepare Cupcakes",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'coleslaw',
                event = "diamond_uwu:prepareColseLaw",
                icon = "fas fa-hamburger",
                label = "Prepare Coleslaw Salad",
                groups = {"uwu"},
                distance = 0.8
            },
            {
                name = 'sushi',
                event = "diamond_uwu:prepareSushi",
                icon = "fas fa-hamburger",
                label = "Prepare Sushi",
                groups = {"uwu"},
                distance = 0.8
            },
        }
    })

    exports.ox_target:addBoxZone({
        coords = vec3(-586.83, -1061.93, 22.54),
        size = vec3(1, 1, 1),
        rotation = 45,
        debug = drawZones,
        options = {
            {
                name = 'DrinkMachineBS',
                event = "diamond_uwu:grabDrink",
                icon = "fab fa-gulp",
                label = "Make Bubble teas",
                groups = {"uwu"},
                distance = 0.8,
            },
        }
    })
end)


                -- INGEREDIENTS --
                -- Grab Boba Ingredients --
RegisterNetEvent('diamond_uwu:grabBoba')
AddEventHandler('diamond_uwu:grabBoba',function()
    TriggerServerEvent('diamond_uwu:addItem', 'black_pearls')
    TriggerServerEvent('diamond_uwu:addItem', 'sugar')
    TriggerServerEvent('diamond_uwu:addItem', 'tea_powder')
    TriggerServerEvent('diamond_uwu:addItem', 'vanilla_essence')
    TriggerServerEvent('diamond_uwu:addItem', 'water')
    TriggerServerEvent('diamond_uwu:addItem', 'milk')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.BobaPrice)
    exports['mythic_notify']:SendAlert('success', "For the Boba Ingredients, Uwu paid $" .. Config.BobaPrice, 3500)
end)

                -- Grab Cookie ingredients --
RegisterNetEvent('diamond_uwu:grabCookie')
AddEventHandler('diamond_uwu:grabCookie',function()
    TriggerServerEvent('diamond_uwu:addItem', 'butter')
    TriggerServerEvent('diamond_uwu:addItem', 'eggs')
    TriggerServerEvent('diamond_uwu:addItem', 'vanilla_essence')
    TriggerServerEvent('diamond_uwu:addItem', 'baking_soda')
    TriggerServerEvent('diamond_uwu:addItem', 'water')
    TriggerServerEvent('diamond_uwu:addItem', 'salt')
    TriggerServerEvent('diamond_uwu:addItem', 'flour')
    TriggerServerEvent('diamond_uwu:addItem', 'chocolate_chips')
    TriggerServerEvent('diamond_uwu:addItem', 'nuts')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.CookiePrice)
    exports['mythic_notify']:SendAlert('success', "For the Cookie Ingredients, Uwu paid $" .. Config.CookiePrice, 3500)
end)

                -- Grab Cupcake Ingredients --
RegisterNetEvent('diamond_uwu:grabCupcake')
AddEventHandler('diamond_uwu:grabCupcake',function()
    TriggerServerEvent('diamond_uwu:addItem', 'cocoa_powder')
    TriggerServerEvent('diamond_uwu:addItem', 'flour')
    TriggerServerEvent('diamond_uwu:addItem', 'sugar')
    TriggerServerEvent('diamond_uwu:addItem', 'butter')
    TriggerServerEvent('diamond_uwu:addItem', 'vanilla_essence')
    TriggerServerEvent('diamond_uwu:addItem', 'eggs')
    TriggerServerEvent('diamond_uwu:addItem', 'milk')
    TriggerServerEvent('diamond_uwu:addItem', 'salt')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.CupCakePrice)
    exports['mythic_notify']:SendAlert('success', "For the Cupcake Ingredients, Uwu paid $" .. Config.CupCakePrice, 3500)
end)

                -- Grab Egroll Ingredients --
RegisterNetEvent('diamond_uwu:grabEggroll')
AddEventHandler('diamond_uwu:grabEggroll',function()
    TriggerServerEvent('diamond_uwu:addItem', 'eggs')
    TriggerServerEvent('diamond_uwu:addItem', 'ginger')
    TriggerServerEvent('diamond_uwu:addItem', 'garlic_powder')
    TriggerServerEvent('diamond_uwu:addItem', 'cabbage')
    TriggerServerEvent('diamond_uwu:addItem', 'carrots')
    TriggerServerEvent('diamond_uwu:addItem', 'soy_sauce')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.EggrollPrice)
    exports['mythic_notify']:SendAlert('success', "For the Egroll Ingredients, Uwu paid $" .. Config.EggrollPrice, 3500)
    exports['mythic_notify']:SendAlert('inform', "Make sure that you grab a ground prok and cook it!", 3500)
end)

                -- Grab Salad Ingredients --
RegisterNetEvent('diamond_uwu:grabSalad')
AddEventHandler('diamond_uwu:grabSalad',function()
    TriggerServerEvent('diamond_uwu:addItem', 'coleslaw_mix')
    TriggerServerEvent('diamond_uwu:addItem', 'mayonnaise')
    TriggerServerEvent('diamond_uwu:addItem', 'apple_cider')
    TriggerServerEvent('diamond_uwu:addItem', 'honey')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.SaladPrice)
    exports['mythic_notify']:SendAlert('success', "For the Coleslaw Ingredients, Uwu paid $" .. Config.SaladPrice, 3500)
end)

                -- Grab Sushi Ingredients --
RegisterNetEvent('diamond_uwu:grabSushi')
AddEventHandler('diamond_uwu:grabSushi',function()
    TriggerServerEvent('diamond_uwu:addItem', 'water')
    TriggerServerEvent('diamond_uwu:addItem', 'white_rice')
    TriggerServerEvent('diamond_uwu:addItem', 'rice_vinegar')
    TriggerServerEvent('diamond_uwu:addItem', 'sugar')
    TriggerServerEvent('diamond_uwu:addItem', 'salt')
    TriggerServerEvent('diamond_uwu:addItem', 'nori')
    TriggerServerEvent('diamond_uwu:addItem', 'premade_crabmeat')
    TriggerServerEvent('diamond_uwu:addItem', 'cucumber')
    TriggerServerEvent('diamond_uwu:addItem', 'avocado')
    TriggerServerEvent('diamond_uwu:addItem', 'ginger')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.SushiPrice)
    exports['mythic_notify']:SendAlert('success', "For the Sushi Ingredients, Uwu paid $" .. Config.SushiPrice, 3500)
end)

                -- Grab Ground Pork --
RegisterNetEvent('diamond_uwu:grabPork')
AddEventHandler('diamond_uwu:grabPork',function()
    TriggerServerEvent('diamond_uwu:addItem', 'ground_pork')
    TriggerServerEvent('diamond_uwu:chargeSociety',Config.GroundPorkPrice)
    exports['mythic_notify']:SendAlert('success', "For the Ground Pork, Uwu paid $" .. Config.GroundPorkPrice, 3500)
end)

                                -- Grab a Drink --
                -- Make Bubble Tea --
                RegisterNetEvent('diamond_uwu:grabDrink')
                AddEventHandler('diamond_uwu:grabDrink', function()
                    -- Define required ingredients for making bubble tea
                    local requiredIngredients = Config.Recipes['uwu_btea'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = bobaAnim("Making Boba Tea", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_btea')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_btea')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)


                --[[ MEALS]]

                -- Make Uwu Combo Meal 1 --
                RegisterNetEvent('diamond_uwu:makeUwu1')
                AddEventHandler('diamond_uwu:makeUwu1', function()
                    -- Define required ingredients for Uwu1 combo
                    local requiredIngredients = Config.Recipes['uwu1'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = packAnim("Packing Uwu Combo Meal 1", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu1')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu1')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)


                -- Make Uwu Combo Meal 2 --
                RegisterNetEvent('diamond_uwu:makeUwu2')
                AddEventHandler('diamond_uwu:makeUwu2', function()
                    -- Define required ingredients for Uwu2 combo
                    local requiredIngredients = Config.Recipes['uwu2'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end
                    
                    local success = packAnim("Packing Uwu Combo Meal 2", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu2')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu2')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)


                -- Make Uwu Combo Meal 3 --
                RegisterNetEvent('diamond_uwu:makeUwu3')
                AddEventHandler('diamond_uwu:makeUwu3', function()
                    -- Define required ingredients for Uwu3 combo
                    local requiredIngredients = Config.Recipes['uwu3'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end
                    
                    local success = packAnim("Packing Uwu Combo Meal 3", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu3')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu3')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)


                -- Make Uwu Combo Meal 4 --
                RegisterNetEvent('diamond_uwu:makeUwu4')
                AddEventHandler('diamond_uwu:makeUwu4', function()
                    -- Define required ingredients for Uwu4 combo
                    local requiredIngredients = Config.Recipes['uwu4'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = packAnim("Packing Uwu Combo Meal 4", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu4')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu4')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)



                --[[ END MEALS ]]

                -- Make Bubble Tea --
                RegisterNetEvent('diamond_uwu:prepareUwububbles')
                AddEventHandler('diamond_uwu:prepareUwububbles', function()
                    -- Define required ingredients for Bubble Tea
                    local requiredIngredients = Config.Recipes['uwu_btea'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = prepAnim("Prepairing Boba Tea", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_btea')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_btea')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)


                -- Make Cookie --
                RegisterNetEvent('diamond_uwu:prepareCookie')
                AddEventHandler('diamond_uwu:prepareCookie', function()
                    -- Define required ingredients for Cookie
                    local requiredIngredients = Config.Recipes['uwu_cookie'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = prepAnim("Prepairing Cookies", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_cookie')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_cookie')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)



                -- Make Cupcake --
                RegisterNetEvent('diamond_uwu:prepareCupcake')
                AddEventHandler('diamond_uwu:prepareCupcake', function()
                    -- Define required ingredients for Cupcake
                    local requiredIngredients = Config.Recipes['uwu_cupcake'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = prepAnim("Prepairing Cupcakes", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_cupcake')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_cupcake')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)



                -- Make Coleslaw --
                RegisterNetEvent('diamond_uwu:prepareColeslaw')
                AddEventHandler('diamond_uwu:prepareColeslaw', function()
                    -- Define required ingredients for Coleslaw
                    local requiredIngredients = Config.Recipes['uwu_coleslaw_salad'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = prepAnim("Prepairing Coleslaw", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_coleslaw_salad')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_coleslaw_salad')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)



                -- Make Sushi --
                RegisterNetEvent('diamond_uwu:prepareSushi')
                AddEventHandler('diamond_uwu:prepareSushi', function()
                    -- Define required ingredients for Sushi
                    local requiredIngredients = Config.Recipes['uwu_sushi'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = prepAnim("Prepairing Sushi", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_sushi')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_sushi')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)

                -- Cook Ground Pork --
                RegisterNetEvent('diamond_uwu:cookPork')
                AddEventHandler('diamond_uwu:cookPork', function()
                    -- Define required ingredients for cooking ground pork
                    local requiredIngredients = Config.Recipes['cooked_ground_pork'].Ingredients
                
                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end
                
                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end
                
                    local success = cookAnim("Cooking Ground Pork", 10000) -- Animation. Change in shared.lua
                
                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end
                
                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'cooked_ground_pork')
                
                        -- Notify server of successful craft (optional, based on your setup)
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'cooked_ground_pork')
                
                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)

                -- Make Eggrolls --
                RegisterNetEvent('diamond_uwu:makeEggrolls')
                AddEventHandler('diamond_uwu:makeEggrolls', function()
                    -- Define required ingredients for Eggrolls
                    local requiredIngredients = Config.Recipes['uwu_eggroll'].Ingredients

                    -- Check if the player has all required ingredients
                    local missingIngredients = {}
                    for ingredient, amount in pairs(requiredIngredients) do
                        local playerAmount = exports['ox_inventory']:Search('count', ingredient)
                        if playerAmount < amount then
                            table.insert(missingIngredients, ingredient)
                        end
                    end

                    if #missingIngredients > 0 then
                        local missingStr = table.concat(missingIngredients, ", ")
                        exports['mythic_notify']:SendAlert('error', "You're missing: " .. missingStr, 3500)
                        return
                    end

                    local success = cookAnim("Cooking Eggrolls", 10000) -- Animation. Change in shared.lua

                    if success then
                        -- Remove ingredients
                        for ingredient, amount in pairs(requiredIngredients) do
                            TriggerServerEvent('diamond_uwu:removeItem', ingredient, amount)
                        end

                        -- Add crafted item
                        TriggerServerEvent('diamond_uwu:addItem', 'uwu_eggroll')

                        -- Notify server of successful craft
                        TriggerServerEvent('diamond_uwu:checkCanCraft', 'uwu_eggroll')

                        ClearPedTasks(PlayerPedId())
                        Wait(2000)
                    end
                end)

-- Open Boss Menu
RegisterNetEvent('diamond_uwu:openBossMenu')
AddEventHandler('diamond_uwu:openBossMenu',function()
	TriggerEvent('esx_society:openBossMenu', 'uwu', function(data, menu)
		menu.close()
	end)
end)



