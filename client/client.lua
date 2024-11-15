QBCore = exports['qb-core']:GetCoreObject()
local config = require 'config.shared'
local keybind = lib.addKeybind({
    name = 'playermenu',
    description = 'press F4 to open player menu',
    defaultKey = 'F4',
    onReleased = function(self)
        OpenMenu()
    end
})
RegisterNetEvent('nov:client:openplayermenu', function()
    OpenMenu()
end)

function OpenMenu()
    local options = {
        {
            title = 'No Clip',
            description = 'Toggle NoClip',
            icon = "fa-solid fa-person",
            onSelect = function()
                ExecuteCommand('noclip')
            end
        },
        {
            title = 'Revive',
            description = 'Revive YourSelf',
            icon = "fa-solid fa-heart",
            onSelect = function()
                ExecuteCommand('revive')
            end
        },
        {
            title = 'Kill',
            description = 'Kill Yourself',
            icon = "fa-solid fa-skull",
            onSelect = function()
                SetEntityHealth(cache.ped, 0)
            end
        },
        {
            title = 'Clothing',
            description = 'Give ClothingMenu',
            icon = "fa-solid fa-shirt",
            onSelect = function()
                ExecuteCommand('pedmenu')
            end
        },
        {
            title = 'Weather',
            description = 'Open Weather Menu',
            icon = "fa-solid fa-cloud",
            onSelect = function()
                OpenWeatherCategory()
            end
        },
        {
            title = 'Teleport to Marker',
            description = 'Teleport',
            icon = "fa-solid fa-location-dot",
            onSelect = function()
                ExecuteCommand('tpm')
            end
        },
        {
            title = 'Goto Locations',
            description = 'Mlo locations',
            icon = "fa-solid fa-building",
            onSelect = function()
                OpenLocationsMenu()
            end
        },
        {
            title = 'Spawn Vehicle',
            description = 'display vehicle list',
            icon = "fa-solid fa-car",
            onSelect = function()
                OpenVehicleSpawnMenu()
            end
        },
        {
            title = 'Delete Vehicle',
            description = 'Delete nearby vehicle',
            icon = "fa-solid fa-car",
            onSelect = function()
                ExecuteCommand('dv ' .. 5.0)
            end
        },
        {
            title = 'Spawn Weapons',
            description = 'display weapons list',
            icon = "fa-solid fa-gun",
            onSelect = function()
                OpenWeaponsSpawnMenu()
            end
        },
        {
            title = 'Set Ammo Max',
            description = 'max ammo',
            icon = "fa-solid fa-gun",
            onSelect = function()
                ExecuteCommand('setammo 9999')
            end
        },
        {
            title = 'Vehicle Customs',
            description = 'Open Customs Menu',
            icon = "fa-solid fa-building",
            onSelect = function()
                TriggerEvent('qb-customs:client:EnterCustoms', {
                    coords = GetEntityCoords(cache.ped),
                    heading = GetEntityHeading(cache.ped),
                    categories = {
                        repair = true,
                        mods = true,
                        armor = true,
                        respray = true,
                        liveries = true,
                        wheels = true,
                        tint = true,
                        plate = true,
                        extras = true,
                        neons = true,
                        xenons = true,
                        horn = true,
                        turbo = true,
                        cosmetics = true,
                    }
                })
            end
        },


    }
    lib.registerContext({
        title = "Player Menu",
        id = 'nov_player_menu',
        options = options
    })
    lib.showContext('nov_player_menu')
end

function OpenLocationsMenu()
    local options = {}
    for k, v in pairs(config.locations) do
        options[#options + 1] = {
            title = v.label,
            description = 'Teleport',
            onSelect = function()
                TriggerEvent('QBCore:Command:TeleportToCoords', v.coords.x, v.coords.y, v.coords.z, v.coords.w)
            end
        }
    end
    lib.registerContext({
        title = 'Locations',
        id = 'nov_location_menu',
        options = options,
        menu = 'nov_player_menu'
    })
    lib.showContext('nov_location_menu')
end

