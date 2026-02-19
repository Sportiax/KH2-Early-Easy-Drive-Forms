LUAGUI_NAME = "Unlock Shop Entries"
LUAGUI_AUTH = "Sportiax"
LUAGUI_DESC = "Unlock all shop entries (Fixed Light Cycle and Port Royal navigation)"

local offset_hb = 0x2395
local offset_fix_ca_navi = 0x2397
local offset_fix_light_cycle = 0x2398
local offset_mog = 0x2399
local address_hb = nil

function _OnInit()
    kh2lib = require("kh2lib")
    RequireKH2LibraryVersion(1)
    RequirePCGameVersion()
    CanExecute = kh2lib.CanExecute
    Now = kh2lib.Now
    Save = kh2lib.Save -- (KH2LibraryVersion2) Steam Shared/Global/JP: 09A98B0/09A9830/09A8830, Epic Shared/Global: 09A9330/09A92F0
end

function _OnFrame()
    if not CanExecute then
        return
    end

    WriteInt(Save + offset_hb, 255)
    WriteInt(Save + offset_fix_ca_navi, 253)
    WriteInt(Save + offset_fix_light_cycle, 31)
    WriteInt(Save + offset_mog, 255)

    local new_address_hb = ReadInt(Save + offset_hb)
    if address_hb == nil or new_address_hb ~= address_hb then
        address_hb = new_address_hb
        ConsolePrint(string.format("Save+0x2395 @ 0x%X = 0x%02X (%d)", Save + offset_hb, new_address_hb, new_address_hb)) -- Steam Shared/Global/JP: 9ABC45/9ABBC5/9AABC5, Epic Shared/Global: 9AB6C5/9AB685
    end
end
