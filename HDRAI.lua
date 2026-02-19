LUAGUI_NAME = "HDRAI"
LUAGUI_AUTH = "Sportiax"
LUAGUI_DESC = "High Drive Recovery Added to Inventory"

local offset_hdr = 0x3665
local address_hdr = nil

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

    WriteByte(Save + offset_hdr, 55)

    local new_address_hdr = ReadInt(Save + offset_hdr)
    if address_hdr == nil or new_address_hdr ~= address_hdr then
        address_hdr = new_address_hdr
        ConsolePrint(string.format("Save+0x3665 @ 0x%X = 0x%02X (%d)", Save + offset_hdr, new_address_hdr,
            new_address_hdr))
    end
end
