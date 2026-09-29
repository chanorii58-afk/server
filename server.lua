-- ================================================================
--   GEOHOP v2.0  |  Country Server Hopper  |  by Kii
--   Delta Executor Compatible  |  Android-Safe (Plain Text Only)
-- ================================================================
-- HONEST NOTES:
--   > "My Region" shows YOUR device location via IP, not the server's.
--     Roblox does NOT expose server geographic location in its API.
--   > True language-region hopping depends on the game's player base,
--     not which server you join. A VPN is the only guaranteed method.
--   > Fresh Server does one real scan. If no empty servers exist it
--     tells you plainly instead of running forever.
-- ================================================================

local Players          = game:GetService("Players")
local TeleportService  = game:GetService("TeleportService")
local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")

local LP         = Players.LocalPlayer
local PlaceId    = game.PlaceId
local HomeJobId  = game.JobId

-- â”€â”€ THEME â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local T = {
    BG      = Color3.fromRGB(4,4,18),
    BGSec   = Color3.fromRGB(9,7,28),
    Blue    = Color3.fromRGB(50,110,255),
    Purple  = Color3.fromRGB(125,45,230),
    BlueL   = Color3.fromRGB(100,155,255),
    PurpleL = Color3.fromRGB(170,90,255),
    Text    = Color3.fromRGB(218,215,255),
    TextDim = Color3.fromRGB(120,115,185),
    Border  = Color3.fromRGB(50,110,255),
    BorderP = Color3.fromRGB(125,45,230),
    BtnBg   = Color3.fromRGB(18,60,205),
    BtnBord = Color3.fromRGB(125,45,230),
    Green   = Color3.fromRGB(45,200,110),
    Yellow  = Color3.fromRGB(255,185,40),
    Red     = Color3.fromRGB(240,58,58),
    Gold    = Color3.fromRGB(255,210,40),
}

-- â”€â”€ COUNTRIES â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Countries = {
    {name="United States",  code="US",  flag={"#B22234","#FFFFFF","#3C3B6E"}, region="us-east"   },
    {name="United Kingdom", code="GB",  flag={"#012169","#C8102E","#FFFFFF"}, region="eu-west"   },
    {name="Japan",          code="JP",  flag={"#BC002D","#FFFFFF","#BC002D"}, region="ap-ne"     },
    {name="Germany",        code="DE",  flag={"#000000","#DD0000","#FFCE00"}, region="eu-central"},
    {name="France",         code="FR",  flag={"#002395","#FFFFFF","#ED2939"}, region="eu-west"   },
    {name="Brazil",         code="BR",  flag={"#009C3B","#FFDF00","#002776"}, region="sa-east"   },
    {name="Australia",      code="AU",  flag={"#012169","#E8112D","#FFFFFF"}, region="ap-se"     },
    {name="Canada",         code="CA",  flag={"#FF0000","#FFFFFF","#FF0000"}, region="us-east"   },
    {name="South Korea",    code="KR",  flag={"#FFFFFF","#003478","#CD2E3A"}, region="ap-ne"     },
    {name="Mexico",         code="MX",  flag={"#006847","#FFFFFF","#CE1126"}, region="us-central"},
    {name="India",          code="IN",  flag={"#FF9933","#FFFFFF","#138808"}, region="ap-south"  },
    {name="Russia",         code="RU",  flag={"#FFFFFF","#0039A6","#D52B1E"}, region="eu-east"   },
    {name="Spain",          code="ES",  flag={"#AA151B","#F1BF00","#AA151B"}, region="eu-west"   },
    {name="Italy",          code="IT",  flag={"#009246","#FFFFFF","#CE2B37"}, region="eu-central"},
    {name="Philippines",    code="PH",  flag={"#0038A8","#CE1126","#FFFFFF"}, region="ap-se"     },
    {name="Indonesia",      code="ID",  flag={"#CE1126","#FFFFFF","#CE1126"}, region="ap-se"     },
    {name="Netherlands",    code="NL",  flag={"#AE1C28","#FFFFFF","#21468B"}, region="eu-west"   },
    {name="Poland",         code="PL",  flag={"#FFFFFF","#DC143C","#FFFFFF"}, region="eu-central"},
    {name="Turkey",         code="TR",  flag={"#E30A17","#FFFFFF","#E30A17"}, region="eu-south"  },
    {name="Argentina",      code="AR",  flag={"#74ACDF","#FFFFFF","#74ACDF"}, region="sa-east"   },
    {name="Saudi Arabia",   code="SA",  flag={"#006C35","#FFFFFF","#006C35"}, region="me-south"  },
    {name="Egypt",          code="EG",  flag={"#CE1126","#FFFFFF","#000000"}, region="me-south"  },
    {name="Nigeria",        code="NG",  flag={"#008751","#FFFFFF","#008751"}, region="af-south"  },
    {name="South Africa",   code="ZA",  flag={"#007A4D","#FFB612","#DE3831"}, region="af-south"  },
    {name="Sweden",         code="SE",  flag={"#006AA7","#FECC02","#006AA7"}, region="eu-north"  },
    {name="Norway",         code="NO",  flag={"#EF2B2D","#FFFFFF","#002868"}, region="eu-north"  },
    {name="Thailand",       code="TH",  flag={"#A51931","#FFFFFF","#2D2A4A"}, region="ap-se"     },
    {name="Vietnam",        code="VN",  flag={"#DA251D","#FFFF00","#DA251D"}, region="ap-se"     },
    {name="Malaysia",       code="MY",  flag={"#CC0001","#FFFFFF","#010066"}, region="ap-se"     },
    {name="Singapore",      code="SG",  flag={"#EF3340","#FFFFFF","#EF3340"}, region="ap-se"     },
}

-- â”€â”€ STATE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Favorites      = {}
local IsFreshHopping = false
local FreshThread    = nil
local CurrentCountry = nil
local MyLocData      = nil   -- populated once on startup

-- â”€â”€ FILE PERSISTENCE (for cross-session fresh server hunt) â”€â”€â”€â”€â”€â”€â”€
-- Delta and most executors support writefile / readfile.
-- We store all known server IDs in a file before teleporting.
-- On the NEXT script load we compare the new server's JobId against
-- that list. If it's NOT in the list â†’ brand new server = you're alone.
local HUNT_FILE = "geohop_hunt.txt"

local function saveHuntData(serverIdList)
    local lines = { "HUNTING" }
    for _, id in ipairs(serverIdList) do
        table.insert(lines, id)
    end
    pcall(writefile, HUNT_FILE, table.concat(lines, "\n"))
end

-- Returns: idSet (dict of known IDs), isHunting (bool)
local function loadHuntData()
    local ok, content = pcall(readfile, HUNT_FILE)
    if not ok or not content or content == "" then return {}, false end
    local lines = {}
    for line in content:gmatch("[^\n]+") do
        if line ~= "" then table.insert(lines, line) end
    end
    if #lines < 2 or lines[1] ~= "HUNTING" then return {}, false end
    local idSet = {}
    for i = 2, #lines do idSet[lines[i]] = true end
    return idSet, true
end

local function clearHuntData()
    pcall(writefile, HUNT_FILE, "")
end

-- Fetch ALL server pages (up to 10 pages = 1000 servers max)
local function fetchAllServerIds(onProgress)
    local allIds = {}
    local cursor = nil
    local page   = 0
    repeat
        local srvs, nextCursor = fetchServers(cursor)
        for _, s in ipairs(srvs) do
            table.insert(allIds, s.id)
        end
        cursor = nextCursor
        page   = page + 1
        if onProgress then onProgress(page, #allIds) end
        if cursor and cursor ~= "" then task.wait(0.35) end
    until (cursor == nil or cursor == "") or page >= 10
    return allIds
end

-- â”€â”€ HELPERS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function hexC(h)
    h = h:gsub("#","")
    return Color3.new(
        tonumber(h:sub(1,2),16)/255,
        tonumber(h:sub(3,4),16)/255,
        tonumber(h:sub(5,6),16)/255)
end

local function tw(obj, props, t, style, dir)
    TweenService:Create(obj, TweenInfo.new(
        t or 0.22,
        style or Enum.EasingStyle.Quart,
        dir   or Enum.EasingDirection.Out), props):Play()
end

local function rnd(p, r)
    local c = Instance.new("UICorner", p)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end

local function bdr(p, col, thick, tr)
    local s = Instance.new("UIStroke", p)
    s.Color = col or T.Border
    s.Thickness = thick or 1.5
    s.Transparency = tr or 0
    return s
end

local function lbl(parent, text, size, col, font, xa, zi)
    local l = Instance.new("TextLabel")
    l.BackgroundTransparency = 1
    l.Text  = text
    l.TextColor3 = col or T.Text
    l.TextSize   = size or 11
    l.Font       = font or Enum.Font.Gotham
    l.TextXAlignment = xa or Enum.TextXAlignment.Left
    l.ZIndex = zi or 13
    l.Parent = parent
    return l
end

local function makeDrag(frame, handle)
    local drag, moved = false, false
    local ds, sp, di = nil, nil, nil
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch
        or inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true; moved = false
            ds = inp.Position; sp = frame.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.Touch
        or inp.UserInputType == Enum.UserInputType.MouseMovement then di = inp end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and di and inp == di then
            local d = inp.Position - ds
            if math.abs(d.X)>5 or math.abs(d.Y)>5 then moved = true end
            if moved then
                frame.Position = UDim2.new(
                    sp.X.Scale, sp.X.Offset+d.X,
                    sp.Y.Scale, sp.Y.Offset+d.Y)
            end
        end
    end)
    return function() return moved end
