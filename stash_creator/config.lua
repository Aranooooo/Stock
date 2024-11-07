Config = {}

-- Choix du framework (ESX ou QBCore)
Config.Framework = 'ESX' -- ou 'QBCore'

-- Configuration des dépôts
    Config.Stashes = {
        {
            name = "coffre benny's",
            position = vector3(-195.0000, -1317.6550, 34.9897), -- Remplace par tes coordonnées
            job = "mechanic", -- Exemple de job requis
            min_grade = 0, -- Exemple de grade minimum requis
            size = 100, -- Taille de l'inventaire
            slots = 1000000, -- poids
        },
    
   -- }
   --     name = 'Ambulance Depot',
    --    job = 'ambulance',
   --     min_grade = 0,
    --    position = vector3(306.81, -601.27, 43.28),
    --    size = 100,
    --    slots = 50,
   -- },
    }
