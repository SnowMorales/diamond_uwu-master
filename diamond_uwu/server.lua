ESX = nil
local OrderTotal = 0 

--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('esx_society:registerSociety', 'uwu', 'Uwu', 'society_uwu', 'society_uwu', 'society_uwu', {type = 'public'})


RegisterServerEvent('diamond_uwu:checkCanCraft')
AddEventHandler('diamond_uwu:checkCanCraft',function(item)
   	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local craft = true
    local count = Config.Recipes[item].Amount
    local stack = 1

        for k, v in pairs(Config.Recipes[item].Ingredients) do
            if xPlayer.getInventoryItem(k).count < v then
            	craft = false                
                return
            end
        end        

			if craft then
                for k, v in pairs(Config.Recipes[item].Ingredients) do
                	xPlayer.removeInventoryItem(k, v)
                end
	            --TriggerClientEvent('diamond_uwu:cookAnimation',source,Config.Recipes[item].Animation)
	            --Wait(10000)
	            xPlayer.addInventoryItem(item,5)
            end
end)

-- Remove item from inventory
RegisterServerEvent('diamond_uwu:removeItem')
AddEventHandler('diamond_uwu:removeItem',function(item, amount)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item,amount)

end)

RegisterServerEvent('diamond_uwu:addItem')
AddEventHandler('diamond_uwu:addItem', function(item)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    -- Add the item (e.g., iced_mocha) with a quantity of 5
    xPlayer.addInventoryItem(item, 5)
end)

-- Charge Society for items
RegisterServerEvent('diamond_uwu:chargeSociety')
AddEventHandler('diamond_uwu:chargeSociety', function(amount)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_uwu', function(account)
        account.removeMoney(amount)
    end)	
end)

ESX.RegisterUsableItem('uwu1', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('uwu1', 1)
    xPlayer.addInventoryItem('uwu_btea',2)    
    xPlayer.addInventoryItem('uwu_cookie',5)
    xPlayer.addInventoryItem('uwu_cupcake',3)
    xPlayer.addInventoryItem('paperbag',1)
end)

ESX.RegisterUsableItem('uwu2', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('uwu2', 1)
    xPlayer.addInventoryItem('uwu_btea',2)    
    xPlayer.addInventoryItem('uwu_cookie',5)
    xPlayer.addInventoryItem('uwu_eggroll',2)
    xPlayer.addInventoryItem('paperbag',1)
end)

ESX.RegisterUsableItem('uwu3', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('uwu3', 1)
    xPlayer.addInventoryItem('uwu_btea',2)
    xPlayer.addInventoryItem('uwu_cookie',5)
    xPlayer.addInventoryItem('uwu_coleslaw_salad',2)
    xPlayer.addInventoryItem('paperbag',1)
end)

ESX.RegisterUsableItem('uwu4', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('uwu4', 1)
    xPlayer.addInventoryItem('uwu_btea',2)
    xPlayer.addInventoryItem('uwu_cookie',5)
    xPlayer.addInventoryItem('uwu_sushi',6)
    xPlayer.addInventoryItem('paperbag',1)
end)