function OpenWeaponsSpawnMenu()
    local options = {}
    local categories = {
        'Addons',
        'Throwable',
        'Heavy Weapons',
        'Sniper Rifle',
        'Light Machine Gun',
        'Assault Rifle',
        'Shotgun',
        'Submachine Gun',
        'Pistol',
        'Melee'
    }

    for i = 1, #categories do
        options[#options + 1] = {
            title = categories[i],
            icon = 'fa-solid fa-gun',
            onSelect = function()
                OpenCategory(categories[i])
            end
        }
    end
    lib.registerContext({
        title = 'Categories',
        menu = 'nov_player_menu',
        options = options,
        id = 'nov_weapons_cat'
    })
    lib.showContext('nov_weapons_cat')
end

function OpenCategory(name)
    local weapons = QBCore.Shared.Weapons
    local options = {}
    for i, j in pairs(config.weapons) do
        weapons[i] = j
    end
    for i, j in pairs(weapons) do
        if j.weapontype == name then
            options[#options + 1] = {
                title = j.label,
                icon = 'fa-solid fa-gun',
                onSelect = function()
                    ExecuteCommand('giveitem ' .. cache.serverId .. ' ' .. j.name .. ' 1')
                end
            }
        end
    end
    lib.registerContext({
        title = name,
        menu = 'nov_weapons_cat',
        options = options,
        id = 'nov_weapons_cat' .. name
    })
    lib.showContext('nov_weapons_cat' .. name)
end

function OpenVehicleSpawnMenu()
    local options = {}
    local categories = {
        'addons',
        'compacts',
        'sedans',
        'suvs',
        'coupes',
        'muscle',
        'sportsclassics',
        'sports',
        'super',
        'motorcycles',
        'offroad',
        'industrial',
        'utility',
        'vans',
        'cycles',
        'boats',
        'helicopters',
        'planes',
        'service',
        'emergency',
        'military',
        'commercial',
        'openwheel',
    }

    for i = 1, #categories do
        options[#options + 1] = {
            title = categories[i],
            icon = 'fa-solid fa-car',
            onSelect = function()
                OpenVehicleCategory(categories[i])
            end
        }
    end
    lib.registerContext({
        title = 'Categories',
        menu = 'nov_player_menu',
        options = options,
        id = 'nov_vehicles_cat'
    })
    lib.showContext('nov_vehicles_cat')
end

function OpenVehicleCategory(name)
    local vehicledata = {}
    local options = {}

    for i, j in pairs(QBCore.Shared.Vehicles) do
        vehicledata[j.model] = j
    end
    for i, j in pairs(config.vehicles) do
        vehicledata[j.model] = j
    end
    for i, j in pairs(vehicledata) do
        if j.category == name then
            options[#options + 1] = {
                title = j.name,
                icon = 'fa-solid fa-car',
                description = j.brand or '',
                onSelect = function()
                    ExecuteCommand('car ' .. j.model)
                end
            }
        end
    end
    lib.registerContext({
        title = name:upper(),
        menu = 'nov_vehicles_cat',
        options = options,
        id = 'nov_vehicles_cat' .. name
    })
    lib.showContext('nov_vehicles_cat' .. name)
end

function OpenWeatherCategory()
    local elements = {
        {
            title = "Time",
            icon = "fa-solid fa-clock",
            onSelect = function()
                local result = lib.inputDialog("Set Time", {
                    { type = 'number', label = 'Hours',   description = 'Enter Hours [24]', min = 0, max = 24, default = GetClockHours(),   icon = 'hashtag' },
                    { type = 'number', label = 'Minutes', description = 'Enter minutes',    min = 0, max = 60, default = GetClockMinutes(), icon = 'hashtag' }, })
                if not result then return end
                ExecuteCommand('time ' .. result[1] .. ' ' .. result[2])
            end
        },
        {
            icon = 'fa-solid fa-clock',
            title = 'Freeze Time',
            onSelect = function()
                ExecuteCommand('freezetime')
            end,
            description = 'Toggle Weather Freeze'
        },
        {
            title = "Weather",
            icon = "fa-solid fa-cloud",
            onSelect = function()
                OpenWeatherMenu()
            end
        },
        {
            icon = 'fa-solid fa-cloud',
            title = 'Freeze Weather',
            onSelect = function()
                ExecuteCommand('freezeweather')
            end,
            description = 'Toggle Weather Freeze'
        }
    }
    lib.registerContext({
        title = 'Weather Category Menu',
        menu = 'nov_player_menu',
        id = 'nov_weathercat_menu',
        options = elements
    })
    lib.showContext('nov_weathercat_menu')
