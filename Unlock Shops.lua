LUAGUI_NAME = "Unlock Shop Entries"
LUAGUI_AUTH = "Sportiax"
LUAGUI_DESC = "Unlock all shop entries (Hi-Potion/High Drive Recovery now shows up early)"

local offset_hb = 0x2395
local offset_mog = 0x2399
local address_hb = nil
-- local address_mog = nil

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

    WriteInt(Save + offset_hb, -1)
    WriteInt(Save + offset_mog, -1)

    local new_address_hb = ReadInt(Save + offset_hb)
    if address_hb == nil or new_address_hb ~= address_hb then
        address_hb = new_address_hb
        ConsolePrint(string.format("Save+0x2395 @ 0x%X = 0x%02X (%d)", Save + offset_hb, new_address_hb, new_address_hb)) -- Steam Shared/Global/JP: 9ABC45/9ABBC5/9AABC5, Epic Shared/Global: 9AB6C5/9AB685
    end

    -- local new_address_mog = ReadInt(Save + offset_mog)
    -- if address_mog == nil or new_address_mog ~= address_mog then
    --     address_mog = new_address_mog
    --     ConsolePrint(string.format("Save+0x2399 @ 0x%X = 0x%02X (%d)", Save + offset_mog, new_address_mog,
    --         new_address_mog)) -- Steam Shared/Global/JP: 9ABC49/9ABBC9/9AABC9, Epic Shared/Global: 9AB6C9/9AB689
    -- end
end