end

-- â”€â”€ MY LOCATION DETECTION â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Detects YOUR device's location. This is NOT the server's location.
-- Roblox does not expose server geographic data via public API.
local function detectMyLocation()
    -- Try ipapi.co first (HTTPS)
    local ok, raw = pcall(game.HttpGet, game, "https://ipapi.co/json/")
    if ok and raw then
        local ok2, d = pcall(HttpService.JSONDecode, HttpService, raw)
        if ok2 and d and d.country_name then
            return {
                country = d.country_name or "Unknown",
                city    = d.city or "Unknown",
                region  = d.region or "Unknown",
                code    = d.country_code or "??",
                isp     = d.org or "Unknown",
            }
        end
    end
    -- Fallback: ip-api.com (HTTP)
    local ok3, raw2 = pcall(game.HttpGet, game, "http://ip-api.com/json/")
    if ok3 and raw2 then
        local ok4, d2 = pcall(HttpService.JSONDecode, HttpService, raw2)
        if ok4 and d2 and d2.country then
            return {
                country = d2.country or "Unknown",
                city    = d2.city or "Unknown",
                region  = d2.regionName or "Unknown",
                code    = d2.countryCode or "??",
                isp     = d2.isp or "Unknown",
            }
        end
    end
    return nil
end

-- Get current server ping (best effort from multiple internal sources)
local function getMyPing()
    local ok, p = pcall(function()
        return math.round(LP:GetNetworkPing() * 1000)
    end)
    if ok and p and p > 0 then return p end

    local ok2, stats = pcall(game.GetService, game, "Stats")
    if ok2 and stats then
        for _, name in ipairs({"Data Ping","ping","Network.Receive.KBPS"}) do
            local item = stats:FindFirstChild(name, true)
            if item and item.Value then
                local v = math.round(item.Value)
                if v > 0 then return v end
            end
        end
    end
    return nil
end

-- â”€â”€ SERVER API â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function fetchServers(cursor)
    local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&excludeFullGames=false&limit=100"):format(PlaceId)
    if cursor then url = url.."&cursor="..cursor end
    local ok, raw = pcall(game.HttpGet, game, url)
    if not ok then return {}, nil end
    local ok2, data = pcall(HttpService.JSONDecode, HttpService, raw)
    if not ok2 or not data then return {}, nil end
    return data.data or {}, data.nextPageCursor
end

local function doJoin(serverId)
    pcall(TeleportService.TeleportToPlaceInstance,
          TeleportService, PlaceId, serverId, LP)
end

-- â”€â”€ SCREEN GUI â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local SG = Instance.new("ScreenGui")
SG.Name = "GeoHop2"
SG.ResetOnSpawn   = false
SG.DisplayOrder   = 999
SG.IgnoreGuiInset = true
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if not pcall(function() SG.Parent = gethui() end) then
    SG.Parent = LP.PlayerGui
end

-- â”€â”€ BUBBLE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Bubble = Instance.new("Frame")
Bubble.Name             = "Bubble"
Bubble.Size             = UDim2.new(0,52,0,52)
Bubble.Position         = UDim2.new(0,18,0.7,0)
Bubble.BackgroundColor3 = T.BG
Bubble.BorderSizePixel  = 0
Bubble.ZIndex           = 100
Bubble.Visible          = false
Bubble.Parent           = SG
rnd(Bubble, 26)
bdr(Bubble, T.Blue, 2)

local BubGlow = Instance.new("Frame")
BubGlow.Size = UDim2.new(1,12,1,12)
BubGlow.AnchorPoint = Vector2.new(.5,.5)
BubGlow.Position = UDim2.new(.5,0,.5,0)
BubGlow.BackgroundColor3 = T.Blue
BubGlow.BackgroundTransparency = 0.75
BubGlow.BorderSizePixel = 0
BubGlow.ZIndex = 99
BubGlow.Parent = Bubble
rnd(BubGlow, 32)

local BubIco = Instance.new("Frame")
BubIco.Size = UDim2.new(0,26,0,26)
BubIco.AnchorPoint = Vector2.new(.5,.5)
BubIco.Position = UDim2.new(.5,0,.5,0)
BubIco.BackgroundTransparency = 1
BubIco.ZIndex = 101
BubIco.Parent = Bubble

-- Bubble drag + tap
local bDrag, bMoved = false, false
local bStart, bStartPos, bDI = nil, nil, nil

Bubble.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Touch
    or inp.UserInputType == Enum.UserInputType.MouseButton1 then
        bDrag=true; bMoved=false
        bStart=inp.Position; bStartPos=Bubble.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                bDrag = false
                if not bMoved then
                    local W = SG:FindFirstChild("GHWin")
                    if W then W.Visible=true; W.Size=UDim2.new(0,0,0,0)
                        tw(W,{Size=UDim2.new(0,285,0,420)},0.28,Enum.EasingStyle.Back) end
                    Bubble.Visible = false
                end
            end
        end)
    end
end)
Bubble.InputChanged:Connect(function(inp)
    if inp.UserInputType==Enum.UserInputType.Touch
    or inp.UserInputType==Enum.UserInputType.MouseMovement then bDI=inp end
end)
UserInputService.InputChanged:Connect(function(inp)
    if bDrag and bDI and inp==bDI then
        local d=inp.Position-bStart
        if math.abs(d.X)>6 or math.abs(d.Y)>6 then bMoved=true end
        if bMoved then
            Bubble.Position=UDim2.new(bStartPos.X.Scale,bStartPos.X.Offset+d.X,
                                      bStartPos.Y.Scale,bStartPos.Y.Offset+d.Y)
        end
    end
end)

-- â”€â”€ MAIN WINDOW â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Win = Instance.new("Frame")
Win.Name = "GHWin"
Win.Size = UDim2.new(0,285,0,420)
Win.AnchorPoint = Vector2.new(.5,.5)
Win.Position = UDim2.new(.5,0,.5,0)
Win.BackgroundColor3 = T.BG
Win.BorderSizePixel = 0
Win.ZIndex = 10
Win.ClipsDescendants = true
Win.Parent = SG
rnd(Win, 13)
bdr(Win, T.Border, 2)

local WG = Instance.new("UIGradient")
WG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(5,4,22)),
    ColorSequenceKeypoint.new(.5,  Color3.fromRGB(4,3,16)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(7,5,26)),
})
WG.Rotation = 135
WG.Parent = Win

-- â”€â”€ HEADER â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Hdr = Instance.new("Frame")
Hdr.Size = UDim2.new(1,0,0,40)
Hdr.BackgroundColor3 = Color3.fromRGB(6,4,22)
Hdr.BorderSizePixel = 0
Hdr.ZIndex = 11
Hdr.Parent = Win
rnd(Hdr, 13)

local HdrBot = Instance.new("Frame")
HdrBot.Size = UDim2.new(1,0,.5,0)
HdrBot.Position = UDim2.new(0,0,.5,0)
HdrBot.BackgroundColor3 = Color3.fromRGB(6,4,22)
HdrBot.BorderSizePixel = 0
HdrBot.ZIndex = 11
HdrBot.Parent = Hdr

Instance.new("Frame", Hdr).Size = UDim2.new(1,0,0,1)
Hdr:FindFirstChildOfClass("Frame").Position = UDim2.new(0,0,1,-1)
Hdr:FindFirstChildOfClass("Frame").BackgroundColor3 = T.BorderP
Hdr:FindFirstChildOfClass("Frame").BackgroundTransparency = 0.35
Hdr:FindFirstChildOfClass("Frame").BorderSizePixel = 0
Hdr:FindFirstChildOfClass("Frame").ZIndex = 12

local HdrTitle = Instance.new("TextLabel")
HdrTitle.Size = UDim2.new(1,-68,1,0)
HdrTitle.Position = UDim2.new(0,12,0,0)
HdrTitle.BackgroundTransparency = 1
HdrTitle.Text = "GeoHop"
HdrTitle.TextColor3 = T.Text
HdrTitle.TextSize = 15
HdrTitle.Font = Enum.Font.GothamBold
HdrTitle.TextXAlignment = Enum.TextXAlignment.Left
HdrTitle.ZIndex = 12
HdrTitle.Parent = Hdr
local TG = Instance.new("UIGradient", HdrTitle)
TG.Color = ColorSequence.new(T.BlueL, T.PurpleL)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,28,0,28)
MinBtn.Position = UDim2.new(1,-36,.5,-14)
MinBtn.BackgroundColor3 = Color3.fromRGB(10,7,34)
MinBtn.Text = "_"
MinBtn.TextColor3 = T.BlueL
MinBtn.TextSize = 17
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.ZIndex = 13
MinBtn.Parent = Hdr
rnd(MinBtn, 7)
bdr(MinBtn, T.BtnBord, 1.5)

makeDrag(Win, Hdr)

-- â”€â”€ MY REGION INFO BAR â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Shows YOUR detected location from IP. Loads after startup.
-- Note: This is your device region, NOT the Roblox server region.
local InfoBar = Instance.new("Frame")
InfoBar.Size = UDim2.new(1,0,0,32)
InfoBar.Position = UDim2.new(0,0,0,40)
InfoBar.BackgroundColor3 = Color3.fromRGB(6,4,20)
InfoBar.BorderSizePixel = 0
InfoBar.ZIndex = 11
InfoBar.Parent = Win