end

function OpenWeatherMenu()
    local elements = {
        [1] = {
            icon = 'fa-solid fa-sun',
            title = Lang:t('weather.extra_sunny'),
            serverEvent = 'nova:setWeather',
            args = 'EXTRASUNNY',
            description = Lang:t('weather.extra_sunny_desc')
        },
        [2] = {
            icon = 'fa-solid fa-sun',
            title = Lang:t('weather.clear'),
            serverEvent = 'nova:setWeather',
            args = 'CLEAR',
            description = Lang:t('weather.clear_desc')
        },
        [3] = {
            icon = 'fa-solid fa-sun',
            title = Lang:t('weather.neutral'),
            serverEvent = 'nova:setWeather',
            args = 'NEUTRAL',
            description = Lang:t('weather.neutral_desc')
        },
        [4] = {
            icon = 'fa-solid fa-smog',
            title = Lang:t('weather.smog'),
            serverEvent = 'nova:setWeather',
            args = 'SMOG',
            description = Lang:t('weather.smog_desc')
        },
        [5] = {
            icon = 'fa-solid fa-smog',
            title = Lang:t('weather.foggy'),
            serverEvent = 'nova:setWeather',
            args = 'FOGGY',
            description = Lang:t('weather.foggy_desc')
        },
        [6] = {
            icon = 'fa-solid fa-cloud-sun',
            title = Lang:t('weather.overcast'),
            serverEvent = 'nova:setWeather',
            args = 'OVERCAST',
            description = Lang:t('weather.overcast_desc')
        },
        [7] = {
            icon = 'fa-solid fa-cloud',
            title = Lang:t('weather.clouds'),
            serverEvent = 'nova:setWeather',
            args = 'CLOUDS',
            description = Lang:t('weather.clouds_desc')
        },
        [8] = {
            icon = 'fa-solid fa-cloud-sun',
            title = Lang:t('weather.clearing'),
            serverEvent = 'nova:setWeather',
            args = 'CLEARING',
            description = Lang:t('weather.clearing_desc')
        },
        [9] = {
            icon = 'fa-solid fa-cloud-showers-heavy',
            title = Lang:t('weather.rain'),
            serverEvent = 'nova:setWeather',
            args = 'RAIN',
            description = Lang:t('weather.rain_desc')
        },

        [10] = {
            icon = 'fa-solid fa-cloud-bolt',
            title = Lang:t('weather.thunder'),
            serverEvent = 'nova:setWeather',
            args = 'THUNDER',
            description = Lang:t('weather.thunder_desc')
        },
        [11] = {
            icon = 'fa-solid fa-snowflake',
            title = Lang:t('weather.snow'),
            serverEvent = 'nova:setWeather',
            args = 'SNOW',
            description = Lang:t('weather.snow_desc')
        },
        [12] = {
            icon = "fa-solid fa-wind",
            title = Lang:t('weather.blizzard'),
            serverEvent = 'nova:setWeather',
            args = 'BLIZZARD',
            description = Lang:t('weather.blizzed_desc')
        },
        [13] = {
            icon = 'fa-solid fa-snowflake',
            title = Lang:t('weather.light_snow'),
            serverEvent = 'nova:setWeather',
            args = 'SNOWLIGHT',
            description = Lang:t('weather.light_snow_desc')
        },
        [14] = {
            icon = 'fa-solid fa-snowflake',
            title = Lang:t('weather.heavy_snow'),
            serverEvent = 'nova:setWeather',
            args = 'XMAS',
            description = Lang:t('weather.heavy_snow_desc')
        },
        [15] = {
            icon = 'fa-solid fa-cloud-moon',
            title = Lang:t('weather.halloween'),
            serverEvent = 'nova:setWeather',
            args = 'HALLOWEEN',
            description = Lang:t('weather.halloween_desc')
        },

    }
    lib.registerContext({
        title = 'Weather Menu',
        menu = 'nov_weathercat_menu',
        id = 'nov_weather_menu',
        options = elements
    })
    lib.showContext('nov_weather_menu')
end

RegisterNetEvent('nova:setWeather', function(data)
    ExecuteCommand('weather ' .. data)
end)
