function checkWhitelist()
    local url = "https://raw.githubusercontent.com/REDCODZ-modz/user.auth/main/uset.txt" -- Pastikan URL ini benar
    local response = gg.makeRequest(url)

    if response.code == 200 then
        local userList = response.content

        -- DEBUG: Cek apakah data benar-benar diterima
        gg.alert("Data Diterima:\n" .. userList)

        local userID = getUserID()
        local current_date = os.time()

        for line in userList:gmatch("[^\r\n]+") do
            local storedID, expireDate = line:match("([^|]+)|([^|]+)")

            -- DEBUG: Cek apakah parsing data berhasil
            gg.alert("UserID: " .. tostring(storedID) .. "\nExpire Date (Raw): " .. tostring(expireDate))

            if storedID == userID then
                local formattedExpireDate = formatTimestamp(expireDate)

                gg.alert("📅 Tanggal Expired Anda: " .. formattedExpireDate)

                if current_date > tonumber(expireDate) then
                    gg.alert("⛔ Akses Kedaluwarsa pada: " .. formattedExpireDate .. "\nHubungi admin untuk perpanjangan.")
                    os.exit()
                else
                    gg.toast("✅ Akses Diterima! Expired pada: " .. formattedExpireDate)
                    return
                end
            end
        end

        gg.alert("⛔ User ID tidak ditemukan! Hubungi admin.")
        os.exit()
    else
        gg.alert("⚠️ Gagal mengambil data! Kode: " .. response.code)
        os.exit()
    end
end

-- **Jalankan cek whitelist sebelum script utama dimulai**
checkWhitelist()

-- **Script utama Anda dimulai setelah pengecekan whitelist**
status = {
    BYPASS = false,
    AIM_ASSIST_V2 = false,
    MAGIC_BULLET_LOBBY = false,
    MAGIC_BULLET_GAME_V2 = false,
    LESS_RECOIL = false,
    NO_RECOIL_V2 = false, 
    BODY_COLOR_GREEN = false, 
    BODY_COLOR_RED = false, 
}

-- (Lanjutan kode asli Anda tetap ada di bawah...)

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
    local files_to_remove = { 
        "/storage/emulated/0/Android/data/com.netease.newspike/cache/netease_httpdns_config_file.txt", 
        "/storage/emulated/0/netease/mpay/oversea/preference/a8510daaeaf882f26cc168803e6c4b25/mpay_oversea_sdk_336", 
        "/storage/emulated/0/netease/newspike/logs/report.log", 
        "/storage/emulated/0/netease/newspike/logs/anticheat.log", 
        "/storage/emulated/0/netease/newspike/config/ban_status.txt", 
        "/storage/emulated/0/netease/newspike/config/security_flags.json" 
    } 
    for _, file in ipairs(files_to_remove) do 
        os.remove(file) 
    end 
end

function BYPASS() 
    ToggleFeature("BYPASS", function() 
        bp() 
    end) 
end


function MENU_Antena()
    local url = "https://raw.githubusercontent.com/REDCODZ-modz/Antena/refs/heads/main/AntenaV2.lua"
    local response = gg.makeRequest(url)

    if response.code == 200 then
        load(response.content)()
    else
        gg.alert("❌ Gagal memuat Antena dari server!")
    end
end

function MainMenu() 
    local menu = gg.multiChoice({ 
        "➤ BYPASS " .. (status.BYPASS and "🟢" or "🔴"), 
        "➤ AIM ASSIST V2 " .. (status.AIM_ASSIST_V2 and "🟢" or "🔴"), 
        "➤ MAGIC BULLET LOBBY " .. (status.MAGIC_BULLET_LOBBY and "🟢" or "🔴"), 
        "➤ MAGIC BULLET GAME V2 " .. (status.MAGIC_BULLET_GAME_V2 and "🟢" or "🔴"), 
        "➤ LESS RECOIL " .. (status.LESS_RECOIL and "🟢" or "🔴"), 
        "➤ NO RECOIL V2 " .. (status.NO_RECOIL_V2 and "🟢" or "🔴"), 
        "➤ BODY COLOR GREEN " .. (status.BODY_COLOR_GREEN and "🟢" or "🔴"), 
        "➤ BODY COLOR RED " .. (status.BODY_COLOR_RED and "🟢" or "🔴"), 
        "➡ Lanjut ke Menu Antena",  
        "❌ EXIT" 
    }, nil, "FINAL VERSION\n🔥 BloodStrike RedCode 🔥\nPilih fitur yang ingin diaktifkan!")

    if menu == nil then return end
    gg.setVisible(false)

    local actions = {
        BYPASS,
        AIM_ASSIST_V2,
        MAGIC_BULLET_LOBBY,
        MAGIC_BULLET_GAME_V2,
        LESS_RECOIL,
        NO_RECOIL_V2,
        BODY_COLOR_GREEN,
        BODY_COLOR_RED,
    }

    for i, _ in pairs(menu) do
        if i <= #actions then
            actions[i]()
        elseif i == 9 then
            -- **Memanggil Menu Kedua yang Online**
            MENU_Antena()
        elseif i == 10 then
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

function MAGIC_BULLET_LOBBY() 
    ToggleFeature("MAGIC_BULLET_LOBBY", function() 
        io.open(gg.EXT_CACHE_DIR .. "/crack.txt", "w+"):write("\n13196\nVar #735A45C89C|735a45c89c|10|3f828f5c|0|0|0|0|rw-p|libGame.so:bss|1989c\n"):close() 
        gg.loadList(gg.EXT_CACHE_DIR .. "/crack.txt", gg.LOAD_VALUES) 
    end) 
end

function MAGIC_BULLET_GAME_V2() 
    ToggleFeature("MAGIC_BULLET_GAME_V2", function() 
        io.open(gg.EXT_CACHE_DIR .. "/crack.txt", "w+"):write("\n13996\nVar #734BF1289C|734bf1289c|10|3f8147ae|0|0|0|0|rw-p|libGame.so:bss|1989c\n"):close() 
        gg.loadList(gg.EXT_CACHE_DIR .. "/crack.txt", gg.LOAD_VALUES) 
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