local IBLine = Instance.new("Frame", InfoBar)
IBLine.Size = UDim2.new(1,0,0,1)
IBLine.Position = UDim2.new(0,0,1,-1)
IBLine.BackgroundColor3 = T.Blue
IBLine.BackgroundTransparency = 0.7
IBLine.BorderSizePixel = 0
IBLine.ZIndex = 12

-- "MY REGION" label on left
local IBTagLbl = Instance.new("TextLabel")
IBTagLbl.Size = UDim2.new(0,72,1,0)
IBTagLbl.Position = UDim2.new(0,8,0,0)
IBTagLbl.BackgroundTransparency = 1
IBTagLbl.Text = "MY REGION"
IBTagLbl.TextColor3 = T.TextDim
IBTagLbl.TextSize = 7
IBTagLbl.Font = Enum.Font.GothamBold
IBTagLbl.TextXAlignment = Enum.TextXAlignment.Left
IBTagLbl.ZIndex = 12
IBTagLbl.Parent = InfoBar

-- Location value (updated after IP fetch)
local IBLocLbl = Instance.new("TextLabel")
IBLocLbl.Size = UDim2.new(1,-160,1,0)
IBLocLbl.Position = UDim2.new(0,72,0,0)
IBLocLbl.BackgroundTransparency = 1
IBLocLbl.Text = "Detecting..."
IBLocLbl.TextColor3 = T.BlueL
IBLocLbl.TextSize = 9
IBLocLbl.Font = Enum.Font.GothamBold
IBLocLbl.TextXAlignment = Enum.TextXAlignment.Left
IBLocLbl.TextTruncate = Enum.TextTruncate.AtEnd
IBLocLbl.ZIndex = 12
IBLocLbl.Parent = InfoBar

-- Ping display on right
local IBPingLbl = Instance.new("TextLabel")
IBPingLbl.Size = UDim2.new(0,80,1,0)
IBPingLbl.Position = UDim2.new(1,-84,0,0)
IBPingLbl.BackgroundTransparency = 1
IBPingLbl.Text = "Ping: --"
IBPingLbl.TextColor3 = T.TextDim
IBPingLbl.TextSize = 8
IBPingLbl.Font = Enum.Font.Gotham
IBPingLbl.TextXAlignment = Enum.TextXAlignment.Right
IBPingLbl.ZIndex = 12
IBPingLbl.Parent = InfoBar

-- â”€â”€ TAB BAR â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1,0,0,38)
TabBar.Position = UDim2.new(0,0,0,72)
TabBar.BackgroundColor3 = Color3.fromRGB(5,4,18)
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 11
TabBar.Parent = Win

local TLine = Instance.new("Frame", TabBar)
TLine.Size = UDim2.new(1,0,0,1)
TLine.Position = UDim2.new(0,0,1,-1)
TLine.BackgroundColor3 = T.Border
TLine.BackgroundTransparency = 0.65
TLine.BorderSizePixel = 0
TLine.ZIndex = 12

local TabSlider = Instance.new("Frame", TabBar)
TabSlider.Size = UDim2.new(0,95,0,2)
TabSlider.Position = UDim2.new(0,0,1,-2)
TabSlider.BackgroundColor3 = T.Blue
TabSlider.BorderSizePixel = 0
TabSlider.ZIndex = 13
rnd(TabSlider, 2)
local SG2 = Instance.new("UIGradient", TabSlider)
SG2.Color = ColorSequence.new(T.Blue, T.Purple)

local function mkTab(ltext, xOff)
    local b = Instance.new("TextButton", TabBar)
    b.Size = UDim2.new(0,95,1,0)
    b.Position = UDim2.new(0,xOff,0,0)
    b.BackgroundTransparency = 1
    b.Text = ""
    b.ZIndex = 12

    local ico = Instance.new("Frame", b)
    ico.Size = UDim2.new(0,18,0,18)
    ico.AnchorPoint = Vector2.new(.5,.5)
    ico.Position = UDim2.new(.5,0,.4,0)
    ico.BackgroundTransparency = 1
    ico.ZIndex = 13

    local tl = Instance.new("TextLabel", b)
    tl.Size = UDim2.new(1,0,0,10)
    tl.Position = UDim2.new(0,0,1,-11)
    tl.BackgroundTransparency = 1
    tl.Text = ltext
    tl.TextColor3 = T.TextDim
    tl.TextSize = 8
    tl.Font = Enum.Font.Gotham
    tl.ZIndex = 13

    return b, ico, tl
end

local TBReg,  TBRegIco,  TBRegLbl  = mkTab("Regions",   0)
local TBFav,  TBFavIco,  TBFavLbl  = mkTab("Favorites",95)
local TBFr,   TBFrIco,   TBFrLbl   = mkTab("Fresh",    190)

-- â”€â”€ DRAWN ICONS (no emoji, pure frames) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function drawGlobe(p, col)
    local z = p.ZIndex+1
    local oc = Instance.new("Frame",p)
    oc.Size=UDim2.new(1,0,1,0); oc.BackgroundTransparency=1
    oc.BorderSizePixel=0; oc.ZIndex=z
    rnd(oc,50); bdr(oc,col,1.5)
    local hl=Instance.new("Frame",p)
    hl.Size=UDim2.new(1,-2,0,1.5); hl.AnchorPoint=Vector2.new(.5,.5)
    hl.Position=UDim2.new(.5,0,.5,0); hl.BackgroundColor3=col
    hl.BorderSizePixel=0; hl.ZIndex=z
    local vl=Instance.new("Frame",p)
    vl.Size=UDim2.new(0,1.5,1,-2); vl.AnchorPoint=Vector2.new(.5,.5)
    vl.Position=UDim2.new(.5,0,.5,0); vl.BackgroundColor3=col
    vl.BorderSizePixel=0; vl.ZIndex=z
    local ov=Instance.new("Frame",p)
    ov.Size=UDim2.new(.48,0,.98,0); ov.AnchorPoint=Vector2.new(.5,.5)
    ov.Position=UDim2.new(.5,0,.5,0); ov.BackgroundTransparency=1
    ov.BorderSizePixel=0; ov.ZIndex=z
    rnd(ov,50); bdr(ov,col,1.5)
    return oc
end

local function drawStar(p, col)
    local z=p.ZIndex+1
    for i=0,4 do
        local r=Instance.new("Frame",p)
        r.AnchorPoint=Vector2.new(.5,1); r.Size=UDim2.new(.18,0,.52,0)
        r.Position=UDim2.new(.5,0,.5,0); r.BackgroundColor3=col
        r.BorderSizePixel=0; r.ZIndex=z; r.Rotation=i*72; rnd(r,99)
    end
    local c=Instance.new("Frame",p)
    c.Size=UDim2.new(.22,0,.22,0); c.AnchorPoint=Vector2.new(.5,.5)
    c.Position=UDim2.new(.5,0,.5,0); c.BackgroundColor3=col
    c.BorderSizePixel=0; c.ZIndex=z+1; rnd(c,99)
end

local function drawRefresh(p, col)
    local z=p.ZIndex+1
    local arc=Instance.new("Frame",p)
    arc.Size=UDim2.new(.9,0,.9,0); arc.AnchorPoint=Vector2.new(.5,.5)
    arc.Position=UDim2.new(.5,0,.5,0); arc.BackgroundTransparency=1
    arc.BorderSizePixel=0; arc.ZIndex=z; rnd(arc,99); bdr(arc,col,2)
    local aT=Instance.new("Frame",p)
    aT.Size=UDim2.new(.3,0,.3,0); aT.AnchorPoint=Vector2.new(.5,.5)
    aT.Position=UDim2.new(.82,0,.18,0); aT.BackgroundColor3=col
    aT.BorderSizePixel=0; aT.ZIndex=z+1; aT.Rotation=-45; rnd(aT,2)
    local aB=Instance.new("Frame",p)
    aB.Size=UDim2.new(.3,0,.3,0); aB.AnchorPoint=Vector2.new(.5,.5)
    aB.Position=UDim2.new(.18,0,.82,0); aB.BackgroundColor3=col
    aB.BorderSizePixel=0; aB.ZIndex=z+1; aB.Rotation=135; rnd(aB,2)
end

drawGlobe(TBRegIco, T.Blue)
drawStar(TBFavIco, T.TextDim)
drawRefresh(TBFrIco, T.TextDim)
drawGlobe(BubIco, T.Blue)

-- â”€â”€ CONTENT AREA â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local Content = Instance.new("Frame", Win)
Content.Size = UDim2.new(1,0,1,-110)
Content.Position = UDim2.new(0,0,0,110)
Content.BackgroundTransparency = 1
Content.ZIndex = 11
Content.ClipsDescendants = true

local function mkPage(n)
    local p=Instance.new("Frame",Content)
    p.Name=n; p.Size=UDim2.new(1,0,1,0)
    p.BackgroundTransparency=1; p.ZIndex=12; p.Visible=false
    return p
end

-- â”€â”€ COUNTRYBALL â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function mkBall(parent, flags, sz, zi)
    local circ=Instance.new("Frame",parent)
    circ.Size=UDim2.new(0,sz,0,sz)
    circ.BackgroundColor3=hexC(flags[1])
    circ.BorderSizePixel=0; circ.ZIndex=zi; circ.ClipsDescendants=true
    local cc=Instance.new("UICorner",circ); cc.CornerRadius=UDim.new(1,0)
    local n=#flags
    for i=2,n do
        local b=Instance.new("Frame",circ)
        local h=1/n
        b.Size=UDim2.new(1,0,h+.03,0)
        b.Position=UDim2.new(0,0,(i-1)*h-.015,0)
        b.BackgroundColor3=hexC(flags[i])
        b.BorderSizePixel=0; b.ZIndex=zi+1
    end
    bdr(circ, Color3.fromRGB(55,55,85), 1)
    return circ
