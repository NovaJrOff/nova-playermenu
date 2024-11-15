
lib.addCommand("playermenu", {
    restricted = false,
    help = "Open Player Menu"
}, function(source, args, raw)
    TriggerClientEvent('nov:client:openplayermenu', source)
end)
