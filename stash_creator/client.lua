local Framework = nil

-- Initialisation du framework choisi dans config.lua
if Config.Framework == 'ESX' then
    Framework = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'QBCore' then
    Framework = exports['qb-core']:GetCoreObject()
end

Citizen.CreateThread(function()
    Wait(250) -- Attente pour s'assurer que tout est chargé

    for _, stash in pairs(Config.Stashes) do
        -- Utilisation de ox_target pour ajouter des zones interactives
        exports.ox_target:addSphereZone({
            coords = stash.position,
            radius = 1.0, -- Taille de la zone d'interaction
            debug = false,
            options = {
                {
                    name = 'open_stash_' .. stash.name,
                    icon = 'fas fa-box-open',
                    label = 'Ouvrir ' .. stash.name,
                    onSelect = function()
                        local job, grade = nil, nil
                        if Config.Framework == 'ESX' then
                            job = Framework.PlayerData.job.name
                            grade = Framework.PlayerData.job.grade
                        elseif Config.Framework == 'QBCore' then
                            job = Framework.Functions.GetPlayerData().job.name
                            grade = Framework.Functions.GetPlayerData().job.grade.level
                        end
                        -- Vérification des conditions
                        if job == stash.job and grade >= stash.min_grade then
                            -- Ouverture de l'inventaire du stash
                            TriggerServerEvent('stash:open', stash.name)
                        else
                            Framework.ShowNotification("Vous n'avez pas la permission d'accéder à ce dépôt.")
                        end
                    end,
                }
            }
        })
    end
end)