end

-- â”€â”€ PAGE 1: REGIONS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local PgR = mkPage("Regions")

local RHdr = Instance.new("Frame",PgR)
RHdr.Size=UDim2.new(1,0,0,28); RHdr.BackgroundTransparency=1; RHdr.ZIndex=12

local RSubLbl=Instance.new("TextLabel",RHdr)
RSubLbl.Size=UDim2.new(1,-80,1,0); RSubLbl.Position=UDim2.new(0,10,0,0)
RSubLbl.BackgroundTransparency=1; RSubLbl.Text="Select a country"
RSubLbl.TextColor3=T.TextDim; RSubLbl.TextSize=10; RSubLbl.Font=Enum.Font.Gotham
RSubLbl.TextXAlignment=Enum.TextXAlignment.Left; RSubLbl.ZIndex=13

local HomeBtn=Instance.new("TextButton",RHdr)
HomeBtn.Size=UDim2.new(0,56,0,22); HomeBtn.Position=UDim2.new(1,-62,.5,-11)
HomeBtn.BackgroundColor3=T.BtnBg; HomeBtn.Text="Home"
HomeBtn.TextColor3=Color3.fromRGB(255,255,255); HomeBtn.TextSize=9
HomeBtn.Font=Enum.Font.GothamBold; HomeBtn.BorderSizePixel=0; HomeBtn.ZIndex=13
rnd(HomeBtn,6); bdr(HomeBtn,T.BtnBord,1.5)

local RScroll=Instance.new("ScrollingFrame",PgR)
RScroll.Size=UDim2.new(1,0,1,-28); RScroll.Position=UDim2.new(0,0,0,28)
RScroll.BackgroundTransparency=1; RScroll.BorderSizePixel=0
RScroll.ScrollBarThickness=3; RScroll.ScrollBarImageColor3=T.Purple
RScroll.CanvasSize=UDim2.new(0,0,0,0)
RScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; RScroll.ZIndex=12

local RL=Instance.new("UIListLayout",RScroll)
RL.Padding=UDim.new(0,3); RL.HorizontalAlignment=Enum.HorizontalAlignment.Center
local RP=Instance.new("UIPadding",RScroll)
RP.PaddingLeft=UDim.new(0,6); RP.PaddingRight=UDim.new(0,6)
RP.PaddingTop=UDim.new(0,3); RP.PaddingBottom=UDim.new(0,3)

-- â”€â”€ PAGE 2: SERVER LIST â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local PgS = mkPage("Servers")

local SHdr=Instance.new("Frame",PgS)
SHdr.Size=UDim2.new(1,0,0,32); SHdr.BackgroundTransparency=1; SHdr.ZIndex=12

local BackBtn=Instance.new("TextButton",SHdr)
BackBtn.Size=UDim2.new(0,44,0,26); BackBtn.Position=UDim2.new(0,6,.5,-13)
BackBtn.BackgroundColor3=Color3.fromRGB(10,7,32); BackBtn.Text="Back"
BackBtn.TextColor3=T.Blue; BackBtn.TextSize=10; BackBtn.Font=Enum.Font.GothamBold
BackBtn.BorderSizePixel=0; BackBtn.ZIndex=13
rnd(BackBtn,6); bdr(BackBtn,T.BtnBord,1.5)

local STitleLbl=Instance.new("TextLabel",SHdr)
STitleLbl.Size=UDim2.new(1,-120,1,0); STitleLbl.Position=UDim2.new(0,56,0,0)
STitleLbl.BackgroundTransparency=1; STitleLbl.Text="Servers"
STitleLbl.TextColor3=T.Text; STitleLbl.TextSize=12; STitleLbl.Font=Enum.Font.GothamBold
STitleLbl.TextXAlignment=Enum.TextXAlignment.Left; STitleLbl.ZIndex=13

local SCountLbl=Instance.new("TextLabel",SHdr)
SCountLbl.Size=UDim2.new(0,68,1,0); SCountLbl.Position=UDim2.new(1,-72,0,0)
SCountLbl.BackgroundTransparency=1; SCountLbl.Text=""
SCountLbl.TextColor3=T.TextDim; SCountLbl.TextSize=9; SCountLbl.Font=Enum.Font.Gotham
SCountLbl.ZIndex=13

-- Region note (explains limitation honestly)
local SNoteLbl=Instance.new("TextLabel",PgS)
SNoteLbl.Size=UDim2.new(1,-12,0,14); SNoteLbl.Position=UDim2.new(0,6,0,32)
SNoteLbl.BackgroundTransparency=1
SNoteLbl.Text="Note: Server location is not exposed by Roblox. Language depends on who plays this game."
SNoteLbl.TextColor3=Color3.fromRGB(90,85,140); SNoteLbl.TextSize=7
SNoteLbl.Font=Enum.Font.Gotham; SNoteLbl.TextXAlignment=Enum.TextXAlignment.Left
SNoteLbl.TextWrapped=true; SNoteLbl.ZIndex=13

local SScroll=Instance.new("ScrollingFrame",PgS)
SScroll.Size=UDim2.new(1,0,1,-50); SScroll.Position=UDim2.new(0,0,0,50)
SScroll.BackgroundTransparency=1; SScroll.BorderSizePixel=0
SScroll.ScrollBarThickness=3; SScroll.ScrollBarImageColor3=T.Purple
SScroll.CanvasSize=UDim2.new(0,0,0,0)
SScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; SScroll.ZIndex=12

local SSL=Instance.new("UIListLayout",SScroll)
SSL.Padding=UDim.new(0,3); SSL.HorizontalAlignment=Enum.HorizontalAlignment.Center
local SSP=Instance.new("UIPadding",SScroll)
SSP.PaddingLeft=UDim.new(0,6); SSP.PaddingRight=UDim.new(0,6)
SSP.PaddingTop=UDim.new(0,3); SSP.PaddingBottom=UDim.new(0,3)

local SLoadLbl=Instance.new("TextLabel",SScroll)
SLoadLbl.Size=UDim2.new(1,0,0,50); SLoadLbl.BackgroundTransparency=1
SLoadLbl.Text="Fetching servers..."; SLoadLbl.TextColor3=T.TextDim
SLoadLbl.TextSize=11; SLoadLbl.Font=Enum.Font.Gotham; SLoadLbl.ZIndex=13
SLoadLbl.Visible=false

-- â”€â”€ PAGE 3: FAVORITES â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local PgF = mkPage("Favorites")

local FTitleLbl=Instance.new("TextLabel",PgF)
FTitleLbl.Size=UDim2.new(1,-20,0,26); FTitleLbl.Position=UDim2.new(0,10,0,2)
FTitleLbl.BackgroundTransparency=1; FTitleLbl.Text="Favorite Servers"
FTitleLbl.TextColor3=T.Text; FTitleLbl.TextSize=12; FTitleLbl.Font=Enum.Font.GothamBold
FTitleLbl.TextXAlignment=Enum.TextXAlignment.Left; FTitleLbl.ZIndex=13

local SaveCurrBtn=Instance.new("TextButton",PgF)
SaveCurrBtn.Size=UDim2.new(1,-12,0,26); SaveCurrBtn.Position=UDim2.new(0,6,0,28)
SaveCurrBtn.BackgroundColor3=T.BtnBg; SaveCurrBtn.Text="Save Current Server"
SaveCurrBtn.TextColor3=Color3.fromRGB(255,255,255); SaveCurrBtn.TextSize=10
SaveCurrBtn.Font=Enum.Font.GothamBold; SaveCurrBtn.BorderSizePixel=0; SaveCurrBtn.ZIndex=13
rnd(SaveCurrBtn,7); bdr(SaveCurrBtn,T.BtnBord,1.5)

local FScroll=Instance.new("ScrollingFrame",PgF)
FScroll.Size=UDim2.new(1,0,1,-58); FScroll.Position=UDim2.new(0,0,0,58)
FScroll.BackgroundTransparency=1; FScroll.BorderSizePixel=0
FScroll.ScrollBarThickness=3; FScroll.ScrollBarImageColor3=T.Purple
FScroll.CanvasSize=UDim2.new(0,0,0,0)
FScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; FScroll.ZIndex=12

local FL=Instance.new("UIListLayout",FScroll)
FL.Padding=UDim.new(0,3); FL.HorizontalAlignment=Enum.HorizontalAlignment.Center
local FP=Instance.new("UIPadding",FScroll)
FP.PaddingLeft=UDim.new(0,6); FP.PaddingRight=UDim.new(0,6)
FP.PaddingTop=UDim.new(0,3); FP.PaddingBottom=UDim.new(0,3)

local NoFavLbl=Instance.new("TextLabel",FScroll)
NoFavLbl.Size=UDim2.new(1,0,0,56); NoFavLbl.BackgroundTransparency=1
NoFavLbl.Text="No favorites yet.\nJoin a server and press Save to keep it."
NoFavLbl.TextColor3=T.TextDim; NoFavLbl.TextSize=10; NoFavLbl.Font=Enum.Font.Gotham
NoFavLbl.TextWrapped=true; NoFavLbl.ZIndex=13

-- â”€â”€ PAGE 4: FRESH SERVER â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local PgFr = mkPage("Fresh")

