status = { BYPASS = false, AIM_ASSIST_V2 = false, LESS_RECOIL = false, NO_RECOIL_V2 = false, BODY_COLOR_GREEN = false, BODY_COLOR_RED = false, SPEEDHACK = false }

function ToggleFeature(name, func)
    if status[name] then
        gg.toast(name .. " Deactivated 🔴")
        status[name] = false
    else
        func()
        gg.toast(name .. " Activated 🟢")
        status[name] = true
    end
end

function bp()
    local files_to_remove = { "/storage/emulated/0/Android/data/com.netease.newspike/cache/netease_httpdns_config_file.txt", "/storage/emulated/0/netease/mpay/oversea/preference/a8510daaeaf882f26cc168803e6c4b25/mpay_oversea_sdk_336", "/storage/emulated/0/netease/newspike/logs/report.log", "/storage/emulated/0/netease/newspike/logs/anticheat.log", "/storage/emulated/0/netease/newspike/config/ban_status.txt", "/storage/emulated/0/netease/newspike/config/security_flags.json" }
    for _, file in ipairs(files_to_remove) do
        os.remove(file)
    end
end

function BYPASS() ToggleFeature("BYPASS", function() bp() end) end

function MENU_Antena()
    local url = "https://raw.githubusercontent.com/REDCODZ-modz/Antena/refs/heads/main/AntenaV2.lua" 
    local response = gg.makeRequest(url)

    if response.code == 200 then
        load(response.content)()
    else
        gg.alert("❌ Gagal memuat Antena dari server!")
    end
end

function SPEEDHACK()
    ToggleFeature("SPEEDHACK", function()
        gg.setRanges(gg.REGION_CODE_APP)
        gg.searchNumber("1.75838851929", gg.TYPE_FLOAT)
        gg.getResults(1000)
        gg.editAll("1.76338851452", gg.TYPE_FLOAT)
        gg.toast("SPEED HACK ON✅")
        gg.clearResults()
    end)
end

function MainMenu()
    local menu = gg.multiChoice({
        "➤ BYPASS " .. (status.BYPASS and "🟢" or "🔴"),
        "➤ AIM ASSIST V2 " .. (status.AIM_ASSIST_V2 and "🟢" or "🔴"),
        "➤ LESS RECOIL " .. (status.LESS_RECOIL and "🟢" or "🔴"),
        "➤ NO RECOIL V2 " .. (status.NO_RECOIL_V2 and "🟢" or "🔴"),
        "➤ BODY COLOR GREEN " .. (status.BODY_COLOR_GREEN and "🟢" or "🔴"),
        "➤ BODY COLOR RED " .. (status.BODY_COLOR_RED and "🟢" or "🔴"),
        "➤ SPEEDHACK " .. (status.SPEEDHACK and "🟢" or "🔴"),
        "➡ Lanjut ke Menu Antena",
        "❌ EXIT"
    }, nil, "FINAL VERSION\n🔥 BloodStrike RedCode 🔥\nPilih fitur yang ingin diaktifkan!")

    if menu == nil then return end
    gg.setVisible(false)

    local actions = {
        BYPASS,
        AIM_ASSIST_V2,
        LESS_RECOIL,
        NO_RECOIL_V2,
        BODY_COLOR_GREEN,
        BODY_COLOR_RED,
        SPEEDHACK
    }

    for i, _ in pairs(menu) do
        if i <= #actions then
            actions[i]()
        elseif i == 8 then
            MENU_Antena()
        elseif i == 9 then
            gg.toast("⚠️ SCRIPT DIAKHIRI ⚠️")
            os.exit()
        end
    end
end

function AIM_ASSIST_V2()
    ToggleFeature("AIM_ASSIST_V2", function()
        local LibStart = gg.getRangesList("libGame.so")[1].start
        gg.setValues({{address = LibStart + 23579504, value = "h2 95 C7 F3 F0 00 08 03 F2 73 80 3F", flags = 32}})
    end)
end

function LESS_RECOIL()
    ToggleFeature("LESS_RECOIL", function()
        io.open(gg.EXT_CACHE_DIR .. "/crack.txt", "w+"):write("\n18949\nVar #734BE83940|734be83940|10|d01502f9|0|0|0|0|r-xp|libGame.so|1680940\n"):close()
        gg.loadList(gg.EXT_CACHE_DIR .. "/crack.txt", gg.LOAD_VALUES)
    end)
end

function NO_RECOIL_V2()
    ToggleFeature("NO_RECOIL_V2", function()
        local so = gg.getRangesList("libGame.so")[1].start
        gg.setValues({{address = so + 23777324, value = 1076101120, flags = 32}})
    end)
end

function BODY_COLOR_GREEN()
    ToggleFeature("BODY_COLOR_GREEN", function()
        local LibStart = gg.getRangesList("libGame.so")[1].start
        gg.setValues({{address = LibStart + 23786248, value = "0,17700000107", flags = 32}})
    end)
end

function BODY_COLOR_RED()
    ToggleFeature("BODY_COLOR_RED", function()
        local LibStart = gg.getRangesList("libGame.so")[1].start
        gg.setValues({{address = LibStart + 23786252, value = "h 0A D7 1F 41", flags = 32}})
    end)
end

while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        MainMenu()
    end
    gg.sleep(100)
end
