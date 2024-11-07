local Framework = nil

if Config.Framework == 'ESX' then
    Framework = exports['es_extended']:getSharedObject()
elseif Config.Framework == 'QBCore' then
    Framework = exports['qb-core']:GetCoreObject()
end

-- Gestion de l'événement pour ouvrir un dépôt
RegisterNetEvent('stash:open')
AddEventHandler('stash:open', function(stashName)
    local xPlayer = nil
    if Config.Framework == 'ESX' then
        xPlayer = Framework.GetPlayerFromId(source)
    elseif Config.Framework == 'QBCore' then
        xPlayer = Framework.Functions.GetPlayer(source)
    end

    if not xPlayer then
        print("Joueur non trouvé.")
        return
    end

    local job, grade = nil, nil
    if Config.Framework == 'ESX' then
        job = xPlayer.job.name
        grade = xPlayer.job.grade
    elseif Config.Framework == 'QBCore' then
        job = xPlayer.PlayerData.job.name
        grade = xPlayer.PlayerData.job.grade.level
    end

    print("Job: " .. job .. " | Grade: " .. grade) -- Ajout de logs pour vérifier les données

    -- Vérification des permissions pour accéder au dépôt
    for _, stash in pairs(Config.Stashes) do
        if stash.name == stashName then
            if job == stash.job and grade >= stash.min_grade then
                -- Ouverture de l'inventaire de stash via ox_inventory
                exports.ox_inventory:RegisterStash(stash.name, stash.name, stash.size, stash.slots)
                TriggerClientEvent('ox_inventory:openInventory', source, 'stash', stash.name)
            else
                TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas la permission d'accéder à ce dépôt.")
            end
        end
    end
end)