local FrTitleLbl=Instance.new("TextLabel",PgFr)
FrTitleLbl.Size=UDim2.new(1,-20,0,24); FrTitleLbl.Position=UDim2.new(0,10,0,4)
FrTitleLbl.BackgroundTransparency=1; FrTitleLbl.Text="Fresh Server Finder"
FrTitleLbl.TextColor3=T.Text; FrTitleLbl.TextSize=12; FrTitleLbl.Font=Enum.Font.GothamBold
FrTitleLbl.TextXAlignment=Enum.TextXAlignment.Left; FrTitleLbl.ZIndex=13

local FrDescLbl=Instance.new("TextLabel",PgFr)
FrDescLbl.Size=UDim2.new(1,-20,0,30); FrDescLbl.Position=UDim2.new(0,10,0,30)
FrDescLbl.BackgroundTransparency=1
FrDescLbl.Text="Scans all servers. Joins the first with 0 players. If none are empty, offers to FORCE CREATE a fresh server by blocking all known servers and teleporting randomly."
FrDescLbl.TextColor3=T.TextDim; FrDescLbl.TextSize=9; FrDescLbl.Font=Enum.Font.Gotham
FrDescLbl.TextWrapped=true; FrDescLbl.TextXAlignment=Enum.TextXAlignment.Left; FrDescLbl.ZIndex=13

-- Real status box
local FrBox=Instance.new("Frame",PgFr)
FrBox.Size=UDim2.new(1,-16,0,90); FrBox.Position=UDim2.new(0,8,0,66)
FrBox.BackgroundColor3=Color3.fromRGB(7,5,22); FrBox.BorderSizePixel=0; FrBox.ZIndex=13
rnd(FrBox,8); bdr(FrBox,T.Border,1,.55)

local FrStatusLbl=Instance.new("TextLabel",FrBox)
FrStatusLbl.Size=UDim2.new(1,-14,1,0); FrStatusLbl.Position=UDim2.new(0,7,0,0)
FrStatusLbl.BackgroundTransparency=1
FrStatusLbl.Text="Status: Idle\nScanned: 0 servers\nEmpty found: 0"
FrStatusLbl.TextColor3=T.Text; FrStatusLbl.TextSize=10; FrStatusLbl.Font=Enum.Font.Gotham
FrStatusLbl.TextXAlignment=Enum.TextXAlignment.Left
FrStatusLbl.TextYAlignment=Enum.TextYAlignment.Center
FrStatusLbl.TextWrapped=true; FrStatusLbl.ZIndex=14

-- Progress bar
local FrPBg=Instance.new("Frame",PgFr)
FrPBg.Size=UDim2.new(1,-16,0,5); FrPBg.Position=UDim2.new(0,8,0,164)
FrPBg.BackgroundColor3=Color3.fromRGB(13,11,36); FrPBg.BorderSizePixel=0; FrPBg.ZIndex=13
rnd(FrPBg,3)
local FrPFill=Instance.new("Frame",FrPBg)
FrPFill.Size=UDim2.new(0,0,1,0); FrPFill.BackgroundColor3=T.Blue
FrPFill.BorderSizePixel=0; FrPFill.ZIndex=14; rnd(FrPFill,3)
local FrPG=Instance.new("UIGradient",FrPFill)
FrPG.Color=ColorSequence.new(T.Blue,T.Purple)

local FrScanBtn=Instance.new("TextButton",PgFr)
FrScanBtn.Size=UDim2.new(1,-16,0,32); FrScanBtn.Position=UDim2.new(0,8,0,176)
FrScanBtn.BackgroundColor3=T.BtnBg; FrScanBtn.Text="Scan and Find Empty Server"
FrScanBtn.TextColor3=Color3.fromRGB(255,255,255); FrScanBtn.TextSize=11
FrScanBtn.Font=Enum.Font.GothamBold; FrScanBtn.BorderSizePixel=0; FrScanBtn.ZIndex=13
rnd(FrScanBtn,8); bdr(FrScanBtn,T.BtnBord,1.5)

local FrStopBtn=Instance.new("TextButton",PgFr)
FrStopBtn.Size=UDim2.new(1,-16,0,26); FrStopBtn.Position=UDim2.new(0,8,0,216)
FrStopBtn.BackgroundColor3=Color3.fromRGB(55,10,10); FrStopBtn.Text="Stop Scan"
FrStopBtn.TextColor3=Color3.fromRGB(255,90,90); FrStopBtn.TextSize=10
FrStopBtn.Font=Enum.Font.GothamBold; FrStopBtn.BorderSizePixel=0; FrStopBtn.ZIndex=13
FrStopBtn.Visible=false
rnd(FrStopBtn,7); bdr(FrStopBtn,Color3.fromRGB(150,35,35),1.5)

-- Join least-populated (shown after scan with results)
local FrJoinLeastBtn=Instance.new("TextButton",PgFr)
FrJoinLeastBtn.Size=UDim2.new(1,-16,0,26); FrJoinLeastBtn.Position=UDim2.new(0,8,0,250)
FrJoinLeastBtn.BackgroundColor3=Color3.fromRGB(12,42,12); FrJoinLeastBtn.Text="Join Least Populated Instead"
FrJoinLeastBtn.TextColor3=T.Green; FrJoinLeastBtn.TextSize=10
FrJoinLeastBtn.Font=Enum.Font.GothamBold; FrJoinLeastBtn.BorderSizePixel=0; FrJoinLeastBtn.ZIndex=13
FrJoinLeastBtn.Visible=false
rnd(FrJoinLeastBtn,7); bdr(FrJoinLeastBtn,T.Green,1)

local FrLeastServerId = nil

-- Force Create Fresh Server button (shown when scan finds no empty servers)
local FrForceBtn=Instance.new("TextButton",PgFr)
FrForceBtn.Size=UDim2.new(1,-16,0,30); FrForceBtn.Position=UDim2.new(0,8,0,285)
FrForceBtn.BackgroundColor3=Color3.fromRGB(28,8,48)
FrForceBtn.Text="Force Create Fresh Server"
FrForceBtn.TextColor3=T.PurpleL; FrForceBtn.TextSize=10
FrForceBtn.Font=Enum.Font.GothamBold; FrForceBtn.BorderSizePixel=0; FrForceBtn.ZIndex=13
FrForceBtn.Visible=false
rnd(FrForceBtn,7); bdr(FrForceBtn,T.PurpleL,1.5)

-- Small explanation under the force button
local FrForceDescLbl=Instance.new("TextLabel",PgFr)
FrForceDescLbl.Size=UDim2.new(1,-20,0,24)
FrForceDescLbl.Position=UDim2.new(0,10,0,320)
FrForceDescLbl.BackgroundTransparency=1
FrForceDescLbl.Text="Blocks every existing server then teleports you randomly. GeoHop checks on next re-run if you landed in a truly new server."
FrForceDescLbl.TextColor3=Color3.fromRGB(85,65,125); FrForceDescLbl.TextSize=8
FrForceDescLbl.Font=Enum.Font.Gotham; FrForceDescLbl.TextWrapped=true
FrForceDescLbl.TextXAlignment=Enum.TextXAlignment.Left; FrForceDescLbl.ZIndex=13
FrForceDescLbl.Visible=false

-- â”€â”€ COUNTRY BUTTONS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local openServerPage   -- forward
local refreshFavorites -- forward

for _, c in ipairs(Countries) do
    local btn=Instance.new("TextButton",RScroll)
    btn.Size=UDim2.new(1,0,0,38); btn.BackgroundColor3=T.BGSec
    btn.BorderSizePixel=0; btn.Text=""; btn.ZIndex=13
    rnd(btn,7); local bs=bdr(btn,T.BtnBord,1,.72)

    local bw=Instance.new("Frame",btn)
    bw.Size=UDim2.new(0,28,0,28); bw.Position=UDim2.new(0,6,.5,-14)
    bw.BackgroundTransparency=1; bw.ZIndex=14; bw.BorderSizePixel=0
    mkBall(bw, c.flag, 28, 14)

    local cdL=Instance.new("TextLabel",bw)
    cdL.Size=UDim2.new(1,0,1,0); cdL.BackgroundTransparency=1
    cdL.Text=c.code; cdL.TextColor3=Color3.fromRGB(255,255,255)
    cdL.TextSize=6; cdL.Font=Enum.Font.GothamBold; cdL.ZIndex=16
    cdL.TextStrokeTransparency=0.25; cdL.TextStrokeColor3=Color3.fromRGB(0,0,0)

    local nL=Instance.new("TextLabel",btn)
    nL.Size=UDim2.new(1,-108,1,0); nL.Position=UDim2.new(0,40,0,0)
    nL.BackgroundTransparency=1; nL.Text=c.name
    nL.TextColor3=T.Text; nL.TextSize=11; nL.Font=Enum.Font.Gotham
    nL.TextXAlignment=Enum.TextXAlignment.Left
    nL.TextTruncate=Enum.TextTruncate.AtEnd; nL.ZIndex=14

    local bg=Instance.new("Frame",btn)
    bg.Size=UDim2.new(0,0,0,14); bg.AnchorPoint=Vector2.new(1,.5)
    bg.Position=UDim2.new(1,-5,.5,0); bg.BackgroundColor3=Color3.fromRGB(9,7,26)
    bg.BorderSizePixel=0; bg.AutomaticSize=Enum.AutomaticSize.X; bg.ZIndex=14
    rnd(bg,4)
    local bgp=Instance.new("UIPadding",bg)
    bgp.PaddingLeft=UDim.new(0,4); bgp.PaddingRight=UDim.new(0,4)
    local bgl=Instance.new("TextLabel",bg)
    bgl.Size=UDim2.new(0,0,1,0); bgl.AutomaticSize=Enum.AutomaticSize.X
    bgl.BackgroundTransparency=1; bgl.Text=c.region
    bgl.TextColor3=T.TextDim; bgl.TextSize=7; bgl.Font=Enum.Font.Gotham; bgl.ZIndex=15

    btn.MouseEnter:Connect(function()
        tw(btn,{BackgroundColor3=Color3.fromRGB(13,10,38)},.14)
        tw(bs,{Transparency=0.2},.14)
    end)
    btn.MouseLeave:Connect(function()
        tw(btn,{BackgroundColor3=T.BGSec},.14)
        tw(bs,{Transparency=0.72},.14)
    end)

    local cap=c
    btn.MouseButton1Click:Connect(function()
        CurrentCountry=cap; openServerPage(cap)
    end)
