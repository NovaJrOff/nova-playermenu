local Translations = {
   
    weather = {
        extra_sunny = 'Extra Sunny',
        extra_sunny_desc = "I'm Melting!",
        clear = 'Clear',
        clear_desc = 'The Perfect Day!',
        neutral = 'Neutral',
        neutral_desc = 'Just A Regular Day!',
        smog = 'Smog',
        smog_desc = 'Smoke Machine!',
        foggy = 'Foggy',
        foggy_desc = 'Smoke Machine x2!',
        overcast = 'Overcast',
        overcast_desc = 'Not Too Sunny!',
        clouds = 'Clouds',
        clouds_desc = "Where's The Sun?",
        clearing = 'Clearing',
        clearing_desc = 'Clouds Start To Clear!',
        rain = 'Rain',
        rain_desc = 'Make It Rain!',
        thunder = 'Thunder',
        thunder_desc = 'Run and Hide!',
        snow = 'Snow',
        snow_desc = 'Is It Cold Out Here?',
        blizzard = 'Blizzard',
        blizzed_desc = 'Snow Machine?',
        light_snow = 'Light Snow',
        light_snow_desc = 'Starting To Feel Like Christmas!',
        heavy_snow = 'Heavy Snow (XMAS)',
        heavy_snow_desc = 'Snowball Fight!',
        halloween = 'Halloween',
        halloween_desc = 'What Was That Noise?!',
        weather_changed = 'Weather Changed To: %{value}',
    },
}

---@diagnostic disable-next-line: undefined-global
Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