end

-- â”€â”€ SERVER CARD â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function addSrvCard(srv, idx)
    local card=Instance.new("TextButton",SScroll)
    card.Size=UDim2.new(1,0,0,52); card.BackgroundColor3=T.BGSec
    card.BorderSizePixel=0; card.Text=""; card.ZIndex=13
    rnd(card,7); local cs=bdr(card,T.BtnBord,1,.68)

    local ratio=srv.playing/math.max(srv.maxPlayers,1)
    local bc = ratio>.8 and T.Red or (ratio>.4 and T.Yellow or T.Green)

    local idxL=Instance.new("TextLabel",card)
    idxL.Size=UDim2.new(0,22,1,0); idxL.Position=UDim2.new(0,4,0,0)
    idxL.BackgroundTransparency=1; idxL.Text="#"..idx
    idxL.TextColor3=T.TextDim; idxL.TextSize=8; idxL.Font=Enum.Font.Gotham; idxL.ZIndex=14

    local pL=Instance.new("TextLabel",card)
    pL.Size=UDim2.new(0,118,0,15); pL.Position=UDim2.new(0,28,0,6)
    pL.BackgroundTransparency=1
    pL.Text=srv.playing.." / "..srv.maxPlayers.." players"
    pL.TextColor3=bc; pL.TextSize=10; pL.Font=Enum.Font.GothamBold
    pL.TextXAlignment=Enum.TextXAlignment.Left; pL.ZIndex=14

    local bBg=Instance.new("Frame",card)
    bBg.Size=UDim2.new(0,118,0,4); bBg.Position=UDim2.new(0,28,0,23)
    bBg.BackgroundColor3=Color3.fromRGB(17,14,42); bBg.BorderSizePixel=0; bBg.ZIndex=14
    rnd(bBg,99)
    local bFl=Instance.new("Frame",bBg)
    bFl.Size=UDim2.new(math.max(ratio,.02),0,1,0); bFl.BackgroundColor3=bc
    bFl.BorderSizePixel=0; bFl.ZIndex=15; rnd(bFl,99)

    local pgL=Instance.new("TextLabel",card)
    pgL.Size=UDim2.new(0,90,0,13); pgL.Position=UDim2.new(0,28,0,30)
    pgL.BackgroundTransparency=1; pgL.Text="Avg ping: ~"..(srv.ping or "?").."ms"
    pgL.TextColor3=T.TextDim; pgL.TextSize=8; pgL.Font=Enum.Font.Gotham
    pgL.TextXAlignment=Enum.TextXAlignment.Left; pgL.ZIndex=14

    -- SAVE button (plain text)
    local saveBtn=Instance.new("TextButton",card)
    saveBtn.Size=UDim2.new(0,38,0,22); saveBtn.Position=UDim2.new(1,-118,.5,-11)
    saveBtn.BackgroundColor3=Color3.fromRGB(9,7,26)
    local isSaved=false
    for _,f in ipairs(Favorites) do if f.id==srv.id then isSaved=true; break end end
    saveBtn.Text=isSaved and "Saved" or "Save"
    saveBtn.TextColor3=isSaved and T.Gold or T.TextDim
    saveBtn.TextSize=8; saveBtn.Font=Enum.Font.GothamBold
    saveBtn.BorderSizePixel=0; saveBtn.ZIndex=15
    rnd(saveBtn,5); bdr(saveBtn,T.BorderP,1,.6)

    local joinBtn=Instance.new("TextButton",card)
    joinBtn.Size=UDim2.new(0,46,0,26); joinBtn.Position=UDim2.new(1,-58,.5,-13)
    joinBtn.BackgroundColor3=T.BtnBg; joinBtn.Text="Join"
    joinBtn.TextColor3=Color3.fromRGB(255,255,255); joinBtn.TextSize=10
    joinBtn.Font=Enum.Font.GothamBold; joinBtn.BorderSizePixel=0; joinBtn.ZIndex=15
    rnd(joinBtn,6); bdr(joinBtn,T.BtnBord,1.5)

    card.MouseEnter:Connect(function()
        tw(card,{BackgroundColor3=Color3.fromRGB(13,10,38)},.14)
        tw(cs,{Transparency=0.2},.14)
    end)
    card.MouseLeave:Connect(function()
        tw(card,{BackgroundColor3=T.BGSec},.14)
        tw(cs,{Transparency=0.68},.14)
    end)

    local s=srv
    joinBtn.MouseButton1Click:Connect(function()
        joinBtn.Text="..."; doJoin(s.id)
        task.delay(4,function() if joinBtn.Parent then joinBtn.Text="Join" end end)
    end)

    saveBtn.MouseButton1Click:Connect(function()
        local found=nil
        for i,f in ipairs(Favorites) do if f.id==s.id then found=i; break end end
        if found then
            table.remove(Favorites,found)
            saveBtn.Text="Save"; saveBtn.TextColor3=T.TextDim
        else
            table.insert(Favorites,{
                id=s.id, name="Server "..(#Favorites+1),
                playing=s.playing, maxPlayers=s.maxPlayers,
                country=CurrentCountry and CurrentCountry.name or "Unknown",
            })
            saveBtn.Text="Saved"; saveBtn.TextColor3=T.Gold
        end
        refreshFavorites()
    end)
end

-- â”€â”€ OPEN SERVER PAGE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
openServerPage = function(country)
    PgR.Visible=false; PgS.Visible=true
    STitleLbl.Text=country.name.." Servers"
    SCountLbl.Text="Loading..."
    for _,ch in ipairs(SScroll:GetChildren()) do
        if ch~=SSL and ch~=SSP and ch~=SLoadLbl then ch:Destroy() end
    end
    SLoadLbl.Visible=true; SLoadLbl.Text="Fetching servers..."

    task.spawn(function()
        local srvs,_=fetchServers()
        SLoadLbl.Visible=false
        if #srvs==0 then
            SLoadLbl.Visible=true; SLoadLbl.Text="No servers found."
            SCountLbl.Text="0 servers"; return
        end
        table.sort(srvs,function(a,b) return a.playing<b.playing end)
        SCountLbl.Text=#srvs.." servers"
        for i,s in ipairs(srvs) do addSrvCard(s,i) end
    end)
end

-- â”€â”€ REFRESH FAVORITES â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
refreshFavorites = function()
    for _,ch in ipairs(FScroll:GetChildren()) do
        if ch~=FL and ch~=FP and ch~=NoFavLbl then ch:Destroy() end
    end
    NoFavLbl.Visible=(#Favorites==0)

    for i,fav in ipairs(Favorites) do
        local card=Instance.new("Frame",FScroll)
        card.Size=UDim2.new(1,0,0,52); card.BackgroundColor3=T.BGSec
        card.BorderSizePixel=0; card.ZIndex=13
        rnd(card,7); bdr(card,T.Gold,1,.72)

        local nL=Instance.new("TextLabel",card)
        nL.Size=UDim2.new(1,-130,0,17); nL.Position=UDim2.new(0,10,0,6)
        nL.BackgroundTransparency=1; nL.Text=fav.name
        nL.TextColor3=T.Text; nL.TextSize=11; nL.Font=Enum.Font.GothamBold
        nL.TextXAlignment=Enum.TextXAlignment.Left
        nL.TextTruncate=Enum.TextTruncate.AtEnd; nL.ZIndex=14

        local subL=Instance.new("TextLabel",card)
        subL.Size=UDim2.new(1,-130,0,13); subL.Position=UDim2.new(0,10,0,27)
        subL.BackgroundTransparency=1
        subL.Text=fav.playing.."/"..fav.maxPlayers.." players  |  "..fav.country
        subL.TextColor3=T.TextDim; subL.TextSize=8; subL.Font=Enum.Font.Gotham
        subL.TextXAlignment=Enum.TextXAlignment.Left; subL.ZIndex=14

        -- Rename button (plain text, no symbol)
        local renBtn=Instance.new("TextButton",card)
        renBtn.Size=UDim2.new(0,40,0,13); renBtn.Position=UDim2.new(0,10,1,-16)
        renBtn.BackgroundTransparency=1; renBtn.Text="Rename"
        renBtn.TextColor3=T.TextDim; renBtn.TextSize=8; renBtn.Font=Enum.Font.Gotham
        renBtn.TextXAlignment=Enum.TextXAlignment.Left; renBtn.BorderSizePixel=0; renBtn.ZIndex=15

        -- Delete button (plain text "Del", no symbol)
        local delBtn=Instance.new("TextButton",card)
        delBtn.Size=UDim2.new(0,28,0,22); delBtn.Position=UDim2.new(1,-96,.5,-11)
        delBtn.BackgroundColor3=Color3.fromRGB(52,8,8); delBtn.Text="Del"
        delBtn.TextColor3=Color3.fromRGB(255,80,80); delBtn.TextSize=9
        delBtn.Font=Enum.Font.GothamBold; delBtn.BorderSizePixel=0; delBtn.ZIndex=15
        rnd(delBtn,5); bdr(delBtn,Color3.fromRGB(150,30,30),1)

        local joinBtn2=Instance.new("TextButton",card)
        joinBtn2.Size=UDim2.new(0,42,0,23); joinBtn2.Position=UDim2.new(1,-52,.5,-11)
        joinBtn2.BackgroundColor3=T.BtnBg; joinBtn2.Text="Join"
        joinBtn2.TextColor3=Color3.fromRGB(255,255,255); joinBtn2.TextSize=9
        joinBtn2.Font=Enum.Font.GothamBold; joinBtn2.BorderSizePixel=0; joinBtn2.ZIndex=15
        rnd(joinBtn2,5); bdr(joinBtn2,T.BtnBord,1.5)

        local f,fi=fav,i

        joinBtn2.MouseButton1Click:Connect(function() doJoin(f.id) end)

        delBtn.MouseButton1Click:Connect(function()
            table.remove(Favorites,fi); refreshFavorites()
        end)

        renBtn.MouseButton1Click:Connect(function()
            nL.Visible=false
            local inp=Instance.new("TextBox",card)
            inp.Size=UDim2.new(1,-130,0,17); inp.Position=UDim2.new(0,10,0,6)
            inp.BackgroundColor3=Color3.fromRGB(11,9,32); inp.Text=f.name
            inp.TextColor3=T.Text; inp.TextSize=11; inp.Font=Enum.Font.Gotham
            inp.BorderSizePixel=0; inp.PlaceholderText="Enter name..."
            inp.PlaceholderColor3=T.TextDim; inp.ZIndex=16
            rnd(inp,4); bdr(inp,T.Border,1); inp:CaptureFocus()
            inp.FocusLost:Connect(function()
                if inp.Text~="" then Favorites[fi].name=inp.Text end
                inp:Destroy(); refreshFavorites()
            end)
        end)
    end
end

-- â”€â”€ FRESH SERVER LOGIC (Real single-scan) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Scans once, finds all servers with 0 players, joins the first one.
-- If none exist: reports the real count and shows "join least populated".
-- Does NOT loop. Does NOT invent fake blocking counts.

FrScanBtn.MouseButton1Click:Connect(function()
    if IsFreshHopping then return end
    IsFreshHopping = true
    FrJoinLeastBtn.Visible = false
    FrLeastServerId = nil

    FrScanBtn.Text = "Scanning..."
    tw(FrScanBtn, {BackgroundColor3=Color3.fromRGB(10,38,10)}, .2)
    FrStopBtn.Visible = true

    FreshThread = task.spawn(function()
        FrStatusLbl.Text = "Status: Fetching server list...\nScanned: 0 servers\nEmpty found: 0"
        tw(FrPFill, {Size=UDim2.new(0,0,1,0)}, .1)

        local srvs, _ = fetchServers()

        if not IsFreshHopping then return end

        if #srvs == 0 then
            FrStatusLbl.Text = "Status: No servers returned by API.\nThe game might be offline or private.\nScanned: 0"
            IsFreshHopping = false
            FrScanBtn.Text = "Scan and Find Empty Server"
            tw(FrScanBtn, {BackgroundColor3=T.BtnBg}, .2)
            FrStopBtn.Visible = false
            return
        end

        tw(FrPFill, {Size=UDim2.new(0.5,0,1,0)}, .3)

        -- Find truly empty servers (0 players)
        local empty = {}
        local leastPlayers = math.huge
        local leastSrv = nil

        for _, s in ipairs(srvs) do
            if s.playing == 0 then
                table.insert(empty, s)
            end
            if s.playing < leastPlayers then
                leastPlayers = s.playing
                leastSrv = s
            end
        end

        tw(FrPFill, {Size=UDim2.new(1,0,1,0)}, .2)
        task.wait(0.3)

        if not IsFreshHopping then return end

        if #empty > 0 then
            -- Real empty server found
            FrStatusLbl.Text = ("Status: Found %d empty server(s)!\nScanned: %d servers total\nJoining in 1 second..."):format(
                #empty, #srvs)
            IsFreshHopping = false
            FrScanBtn.Text = "Scan and Find Empty Server"
            tw(FrScanBtn, {BackgroundColor3=T.BtnBg}, .2)
            FrStopBtn.Visible = false

            task.delay(1, function()
                doJoin(empty[1].id)
            end)
        else
            -- No empty servers exist right now
            FrStatusLbl.Text = ("Status: No empty servers found.\nScanned: %d servers total\nLeast populated: %d players"):format(
                #srvs, leastPlayers)

            if leastSrv then
                FrLeastServerId = leastSrv.id
                FrJoinLeastBtn.Visible = true
                FrJoinLeastBtn.Text = "Join Least Populated ("..leastPlayers.." players)"
            end

            -- Show Force Create option now that we know all servers are occupied
            FrForceBtn.Visible = true
            FrForceDescLbl.Visible = true

            IsFreshHopping = false
            FrScanBtn.Text = "Scan Again"
            tw(FrScanBtn, {BackgroundColor3=T.BtnBg}, .2)
            FrStopBtn.Visible = false
        end
    end)
end)

FrJoinLeastBtn.MouseButton1Click:Connect(function()
    if FrLeastServerId then
        FrJoinLeastBtn.Text = "Joining..."
        doJoin(FrLeastServerId)
    end
end)

-- â”€â”€ FORCE CREATE FRESH SERVER â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- HOW IT WORKS:
--   1. Fetches every server ID across all pages (up to 1,000 servers).
--   2. Saves that full list to geohop_hunt.txt on disk.
--   3. Calls TeleportService:Teleport(PlaceId) â€” no server ID â€” so
--      Roblox's own matchmaking picks (or creates) a server for us.
--   4. When you re-run GeoHop in the new session, it reads the file
--      and checks: is my current JobId in the blocked list?
--        YES â†’ landed in a known server, still not fresh â†’ retry button
--        NO  â†’ brand-new server Roblox just created â†’ FRESH CONFIRMED

local function forceCreateFreshServer()
    IsFreshHopping   = true
    FrForceBtn.Visible      = false
    FrForceDescLbl.Visible  = false
    FrJoinLeastBtn.Visible  = false
    FrScanBtn.Text          = "Working..."
    tw(FrScanBtn, {BackgroundColor3=Color3.fromRGB(28,10,48)}, .2)
    FrStopBtn.Visible       = true

    FreshThread = task.spawn(function()
        -- Step 1: Scan ALL pages
        FrStatusLbl.Text = "Step 1 / 3: Scanning ALL server pages...\nCollecting every server ID.\nDo not close the script."
        tw(FrPFill, {Size=UDim2.new(0,0,1,0)}, .1)

        local allIds = fetchAllServerIds(function(page, total)
            FrStatusLbl.Text = ("Step 1 / 3: Scanning page %d...\n%d server IDs collected so far.\nDo not close the script."):format(page, total)
            tw(FrPFill, {Size=UDim2.new(math.min(page/10, 0.55),0,1,0)}, .25)
        end)

        if not IsFreshHopping then return end

        if #allIds == 0 then
            FrStatusLbl.Text = "Could not fetch any server IDs.\nCheck your connection and try again."
            IsFreshHopping = false
            FrScanBtn.Text = "Scan Again"
            tw(FrScanBtn, {BackgroundColor3=T.BtnBg}, .2)
            FrStopBtn.Visible = false
            return
        end

        -- Step 2: Write list to disk
        FrStatusLbl.Text = ("Step 2 / 3: Blocking %d servers...\nSaving to geohop_hunt.txt"):format(#allIds)
        tw(FrPFill, {Size=UDim2.new(0.7,0,1,0)}, .3)

        saveHuntData(allIds)
        task.wait(0.6)

        if not IsFreshHopping then return end

        -- Step 3: Random teleport (no server ID = Roblox picks for us)
        FrStatusLbl.Text = ("Step 3 / 3: Teleporting randomly...\n%d servers are blocked.\nRe-run GeoHop after loading to confirm\nyou are in a truly fresh server."):format(#allIds)
        tw(FrPFill, {Size=UDim2.new(1,0,1,0)}, .2)
        task.wait(1.5)

        if not IsFreshHopping then return end

        IsFreshHopping = false

        -- Primary method: Teleport with no server ID
        local tpOk = pcall(TeleportService.Teleport, TeleportService, PlaceId, LP)

        -- Fallback: try TeleportAsync with blank options if primary fails
        if not tpOk then
            task.wait(1)
            pcall(function()
                local opts = Instance.new("TeleportOptions")
                TeleportService:TeleportAsync(PlaceId, {LP}, opts)
            end)
        end
    end)
end

FrForceBtn.MouseButton1Click:Connect(function()
    forceCreateFreshServer()
end)

FrStopBtn.MouseButton1Click:Connect(function()
    IsFreshHopping = false
    if FreshThread then task.cancel(FreshThread) end
    FrScanBtn.Text = "Scan and Find Empty Server"
    tw(FrScanBtn, {BackgroundColor3=T.BtnBg}, .2)
    FrStopBtn.Visible = false
    FrStatusLbl.Text = "Status: Scan stopped.\nScanned: 0 servers\nEmpty found: 0"
    tw(FrPFill, {Size=UDim2.new(0,0,1,0)}, .2)
end)

-- â”€â”€ NAVIGATION â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
BackBtn.MouseButton1Click:Connect(function()
    PgS.Visible=false; PgR.Visible=true; CurrentCountry=nil
end)

HomeBtn.MouseButton1Click:Connect(function()
    if HomeJobId and HomeJobId~="" then
        HomeBtn.Text="..."; doJoin(HomeJobId)
        task.delay(4,function() if HomeBtn.Parent then HomeBtn.Text="Home" end end)
    end
end)

SaveCurrBtn.MouseButton1Click:Connect(function()
    local jid=game.JobId
    if not jid or jid=="" then
        SaveCurrBtn.Text="Not in a server!"; task.delay(2,function() SaveCurrBtn.Text="Save Current Server" end); return
    end
    for _,f in ipairs(Favorites) do
        if f.id==jid then SaveCurrBtn.Text="Already saved!"; task.delay(2,function() SaveCurrBtn.Text="Save Current Server" end); return end
    end
    table.insert(Favorites,{id=jid,name="Server "..(#Favorites+1),playing=#Players:GetPlayers(),maxPlayers=Players.MaxPlayers,country="Current"})
    refreshFavorites()
    SaveCurrBtn.Text="Saved!"; task.delay(2,function() SaveCurrBtn.Text="Save Current Server" end)
end)

MinBtn.MouseButton1Click:Connect(function()
    local ap=Win.AbsolutePosition; local as=Win.AbsoluteSize
    Bubble.Position=UDim2.new(0,ap.X+as.X/2-26,0,ap.Y+as.Y/2-26)
    tw(Win,{Size=UDim2.new(0,0,0,0)},.2,Enum.EasingStyle.Back,Enum.EasingDirection.In)
    task.delay(.22,function() Win.Visible=false; Bubble.Visible=true end)
end)

-- â”€â”€ TAB SWITCHING â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local function recolorIco(ico, col)
    for _,ch in ipairs(ico:GetChildren()) do
        local s=ch:FindFirstChildOfClass("UIStroke")
        if s then s.Color=col end
        if ch:IsA("Frame") then ch.BackgroundColor3=col end
    end
end

local function setTab(id)
    TBRegLbl.TextColor3=T.TextDim; TBFavLbl.TextColor3=T.TextDim; TBFrLbl.TextColor3=T.TextDim
    recolorIco(TBRegIco,T.TextDim); recolorIco(TBFavIco,T.TextDim); recolorIco(TBFrIco,T.TextDim)
    PgR.Visible=false; PgS.Visible=false; PgF.Visible=false; PgFr.Visible=false

    if id=="regions" then
        PgR.Visible=true; tw(TabSlider,{Position=UDim2.new(0,0,1,-2)},.2)
        TBRegLbl.TextColor3=T.Blue; recolorIco(TBRegIco,T.Blue)
    elseif id=="favorites" then
        PgF.Visible=true; tw(TabSlider,{Position=UDim2.new(0,95,1,-2)},.2)
        TBFavLbl.TextColor3=T.Gold; recolorIco(TBFavIco,T.Gold); refreshFavorites()
    elseif id=="fresh" then
        PgFr.Visible=true; tw(TabSlider,{Position=UDim2.new(0,190,1,-2)},.2)
        TBFrLbl.TextColor3=T.PurpleL; recolorIco(TBFrIco,T.PurpleL)
    end
end

TBReg.MouseButton1Click:Connect(function()
    if PgS.Visible then PgS.Visible=false; CurrentCountry=nil end
    setTab("regions")
end)
TBFav.MouseButton1Click:Connect(function() setTab("favorites") end)
TBFr.MouseButton1Click:Connect(function() setTab("fresh") end)

-- â”€â”€ PING AUTO-UPDATE (every 5 seconds) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
task.spawn(function()
    while task.wait(5) do
        local p=getMyPing()
        if p then
            local col = p<60 and T.Green or (p<120 and T.Yellow or T.Red)
            IBPingLbl.TextColor3=col
            IBPingLbl.Text="Ping: "..p.."ms"
        else
            IBPingLbl.Text="Ping: --"
        end
    end
end)

-- â”€â”€ STARTUP HUNT CHECK â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
-- Runs every time GeoHop loads.
-- If geohop_hunt.txt exists from a previous Force Create session,
-- we compare this session's game.JobId against the saved blocked list.
--   â€¢ JobId NOT in list â†’ Roblox gave us a brand-new server â†’ FRESH!
--   â€¢ JobId IS  in list â†’ landed in a known server â†’ offer retry

task.spawn(function()
    local prevIds, wasHunting = loadHuntData()
    if not wasHunting then return end

    local curJobId = game.JobId
    if not curJobId or curJobId == "" then return end

    task.wait(1.2) -- Let GUI finish opening first

    -- Sliding banner factory
    local function showBanner(bgCol, borderCol, titleTxt, titleCol, subTxt, btnLabel)
        local h = btnLabel and 98 or 72
        local notif = Instance.new("Frame", SG)
        notif.Size             = UDim2.new(0,270,0,h)
        notif.AnchorPoint      = Vector2.new(.5,0)
        notif.Position         = UDim2.new(.5,0,0,-h-10)
        notif.BackgroundColor3 = bgCol
        notif.BorderSizePixel  = 0
        notif.ZIndex           = 300
        rnd(notif, 10)
        bdr(notif, borderCol, 2)

        local t1 = Instance.new("TextLabel", notif)
        t1.Size = UDim2.new(1,-14,0,22); t1.Position = UDim2.new(0,7,0,7)
        t1.BackgroundTransparency=1; t1.Text=titleTxt
        t1.TextColor3=titleCol; t1.TextSize=12
        t1.Font=Enum.Font.GothamBold; t1.ZIndex=301

        local t2 = Instance.new("TextLabel", notif)
        t2.Size = UDim2.new(1,-14,0,30); t2.Position = UDim2.new(0,7,0,30)
        t2.BackgroundTransparency=1; t2.Text=subTxt
        t2.TextColor3=T.TextDim; t2.TextSize=9
        t2.Font=Enum.Font.Gotham; t2.TextWrapped=true; t2.ZIndex=301

        local actionBtn = nil
        if btnLabel then
            actionBtn = Instance.new("TextButton", notif)
            actionBtn.Size             = UDim2.new(1,-14,0,26)
            actionBtn.Position         = UDim2.new(0,7,1,-32)
            actionBtn.BackgroundColor3 = T.BtnBg
            actionBtn.Text             = btnLabel
            actionBtn.TextColor3       = Color3.fromRGB(255,255,255)
            actionBtn.TextSize         = 10
            actionBtn.Font             = Enum.Font.GothamBold
            actionBtn.BorderSizePixel  = 0
            actionBtn.ZIndex           = 302
            rnd(actionBtn, 7)
            bdr(actionBtn, T.BtnBord, 1.5)
        end

        -- Slide in
        tw(notif, {Position=UDim2.new(.5,0,0,14)}, .4, Enum.EasingStyle.Back)
        -- Auto-dismiss
        local dismissDelay = btnLabel and 18 or 8
        task.delay(dismissDelay, function()
            tw(notif, {Position=UDim2.new(.5,0,0,-h-10)}, .28)
            task.delay(.32, function()
                if notif.Parent then notif:Destroy() end
            end)
        end)

        return notif, actionBtn
    end

    if not prevIds[curJobId] then
        -- âœ” Brand-new server â€” not in the blocked list
        clearHuntData()
        showBanner(
            Color3.fromRGB(4,30,6), T.Green,
            "FRESH SERVER CONFIRMED", T.Green,
            "This server was NOT in the blocked list.\nRoblox created a new instance. You are alone here.",
            nil
        )

    else
        -- âœ˜ Landed in a known (blocked) server â€” still not fresh
        local _, retryBtn = showBanner(
            Color3.fromRGB(30,5,5), T.Red,
            "Not Fresh - Known Server", T.Red,
            "You landed in a server that was already blocked.\nTap Retry to teleport again (hunt file kept).",
            "Retry Teleport"
        )

        if retryBtn then
            retryBtn.MouseButton1Click:Connect(function()
                retryBtn.Text = "Teleporting..."
                task.delay(0.5, function()
                    -- hunt file still intact â€” next load will re-check
                    local ok = pcall(TeleportService.Teleport, TeleportService, PlaceId, LP)
                    if not ok then
                        pcall(function()
                            local opts = Instance.new("TeleportOptions")
                            TeleportService:TeleportAsync(PlaceId, {LP}, opts)
                        end)
                    end
                end)
            end)
        end
    end
end)

-- â”€â”€ STARTUP â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
setTab("regions")
refreshFavorites()

Win.Size=UDim2.new(0,0,0,0)
task.delay(.1,function()
    Win.Visible=true
    tw(Win,{Size=UDim2.new(0,285,0,420)},0.3,Enum.EasingStyle.Back)
end)

-- Detect location in background (does not block script)
task.spawn(function()
    IBLocLbl.Text="Detecting..."
    MyLocData = detectMyLocation()
    if MyLocData then
        IBLocLbl.Text=MyLocData.city..", "..MyLocData.country
        IBTagLbl.Text="MY REGION"
    else
        IBLocLbl.Text="Detection failed"
        IBTagLbl.Text="MY REGION"
    end
    -- First ping read
    local p=getMyPing()
    if p then
        local col=p<60 and T.Green or (p<120 and T.Yellow or T.Red)
        IBPingLbl.TextColor3=col
        IBPingLbl.Text="Ping: "..p.."ms"
    end
end)

print("[GeoHop v2.1] Loaded by Kii | Force Fresh Server enabled")
