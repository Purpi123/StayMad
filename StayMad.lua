local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/UI-Libraries/main/Neverlose/source.lua"))()
-- Toggle UI: Library:Toggle()

local Window = Library:Window({
    text = "StayMad.wtf"
})

local TabSection = Window:TabSection({
    text = "StayMad"
})

local maintab = Window:TabSection({
    text = "Main"
})

local Tab = TabSection:Tab({
    text = "Welcome",
    icon = "rbxassetid://7999345313",
})

local Section = Tab:Section({
    text = "StayMad"
})

Section:Button({
    text     = "Made By Purpi",
    callback = function()
        print("Clicked button")
    end,
})

Section:Button({
    text     = "Works Best On Zonic",
    callback = function()
        print("Clicked button")
    end,
})





local TabMAIN = maintab:Tab({
    text = "Visuals",
    icon = "rbxassetid://7999345313",
})

local ChamsSection = TabMAIN:Section({
    text = "Chams"
})

local espColorChams = Color3.new(0, 0, 1) -- Default color (green)
local chamsEnabled  = false

ChamsSection:Toggle({
    text     = "Chams",
    state    = false, -- Default boolean
    callback = function(state)
       chamsEnabled = state
        
        -- Define a function to create Chams ESP for a character
        local function createChams(character)
            if character:FindFirstChild("Head") then
                if not character:FindFirstChild("ESPHighlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = character
                    highlight.Name = "ESPHighlight"
                    highlight.Adornee = character
                    highlight.FillColor = espColorChams
                    highlight.OutlineColor = espColorChams
                end
            end
        end

        -- Define a function to remove Chams ESP from a character
        local function removeChams(character)
            if character:FindFirstChild("ESPHighlight") then
                character.ESPHighlight:Destroy()
            end
        end

        -- Define a function to apply Chams ESP to all players
        local function applyChamsToAllPlayers()
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    createChams(player.Character)
                end
                player.CharacterAdded:Connect(function(character)
                    createChams(character)
                end)
            end
        end

        -- Define a function to remove Chams ESP from all players
        local function removeChamsFromAllPlayers()
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    removeChams(player.Character)
                end
            end
        end

        -- Start a loop to continuously apply Chams ESP if enabled
        spawn(function()
            while chamsEnabled do
                removeChamsFromAllPlayers()
                applyChamsToAllPlayers()
                wait(1)
            end
        end)

        -- Remove Chams ESP if disabled
        if not chamsEnabled then
            removeChamsFromAllPlayers()
        end

    end
})

ChamsSection:Colorpicker({
    text     = "Color",
    color    = Color3.new(1,1,1),
    callback = function(color)
        espColorChams = color
        -- If Chams ESP is already enabled, update the color for all characters
        if chamsEnabled then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    removeChams(player.Character)
                    createChams(player.Character)
                end
            end
        end
    end
    
    
})

local FOVSection = TabMAIN:Section({
    text = "FOV Settings"
})

-- Variabel för att hålla reda på nuvarande FOV
local defaultFOV = 70 -- Standardvärdet för FOV
local currentFOV = game.Workspace.CurrentCamera.FieldOfView -- Hämta nuvarande FOV från kameran

-- Funktion för att uppdatera FOV
local function updateFOV(fov)
    game.Workspace.CurrentCamera.FieldOfView = fov
end

-- Slider för att justera FOV
FOVSection:Slider({
    text = "Adjust FOV",
    min = 50, -- Minsta FOV-värde
    max = 120, -- Största FOV-värde
    value = currentFOV, -- Sätter startvärdet till nuvarande FOV
    callback = function(value)
        currentFOV = value
        updateFOV(currentFOV) -- Uppdatera kamerans FOV baserat på slidervärdet
    end
})

-- Knapp för att återställa FOV till standardvärdet
FOVSection:Button({
    text = "Reset FOV",
    callback = function()
        currentFOV = defaultFOV
        updateFOV(defaultFOV) -- Återställ kamerans FOV till standardvärdet
    end
})

local NamesSection = TabMAIN:Section({
    text = "Names"
})

local espColorName   = Color3.new(0, 0, 1)
local nameEspEnabled = false

NamesSection:Toggle({
    text     = "Names",
    state    = false, -- Default boolean
    callback = function(state)
       nameEspEnabled = state
        
        -- Define a function to create the Name ESP for a character
        local function createNameEsp(character)
            if character:FindFirstChild("Humanoid") and character:FindFirstChild("Head") then
                local head = character.Head
                if head:FindFirstChild("NameEsp") then return end

                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "NameEsp"
                billboardGui.AlwaysOnTop = true
                billboardGui.Size = UDim2.new(2, 0, 1, 0)
                billboardGui.StudsOffset = Vector3.new(0, 2, 0) -- Adjust this value to move the label above the head
                billboardGui.Adornee = head

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = character.Name -- Display the player's username
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.TextColor3 = espColorName
                textLabel.BackgroundTransparency = 1
                textLabel.TextStrokeTransparency = 0.5
                textLabel.Parent = billboardGui

                billboardGui.Parent = head
            end
        end

        -- Define a function to remove Name ESP from a character
        local function removeNameEsp(character)
            if character:FindFirstChild("Head") then
                local head = character.Head
                if head:FindFirstChild("NameEsp") then
                    head.NameEsp:Destroy()
                end
            end
        end

        -- Define a function to apply Name ESP to all players
        local function applyNameEspToAllPlayers()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    createNameEsp(player.Character)
                end
                player.CharacterAdded:Connect(function(character)
                    createNameEsp(character)
                end)
            end
        end

        -- Define a function to remove Name ESP from all players
        local function removeNameEspFromAllPlayers()
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character then
                    removeNameEsp(player.Character)
                end
            end
        end

        -- Start a loop to continuously apply Name ESP if enabled
        spawn(function()
            while nameEspEnabled do
                removeNameEspFromAllPlayers()
                applyNameEspToAllPlayers()
                wait(1)
            end
        end)

        -- Remove Name ESP if disabled
        if not nameEspEnabled then
            removeNameEspFromAllPlayers()
        end

    end
})

NamesSection:Colorpicker({
    text     = "Color",
    color    = Color3.new(1,1,1),
    callback = function(color)
        espColorName = color
    end
    
    
})


local EnvironmentSection = TabMAIN:Section({
    text = "Environment"
})

-- Variabler för miljöinställningar
local currentBrightness = game.Lighting.Brightness
local currentTimeOfDay = game.Lighting.TimeOfDay
local currentOutdoorAmbient = game.Lighting.OutdoorAmbient
local currentGlobalShadows = game.Lighting.GlobalShadows

-- Funktioner för att uppdatera Lighting-inställningar
local function updateBrightness(value)
    game.Lighting.Brightness = value
end

local function updateTimeOfDay(value)
    game.Lighting.TimeOfDay = value
end

local function updateOutdoorAmbient(color)
    game.Lighting.OutdoorAmbient = color
end

local function updateGlobalShadows(state)
    game.Lighting.GlobalShadows = state
end

-- Slider för Brightness (Ljusstyrka)
EnvironmentSection:Slider({
    text = "Brightness",
    min = 0, -- Min brightness
    max = 10, -- Max brightness
    value = currentBrightness,
    callback = function(value)
        currentBrightness = value
        updateBrightness(currentBrightness) -- Uppdaterar ljusstyrkan
    end
})

-- Slider för Time of Day (Tid på dagen)
EnvironmentSection:Slider({
    text = "Time of Day",
    min = 0, -- Min tid
    max = 24, -- Max tid (24-timmars format)
    value = tonumber(currentTimeOfDay),
    callback = function(value)
        currentTimeOfDay = tostring(math.floor(value)) .. ":00:00" -- Ändrar tiden till hela timmar
        updateTimeOfDay(currentTimeOfDay)
    end
})

-- Colorpicker för Outdoor Ambient
EnvironmentSection:Colorpicker({
    text = "Outdoor Ambient",
    color = currentOutdoorAmbient, -- Nuvarande färg
    callback = function(color)
        currentOutdoorAmbient = color
        updateOutdoorAmbient(currentOutdoorAmbient) -- Uppdaterar Outdoor Ambient-färgen
    end
})

-- Toggle för Global Shadows
EnvironmentSection:Toggle({
    text = "Global Shadows",
    state = currentGlobalShadows, -- Nuvarande skugginställning
    callback = function(state)
        currentGlobalShadows = state
        updateGlobalShadows(currentGlobalShadows) -- Aktiverar/inaktiverar globala skuggor
    end
})

-- Knapp för att återställa Lighting-inställningarna till standard
EnvironmentSection:Button({
    text = "Reset Lighting",
    callback = function()
        -- Återställ till standardvärden
        currentBrightness = 2
        currentTimeOfDay = "14:00:00"
        currentOutdoorAmbient = Color3.new(0.5, 0.5, 0.5) -- Standard grå färg
        currentGlobalShadows = true
        
        updateBrightness(currentBrightness)
        updateTimeOfDay(currentTimeOfDay)
        updateOutdoorAmbient(currentOutdoorAmbient)
        updateGlobalShadows(currentGlobalShadows)
    end
})

local MiscVSection = TabMAIN:Section({
    text = "Misc"
})


MiscVSection:Button({
    text     = "Radar",
    callback = function()
        --- Drawing Player Radar
--- Made by topit

_G.RadarSettings = {
    --- Radar settings
    RADAR_LINES = true; -- Displays distance rings + cardinal lines 
    RADAR_LINE_DISTANCE = 50; -- The distance between each distance ring
    RADAR_SCALE = 1; -- Controls how "zoomed in" the radar display is 
    RADAR_RADIUS = 125; -- The size of the radar itself
    RADAR_ROTATION = true; -- Toggles radar rotation. Looks kinda trippy when disabled
    SMOOTH_ROT = true; -- Toggles smooth radar rotation
    SMOOTH_ROT_AMNT = 30; -- Lower number is smoother, higher number is snappier 
    CARDINAL_DISPLAY = true; -- Displays the four cardinal directions (north east south west) around the radar
    
    --- Marker settings
    DISPLAY_OFFSCREEN = true; -- Displays offscreen / off-radar markers
    DISPLAY_TEAMMATES = true; -- Displays markers that belong to your teammates
    DISPLAY_TEAM_COLORS = true; -- Displays your teammates markers with either a custom color (change Team_Marker) or with that teams TeamColor (enable USE_TEAM_COLORS) 
    DISPLAY_FRIEND_COLORS = true; -- Displays your friends markers with a custom color (Friend_Marker). This takes priority over DISPLAY_TEAM_COLORS and DISPLAY_RGB
    DISPLAY_RGB_COLORS = false; -- Displays each marker with an RGB cycle. Takes priority over DISPLAY_TEAM_COLORS, but not DISPLAY_FRIEND_COLORS
    MARKER_SCALE_BASE = 1.25; -- Base scale that gets applied to markers
    MARKER_SCALE_MAX = 1.25; -- The largest scale that a marker can be
    MARKER_SCALE_MIN = 0.75; -- The smallest scale that a marker can be
    MARKER_FALLOFF = true; -- Affects the markers' scale depending on how far away the player is - bypasses SCALE_MIN and SCALE_MAX
    MARKER_FALLOFF_AMNT = 125; -- How close someone has to be for falloff to start affecting them 
    OFFSCREEN_TRANSPARENCY = 0.3; -- Transparency of offscreen markers
    USE_FALLBACK = false; -- Enables an emergency "fallback mode" for StreamingEnabled games
    USE_QUADS = true; -- Displays radar markers as arrows instead of dots 
    USE_TEAM_COLORS = false; -- Uses a team's TeamColor for marker colors
    VISIBLITY_CHECK = false; -- Makes markers that are not visible slightly transparent 
    
    --- Theme
    RADAR_THEME = {
        Outline = Color3.fromRGB(35, 35, 45); -- Radar outline
        Background = Color3.fromRGB(25, 25, 35); -- Radar background
        DragHandle = Color3.fromRGB(50, 50, 255); -- Drag handle 
        
        Cardinal_Lines = Color3.fromRGB(110, 110, 120); -- Color of the horizontal and vertical lines
        Distance_Lines = Color3.fromRGB(65, 65, 75); -- Color of the distance rings
        
        Generic_Marker = Color3.fromRGB(255, 25, 115); -- Color of a player marker without a team
        Local_Marker = Color3.fromRGB(115, 25, 255); -- Color of your marker, regardless of team
        Team_Marker = Color3.fromRGB(25, 115, 255); -- Color of your teammates markers. Used when DISPLAY_TEAM_COLORS is disabled
        Friend_Marker = Color3.fromRGB(25, 255, 115); -- Color of your friends markers. Used when DISPLAY_FRIEND_COLORS is enabled 
    };
}

loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/stuff/main/PlayerRadar/source.lua'))()
    end,
})



local FOVEspSection = TabMAIN:Section({
    text = "FOV Esp"
})

local Drawing = Drawing or {} -- Use the Drawing API
local fovCircle = nil         -- Variable for the FOV circle
local fovSize = 200           -- Default FOV size
local isFovEnabled = false    -- Track whether the FOV toggle is on or off
local showDetections = false  -- Track if we are showing detections (ESP)
local espLines = {}           -- Table to store ESP lines

-- Function to create or update the FOV circle
local function updateFOVCircle()
    if not fovCircle then
        -- Create the circle if it doesn't exist
        fovCircle = Drawing.new("Circle")
        fovCircle.Color = Color3.fromRGB(0, 0, 255)  -- Blue color by default
        fovCircle.Thickness = 2
        fovCircle.Transparency = 1
        fovCircle.Filled = false
    end
    -- Update the circle's size and position
    fovCircle.Radius = fovSize
    fovCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
    fovCircle.Visible = true  -- Show the circle when FOV is on
end

-- Function to remove the FOV circle
local function removeFOVCircle()
    if fovCircle then
        fovCircle.Visible = false
    end
end

-- Function to check if a player is within the FOV circle
local function isPlayerInFOV(player)
    local camera = workspace.CurrentCamera
    local playerPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position
    if playerPos then
        local screenPos, onScreen = camera:WorldToViewportPoint(playerPos)
        local fovCenter = Vector2.new(camera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
        local distanceFromCenter = (Vector2.new(screenPos.X, screenPos.Y) - fovCenter).Magnitude
        return onScreen and distanceFromCenter <= fovSize
    end
    return false
end

-- Function to create a line from the center of the screen to a player
local function createESPLine(player)
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(0, 255, 0)  -- Green color for the ESP
    line.Thickness = 2
    line.Transparency = 1
    espLines[player] = line
end

-- Function to update the ESP line position
local function updateESPLine(player)
    local line = espLines[player]
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and line then
        local hrpPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
        if onScreen then
            -- Set the starting point (center of the screen)
            local fovCenter = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
            line.From = fovCenter
            -- Set the ending point (player's position)
            line.To = Vector2.new(hrpPos.X, hrpPos.Y)
            line.Visible = true
        else
            line.Visible = false
        end
    end
end

-- Function to remove ESP line
local function removeESPLine(player)
    if espLines[player] then
        espLines[player]:Remove()
        espLines[player] = nil
    end
end

-- Update ESP lines for all players in FOV
local function updateDetections()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= game.Players.LocalPlayer and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if isPlayerInFOV(otherPlayer) then
                if not espLines[otherPlayer] then
                    createESPLine(otherPlayer)
                end
                updateESPLine(otherPlayer)
            else
                removeESPLine(otherPlayer)  -- Remove line if player is not in FOV
            end
        end
    end
end

-- Remove ESP line if a player leaves the game
game.Players.PlayerRemoving:Connect(function(player)
    removeESPLine(player)  -- Remove the line if the player leaves
end)

-- Toggle to draw the FOV circle
FOVEspSection:Toggle({
    text     = "Draw FOV",
    state    = false, -- Default state (off)
    callback = function(state)
        isFovEnabled = state  -- Track the state of the toggle
        if state then
            updateFOVCircle()  -- Show and update the circle when toggled on
        else
            removeFOVCircle()  -- Hide the circle when toggled off
        end
    end
})

-- Slider to adjust the FOV size
FOVEspSection:Slider({
    text     = "FOV Size",
    min      = 40,
    max      = 400,
    callback = function(size)
        fovSize = size  -- Update the FOV size based on the slider
        if isFovEnabled and fovCircle then  -- Only update the circle if the toggle is on
            updateFOVCircle()  -- Update the circle's size dynamically
        end
    end
})

-- Toggle to show player detections (ESP with lines)
FOVEspSection:Toggle({
    text     = "Show Detections",
    state    = false, -- Default boolean
    callback = function(state)
        showDetections = state
        if showDetections then
            -- Start checking and updating ESP when enabled
            game:GetService("RunService").RenderStepped:Connect(function()
                if showDetections then
                    updateDetections()
                else
                    -- When toggled off, remove all ESP lines
                    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                        removeESPLine(otherPlayer)
                    end
                end
            end)
        else
            -- Remove all ESP lines when detection is toggled off
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                removeESPLine(otherPlayer)
            end
        end
    end
})

local TracersSection = TabMAIN:Section({
    text = "Tracers"
})

-- Variables for tracer settings
local showTracers = false
local startPosition = "Bottom"
local tracerColor = Color3.new(1, 1, 1)
local offScreenTracers = false -- Toggle for tracers to show off-screen players
local tracers = {}

-- Function to create a tracer (line)
local function createTracer(player)
    local line = Drawing.new("Line")
    line.Thickness = 2
    line.Color = tracerColor
    line.Transparency = 1
    tracers[player] = line
end

-- Function to calculate the off-screen position
local function getOffScreenPosition(hrpPos)
    local camera = workspace.CurrentCamera
    local viewportSize = camera.ViewportSize
    local screenPos = camera:WorldToViewportPoint(hrpPos)

    -- Clamp the screen position to the edges of the viewport
    local clampedX = math.clamp(screenPos.X, 0, viewportSize.X)
    local clampedY = math.clamp(screenPos.Y, 0, viewportSize.Y)

    return Vector2.new(clampedX, clampedY)
end

-- Function to update a tracer's position
local function updateTracer(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and tracers[player] then
        local camera = workspace.CurrentCamera
        local hrpPos, onScreen = camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)

        -- Set the tracer's start position based on the selected option
        local startPos
        if startPosition == "Bottom" then
            startPos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
        elseif startPosition == "Top" then
            startPos = Vector2.new(camera.ViewportSize.X / 2, 0)
        elseif startPosition == "Left" then
            startPos = Vector2.new(0, camera.ViewportSize.Y / 2)
        elseif startPosition == "Right" then
            startPos = Vector2.new(camera.ViewportSize.X, camera.ViewportSize.Y / 2)
        elseif startPosition == "Mouse" then
            local mousePos = game.Players.LocalPlayer:GetMouse()
            startPos       = Vector2.new(mousePos.X, mousePos.Y + 60) -- Start position 20 pixels below the mouse
        elseif startPosition == "Center" then
            startPos = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
        end

        if onScreen then
            -- Draw tracer to the player's position if on-screen
            tracers[player].From = startPos
            tracers[player].To = Vector2.new(hrpPos.X, hrpPos.Y)
            tracers[player].Visible = true
        else
            if offScreenTracers then
                -- Draw tracer to the edge of the screen if player is off-screen
                local edgePos = getOffScreenPosition(player.Character.HumanoidRootPart.Position)
                tracers[player].From = startPos
                tracers[player].To = edgePos
                tracers[player].Visible = true
            else
                -- Hide tracer if the player is off-screen and offScreenTracers is disabled
                tracers[player].Visible = false
            end
        end
    end
end

-- Function to remove a tracer when a player leaves
local function removeTracer(player)
    if tracers[player] then
        tracers[player]:Remove()
        tracers[player] = nil
    end
end

-- Toggle to show/hide tracers
TracersSection:Toggle({
    text     = "Tracers",
    state    = false,
    callback = function(state)
        showTracers = state
        if not showTracers then
            -- Remove all tracers when toggled off
            for _, tracer in pairs(tracers) do
                tracer:Remove()
            end
            tracers = {}
        else
            -- Continuously update tracers when toggled on
            game:GetService("RunService").RenderStepped:Connect(function()
                if showTracers then
                    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                        if otherPlayer ~= game.Players.LocalPlayer then
                            if not tracers[otherPlayer] then
                                createTracer(otherPlayer)
                            end
                            updateTracer(otherPlayer)
                        end
                    end
                end
            end)
        end
    end
})

-- Dropdown to select tracer start position
TracersSection:Dropdown({
    text     = "Start Position",
    list     = {"Bottom", "Top", "Left", "Right", "Mouse", "Center"},
    default  = "Bottom",
    callback = function(option)
        startPosition = option -- Update the tracer's start position
    end
})

-- Colorpicker to change tracer color
TracersSection:Colorpicker({
    text     = "Color",
    color    = Color3.new(1,1,1),
    callback = function(color)
        tracerColor = color -- Update tracer color
        for _, line in pairs(tracers) do
            line.Color = color
        end
    end
})

-- Toggle to show off-screen tracers
TracersSection:Toggle({
    text     = "Off Screen Tracers",
    state    = false, -- Default is false (do not show off-screen tracers)
    callback = function(state)
        offScreenTracers = state -- Update the state of off-screen tracers
    end
})

-- Clean up tracers when players leave the game
game.Players.PlayerRemoving:Connect(function(player)
    removeTracer(player)
end)



local TabLocal = maintab:Tab({
    text = "Local",
    icon = "rbxassetid://7999345313",
})

local WalkSection = TabLocal:Section({
    text = "Walking"
})

-- Default WalkSpeed
local defaultWalkSpeed =  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed

WalkSection:Slider({
    text = "WalkSpeed",
    min  = 0,
    max  = 500,
    -- Set default walk speed as 16 (the default in Roblox)
    value = defaultWalkSpeed,
    callback = function(walkSpeedValue)
        -- Set the player's walk speed to the slider value
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeedValue
    end
})

WalkSection:Button({
    text = "Reset to Default WalkSpeed",
    callback = function()
        -- Reset the player's walk speed to the default value (16)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = defaultWalkSpeed
    end
})


local JumpSection = TabLocal:Section({
    text = "Jumping"
})

JumpSection:Toggle({
    text     = "Infinite Jump",
    state    = false, -- Default boolean
    callback = function(state)
        if (state) == true then
-- Infinite Jump Enable Script
_G.InfiniteJumpEnabled = true

-- Function to handle jumping
local function onJumpRequest()
    if _G.InfiniteJumpEnabled then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end

-- Bind the function to the JumpRequest event
if not _G.JumpConnection then
    _G.JumpConnection = game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)
end

print("Infinite Jump Enabled")

        else
-- Infinite Jump Disable Script
_G.InfiniteJumpEnabled = false

-- Unbind the JumpRequest event if it exists
if _G.JumpConnection then
    _G.JumpConnection:Disconnect()
    _G.JumpConnection = nil
end

print("Infinite Jump Disabled")

    end
    end
})

-- Default WalkSpeed
local defaultJumpPower = game.Players.LocalPlayer.Character.Humanoid.JumpPower

JumpSection:Slider({
    text = "JumpPower",
    min  = 0,
    max  = 500,
    -- Set default walk speed as 16 (the default in Roblox)
    value    = defaultJumpPower,
    callback = function(jumpPowerValue)
        -- Set the player's walk speed to the slider value
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPowerValue
    end
})

JumpSection:Button({
    text     = "Reset to Default JumpPower",
    callback = function()
        -- Reset the player's walk speed to the default value (16)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = defaultJumpPower
    end
})


local HealthSection = TabLocal:Section({
    text = "Health"
})

HealthSection:Slider({
    text = "Health [CS]",
    min  = 1,
    max  = 100,
    -- Set default walk speed as 16 (the default in Roblox)
    value    = game.Players.LocalPlayer.Character.Humanoid.Health,
    callback = function(healthValue)
        -- Set the player's walk speed to the slider value
        game.Players.LocalPlayer.Character.Humanoid.Health = healthValue
    end
})

HealthSection:Button({
    text                                               = "Force Reset",
    callback                                           = function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})


local FlySection = TabLocal:Section({
    text = "Flying"
})

local flyspeeed = 20

FlySection:Toggle({
    text     = "Flight",
    state    = false, -- Default boolean
    callback = function(state)
        if (state) == true then
-- Fly Script with Camera-Aligned Movement and Stable Orientation
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local torso = character:WaitForChild("HumanoidRootPart")
local flying = false
local speed = flyspeeed
local camera = game.Workspace.CurrentCamera
local keysPressed = {}

local function startFlying()
    local bg = Instance.new("BodyGyro", torso)
    bg.MaxTorque = Vector3.new(4000, 4000, 4000)
    bg.P = 20000 -- Proportional gain to stabilize orientation
    
    local bv = Instance.new("BodyVelocity", torso)
    bv.MaxForce = Vector3.new(4000, 4000, 4000)
    bv.Velocity = Vector3.new(0, 0, 0)
    
    flying = true
    humanoid.PlatformStand = true
    
    local function updateVelocity()
    speed = flyspeeed
        local moveDirection = Vector3.new(0, 0, 0)
        local forwardDirection = camera.CFrame.lookVector
        local rightDirection = camera.CFrame.rightVector
        
        if keysPressed["W"] then
            moveDirection = forwardDirection
        elseif keysPressed["S"] then
            moveDirection = -forwardDirection
        end
        
        if keysPressed["A"] then
            moveDirection = moveDirection - rightDirection
        elseif keysPressed["D"] then
            moveDirection = moveDirection + rightDirection
        end
        
        moveDirection = moveDirection.unit * speed
        bv.Velocity = moveDirection
        
        -- Update BodyGyro to stabilize orientation
        bg.CFrame = CFrame.new(torso.Position, torso.Position + forwardDirection)
    end
    
    local function updateFlight()
    speed = flyspeeed
        while flying do
            if keysPressed["W"] or keysPressed["S"] or keysPressed["A"] or keysPressed["D"] then
                updateVelocity()
            else
                bv.Velocity = Vector3.new(0, 0, 0) -- Constant upward velocity when no movement keys are pressed
            end
            wait()
        end
        
        bv:Destroy()
        bg:Destroy()
        humanoid.PlatformStand = false
    end
    
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            keysPressed[input.KeyCode.Name] = true
            updateVelocity()
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            keysPressed[input.KeyCode.Name] = nil
            updateVelocity()
        end
    end)
    
    updateFlight()
end

startFlying()




        else
-- Unfly Script
local player = game.Players.LocalPlayer
local character = player.Character

if character then
    local torso = character:FindFirstChild("HumanoidRootPart")
    if torso then
        for _, instance in ipairs(torso:GetChildren()) do
            if instance:IsA("BodyVelocity") or instance:IsA("BodyGyro") then
                instance:Destroy()
            end
        end
        player.Character.Humanoid.PlatformStand = false
    end
end





        end
    end
})

-- Default WalkSpeed

FlySection:Slider({
    text = "Speed",
    min  = 0,
    max  = 150,
    -- Set default walk speed as 16 (the default in Roblox)
    value    = 20,
    callback = function(wsValue)
        flyspeeed = (wsValue)
    end
})


local CosmeticSection = TabLocal:Section({
    text = "Cosmetic [CS]"
})

CosmeticSection:Button({
    text     = "Headless",
    callback = function()
        local function makeHeadless()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    local head = character:FindFirstChild("Head")
    if head then
        head.Transparency = 1
        head.face:Destroy()  -- Remove the face decal if it exists
    end
end

-- Function to restore the head visibility
local function restoreHead()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    local head = character:FindFirstChild("Head")
    if head then
        head.Transparency = 0
        if not head:FindFirstChild("face") then
            -- Add a default face if it doesn't exist
            local face = Instance.new("Decal", head)
            face.Name = "face"
            face.Texture = "rbxasset://textures/face.png"
        end
    end
end

-- Example usage
makeHeadless()
    end,
})


local spinEnabled = false
local spinPower = 100  -- Default power for spin
local bodyThrust = nil
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Spin Bot Section
local SpinBotSection = TabLocal:Section({
    text = "Spin Bot"
})

-- Toggle for Spin Bot
SpinBotSection:Toggle({
    text = "Enable Spin Bot",
    state = false, -- Default state (off)
    callback = function(state)
        spinEnabled = state

        -- If spin is enabled, add BodyThrust to the HumanoidRootPart
        if spinEnabled then
            if character and character:FindFirstChild("HumanoidRootPart") then
                -- Ensure there is no existing BodyThrust
                if not character.HumanoidRootPart:FindFirstChild("BodyThrust") then
                    bodyThrust = Instance.new("BodyThrust")
                    bodyThrust.Parent = character.HumanoidRootPart
                    bodyThrust.Force = Vector3.new(spinPower, 0, spinPower)
                    bodyThrust.Location = character.HumanoidRootPart.Position
                end
            end
        else
            -- If spin is disabled, remove the BodyThrust
            if bodyThrust then
                bodyThrust:Destroy()
                bodyThrust = nil
            end
        end
    end
})

-- Slider for Spin Power
SpinBotSection:Slider({
    text     = "Spin Power",
    min      = 10,
    max      = 3000,
    default  = spinPower, -- Default value
    callback = function(value)
        spinPower = value
        -- Update BodyThrust's Force dynamically if it's active
        if bodyThrust then
            bodyThrust.Force = Vector3.new(spinPower, 0, spinPower)
        end
    end
})

local noclipEnabled = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Clipping Section
local ClippingSection = TabLocal:Section({
    text = "Clipping"
})

-- Toggle for Noclip
ClippingSection:Toggle({
    text = "Enable Noclip",
    state = false, -- Default state (off)
    callback = function(state)
        noclipEnabled = state
    end
})

-- Function to handle noclip logic
game:GetService('RunService').Stepped:Connect(function()
    if noclipEnabled and character then
        character.Head.CanCollide = false
        character.UpperTorso.CanCollide = false
        character.LowerTorso.CanCollide = false
        character.HumanoidRootPart.CanCollide = false
    elseif not noclipEnabled and character then
        -- If noclip is off, enable collisions again
        character.Head.CanCollide = true
        character.UpperTorso.CanCollide = true
        character.LowerTorso.CanCollide = true
        character.HumanoidRootPart.CanCollide = true
    end
end)


local FunSection = TabLocal:Section({
    text = "Fun"
})

local swimming = false
local oldgrav = workspace.Gravity
local swimbeat = nil
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local swimSpeed = 50  -- Default swim speed

-- Lägg till en slider för att justera hastigheten
FunSection:Slider({
    text = "Swim Speed",
    min = 10,
    max = 200,
    default = swimSpeed,  -- Sätt standardhastighet (50)
    callback = function(value)
        swimSpeed = value  -- Uppdatera simhastigheten med det nya värdet från slidern
    end
})

-- FunSection:Toggle - Hantera simning när togglen ändras
FunSection:Toggle({
    text = "Swim",
    state = false,  -- Default boolean
    callback = function(boolean)
        if boolean then
            -- Start simning
            if not swimming and player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
                oldgrav = workspace.Gravity
                workspace.Gravity = 0  -- Sätt gravitationen till 0 för att simma i luften

                local swimDied = function()
                    workspace.Gravity = oldgrav
                    swimming = false
                end

                local Humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                local gravReset = Humanoid.Died:Connect(swimDied)

                -- Förhindra spelaren från att använda andra humanoidstatyer under simning
                local enums = Enum.HumanoidStateType:GetEnumItems()
                table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
                for i, v in pairs(enums) do
                    Humanoid:SetStateEnabled(v, false)
                end

                -- Sätt humanoiden i simningstillstånd
                Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)

                -- Starta simningens "heartbeat" för att hantera spelarens rörelse
                swimbeat = RunService.Heartbeat:Connect(function()
                    pcall(function()
                        local humanoidRootPart = player.Character.HumanoidRootPart
                        local moveDirection = Vector3.new(0, 0, 0)

                        -- Om spelaren trycker på tangentbordstangenter (WASD)
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            moveDirection = moveDirection + camera.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            moveDirection = moveDirection - camera.CFrame.LookVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            moveDirection = moveDirection - camera.CFrame.RightVector
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            moveDirection = moveDirection + camera.CFrame.RightVector
                        end

                        -- Om spelaren trycker på Space, stiger de
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            moveDirection = moveDirection + Vector3.new(0, 1, 0)
                        end

                        -- Använd spelarens riktning för att uppdatera deras rörelse med den hastighet som valts
                        if moveDirection.Magnitude > 0 then
                            humanoidRootPart.Velocity = moveDirection.Unit * swimSpeed  -- Använd den valda hastigheten
                        else
                            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)  -- Stoppar rörelsen om inga tangenter trycks
                        end
                    end)
                end)

                swimming = true
            end
        else
            -- Stoppa simning
            if player.Character and player.Character:FindFirstChildWhichIsA("Humanoid") then
                workspace.Gravity = oldgrav
                swimming = false

                -- Koppla bort event och rensa upp
                if swimbeat then
                    swimbeat:Disconnect()
                    swimbeat = nil
                end
                if gravReset then
                    gravReset:Disconnect()
                end

                local Humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                local enums = Enum.HumanoidStateType:GetEnumItems()
                table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))

                -- Återaktivera alla humanoidstatyer
                for i, v in pairs(enums) do
                    Humanoid:SetStateEnabled(v, true)
                end
            end
        end
    end
})

local dashEnabled = false
local dashSpeed = 100  -- Dashhastigheten
local dashDuration = 0.2  -- Hur länge dashen varar (sekunder)
local dashCooldown = 1  -- Hur länge du måste vänta mellan dashar (sekunder)
local dashStart = 0  -- Tidpunkten när dashen startade
local dashActive = false  -- Om dashen är aktiv eller inte

-- Trail-variabeln
local trail = nil

-- Funktion för att aktivera dash
local function Dash()
    if not dashActive and tick() - dashStart >= dashCooldown then
        dashActive = true
        dashStart = tick()

        local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            -- Uppdatera spelaren med högre hastighet för dash
            local originalVelocity = humanoidRootPart.Velocity
            local dashDirection = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
            humanoidRootPart.Velocity = dashDirection * dashSpeed  -- Sätt hastigheten till dashhastigheten

            -- Skapa trailen
            trail = Instance.new("Trail")
            trail.Name = "DashTrail"
            trail.Parent = humanoidRootPart  -- Fästa trailen vid HumanoidRootPart
            trail.Attachment0 = humanoidRootPart:FindFirstChild("Attachment") or Instance.new("Attachment", humanoidRootPart)
            trail.Attachment1 = humanoidRootPart:FindFirstChild("Attachment") or Instance.new("Attachment", humanoidRootPart)
            
            -- Ställ in trailens egenskaper
            trail.Lifetime = 0.2  -- Trailens livslängd (kan justeras om du vill ha trailen längre eller kortare)
            trail.WidthScale = NumberSequence.new(0.5, 0)  -- Gör trailen tunnare mot slutet
            trail.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 255))  -- Färg (kan ändras)
            trail.Enabled = true  -- Gör trailen synlig

            -- Efter dashens varaktighet (dashDuration), ta bort trailen
            wait(dashDuration)

            -- Ta bort trailen efter dashen är över
            if trail then
                trail:Destroy()
            end
        end

        -- Dashens varaktighet (efter dashDuration återgår vi till normal hastighet)
        wait(dashDuration)

        -- Återställ hastigheten efter att dashen har gått ut
        local humanoidRootPart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.Velocity = Vector3.new(0, 0, 0)  -- Stanna rörelsen
        end

        dashActive = false  -- Markera dashen som inaktiv
    end
end

-- Lägg till en Toggle för Dash
FunSection:Toggle({
    text     = "Dash (X)",
    state    = false,  -- Standard state (off)
    callback = function(boolean)
        dashEnabled = boolean  -- Om Dash är aktiverad eller inte
    end
})

-- Lägg till en bindning av X-tangenten för att starta dashen
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
        if dashEnabled then
            Dash()  -- Anropa Dash-funktionen om dash är aktiverad
        end
    end
end)

local TPSection = TabLocal:Section({
    text = "Teleporting"
})

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local teleportEnabled = false

-- Toggle for Click Teleport
TPSection:Toggle({
    text     = "Click Teleport",
    state    = false,  -- Standard state (off)
    callback = function(state)
        teleportEnabled = state  -- Enable or disable teleport based on toggle
    end
})

-- Listen for mouse click and teleport the player
mouse.Button1Down:Connect(function()
    if teleportEnabled then
        -- Get the mouse hit position and teleport the HumanoidRootPart
        local mouseHit = mouse.Hit.p
        humanoidRootPart.CFrame = CFrame.new(mouseHit + Vector3.new(0, 3, 0))  -- Teleport slightly above ground
    end
end)


local TabPlayers = maintab:Tab({
    text = "Players",
    icon = "rbxassetid://7999345313",
})

local UniSection = TabPlayers:Section({
    text = "Universal"
})

local pigvicval = ""

UniSection:Textbox({
    text     = "Player",
    value    = "Default",
    callback = function(text)
        pigvicval = (text)
    end
})

local TeleSection = TabPlayers:Section({
    text = "Teleport"
})

TeleSection:Button({
    text     = "Teleport",
    callback = function()
        local partialUsername = pigvicval

-- Get the local player
local player = game.Players.LocalPlayer

-- Wait for the character to load
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Function to teleport to the target player's position
local function teleportToPlayer(partialName)
    -- Find the target player with the partial username
    local targetPlayer = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.sub(p.Name, 1, string.len(partialName)):lower() == partialName:lower() then
            targetPlayer = p
            break
        end
    end
    
    if targetPlayer then
        -- Get the target player's character and HumanoidRootPart
        local targetCharacter = targetPlayer.Character
        if targetCharacter then
            local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if targetHumanoidRootPart then
                -- Teleport the local player to the target player's position
                humanoidRootPart.CFrame = targetHumanoidRootPart.CFrame
                print("Teleported to " .. targetPlayer.Name)
            else
                print(targetPlayer.Name .. " does not have a HumanoidRootPart.")
            end
        else
            print(targetPlayer.Name .. " does not have a character.")
        end
    else
        print("Player with partial username '" .. partialName .. "' not found.")
    end
end

-- Call the function to teleport
teleportToPlayer(partialUsername)
    end,
})

TeleSection:Button({
    text     = "Sneak Teleport",
    callback = function()
        local partialUsername = pigvicval

-- Get the local player
local player = game.Players.LocalPlayer

-- Wait for the character to load
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Function to teleport to the target player's position
local function teleportToPlayer(partialName)
    -- Find the target player with the partial username
    local targetPlayer = nil
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.sub(p.Name, 1, string.len(partialName)):lower() == partialName:lower() then
            targetPlayer = p
            break
        end
    end
    
    if targetPlayer then
        -- Get the target player's character and HumanoidRootPart
        local targetCharacter = targetPlayer.Character
        if targetCharacter then
            local targetHumanoidRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if targetHumanoidRootPart then
                -- Calculate the position 10 meters behind the target player
                local behindPosition = targetHumanoidRootPart.CFrame * CFrame.new(0, 0, 50)
                -- Teleport the local player to the calculated position
                humanoidRootPart.CFrame = CFrame.new(behindPosition.Position)
                print("Teleported to 10 meters behind " .. targetPlayer.Name)
            else
                print(targetPlayer.Name .. " does not have a HumanoidRootPart.")
            end
        else
            print(targetPlayer.Name .. " does not have a character.")
        end
    else
        print("Player with partial username '" .. partialName .. "' not found.")
    end
end

-- Call the function to teleport
teleportToPlayer(partialUsername)
    end,
})



local FollowSection = TabPlayers:Section({
    text = "Following"
})

FollowSection:Toggle({
    text     = "Piggy Back",
    state    = false, -- Default boolean
    callback = function(state)
        if (state) == true then
        game.Players.LocalPlayer.Character.Humanoid.Sit = true
-- Execute this in your executor to start following
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local targetPlayerPartialName = pigvicval  -- Replace with the partial name of the player to follow
local followDistance = 2  -- Distance above the target player
local behindDistance = 1.5  -- Distance behind the target player

-- Function to find target player by partial name
local function findTargetPlayer(partialName)
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if string.match(string.lower(targetPlayer.Name), string.lower(partialName)) then
            return targetPlayer
        end
    end
    return nil
end

-- Create variables to hold BodyPosition and BodyGyro instances
local bodyPosition
local bodyGyro

local function followTarget()
    local targetPlayer = findTargetPlayer(targetPlayerPartialName)
    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        if targetCharacter then
            local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local character = player.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        -- Create or update BodyPosition and BodyGyro
                        if not bodyPosition then
                            bodyPosition = rootPart:FindFirstChildOfClass("BodyPosition") or Instance.new("BodyPosition", rootPart)
                            bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
                            bodyPosition.P = 20000  -- Increase proportional gain for faster response
                            bodyPosition.D = 1000   -- Increase derivative gain for smoother response
                        end
                        if not bodyGyro then
                            bodyGyro = rootPart:FindFirstChildOfClass("BodyGyro") or Instance.new("BodyGyro", rootPart)
                            bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
                            bodyGyro.P = 20000      -- Increase proportional gain for faster response
                            bodyGyro.D = 1000       -- Increase derivative gain for smoother response
                        end

                        -- Calculate target position and orientation
                        local targetPosition = targetRoot.Position + targetRoot.CFrame.LookVector * -behindDistance + Vector3.new(0, followDistance, 0)
                        local targetOrientation = CFrame.new(targetRoot.Position, targetRoot.Position + targetRoot.CFrame.LookVector)

                        -- Update BodyPosition and BodyGyro
                        bodyPosition.Position = targetPosition
                        bodyGyro.CFrame = targetOrientation
                    end
                end
            end
        end
    end
end

-- Connect the followTarget function to RenderStepped
local followConnection
followConnection = RunService.RenderStepped:Connect(followTarget)

-- Store the connection in a global variable to access it in the stop script
getgenv().followConnection = followConnection



        
        else
game.Players.LocalPlayer.Character.Humanoid.Sit = false
-- Execute this in your executor to stop following
local RunService = game:GetService("RunService")

local function stopFollowing()
    -- Access the stored connection and disconnect it
    if getgenv().followConnection then
        getgenv().followConnection:Disconnect()
        getgenv().followConnection = nil
    end

    -- Remove BodyPosition and BodyGyro to reset character physics
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyPosition = rootPart:FindFirstChild("BodyPosition")
            local bodyGyro = rootPart:FindFirstChild("BodyGyro")
            if bodyPosition then bodyPosition:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end
end

stopFollowing()




        end
    end
})

local orbrad = 5

FollowSection:Toggle({
    text     = "Orbit",
    state    = false, -- Default boolean
    callback = function(state)
        if (state) == true then
-- Execute this in your executor to start orbiting around the player
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local targetPlayerPartialName = pigvicval  -- Replace with the partial name of the player to orbit around
local orbitRadius = orbrad  -- Radius of the orbit circle
local orbitHeight = 3  -- Height above the target player

-- Function to find target player by partial name
local function findTargetPlayer(partialName)
    for _, targetPlayer in pairs(Players:GetPlayers()) do
        if string.match(string.lower(targetPlayer.Name), string.lower(partialName)) then
            return targetPlayer
        end
    end
    return nil
end

-- Create variables to hold BodyPosition and BodyGyro instances
local bodyPosition
local bodyGyro

local function orbitTarget()
    local targetPlayer = findTargetPlayer(targetPlayerPartialName)
    if targetPlayer then
        local targetCharacter = targetPlayer.Character
        if targetCharacter then
            local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local character = player.Character
                if character then
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if rootPart then
                        -- Create or update BodyPosition and BodyGyro
                        orbitRadius = orbrad
                        if not bodyPosition then
                            bodyPosition = rootPart:FindFirstChildOfClass("BodyPosition") or Instance.new("BodyPosition", rootPart)
                            bodyPosition.MaxForce = Vector3.new(4000, 4000, 4000)
                            bodyPosition.P = 20000  -- Increase proportional gain for faster response
                            bodyPosition.D = 1000   -- Increase derivative gain for smoother response
                        end
                        if not bodyGyro then
                            bodyGyro = rootPart:FindFirstChildOfClass("BodyGyro") or Instance.new("BodyGyro", rootPart)
                            bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
                            bodyGyro.P = 20000      -- Increase proportional gain for faster response
                            bodyGyro.D = 1000       -- Increase derivative gain for smoother response
                        end

                        -- Calculate orbit position relative to the target
                        local offset = Vector3.new(math.cos(tick() * 2) * orbitRadius, orbitHeight, math.sin(tick() * 2) * orbitRadius)
                        local targetPosition = targetRoot.Position + offset

                        -- Update BodyPosition and BodyGyro
                        orbitRadius = orbrad
                        bodyPosition.Position = targetPosition
                        bodyGyro.CFrame = CFrame.lookAt(targetPosition, targetRoot.Position)
                    end
                end
            end
        end
    end
end

-- Connect the orbitTarget function to RenderStepped
local orbitConnection
orbitConnection = RunService.RenderStepped:Connect(orbitTarget)

-- Store the connection in a global variable to access it in the stop script
getgenv().orbitConnection = orbitConnection

        else
-- Execute this in your executor to stop following
local RunService = game:GetService("RunService")

local function stopFollowing()
    -- Access the stored connection and disconnect it
    if getgenv().followConnection then
        getgenv().followConnection:Disconnect()
        getgenv().followConnection = nil
    end

    -- Remove BodyPosition and BodyGyro to reset character physics
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local bodyPosition = rootPart:FindFirstChild("BodyPosition")
            local bodyGyro = rootPart:FindFirstChild("BodyGyro")
            if bodyPosition then bodyPosition:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
        end
    end
end

stopFollowing()
        end
    end
})

FollowSection:Slider({
    text = "Orbit Radius",
    min  = 1,
    max  = 50,
    -- [[Float = 0,]] Idk what it does
    callback = function(Value)
        orbrad = (Value)
    end
})


local HatPlayersSection = TabPlayers:Section({
    text = "Hat Scripts"
})

HatPlayersSection:Button({
    text     = "Poop [R6]",
    callback = function()
        getgenv().Target = pigvicval; -- Player user or shorten --
local tog = true
local move = false
local jit = Vector3.new(25.01, 0, 0)
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character

function GS(serv) return game:GetService(serv) end
local plrs, RunService = GS("Players"), GS("RunService")
local plr = plrs.LocalPlayer
local Loop

function GetPlayer(str)
    local Found
    for i, v in pairs(plrs:GetPlayers()) do
        if v.Name:lower():find(str:lower()) then
            Found = v
            break
        end
    end
    return Found
end

local targetplayer = GetPlayer(Target)
if not targetplayer then
    warn("Target player not found")
    return
end

local targetplayerc = targetplayer.Character
local targetwc = game.Workspace:FindFirstChild(targetplayer.Name)
if not targetwc then
    warn("Target player's workspace not found")
    return
end

RunService.Heartbeat:Connect(function()
    Character["Poop"].Handle.Velocity = jit
end)

local Head = "Poop" -- press f9 and find the hat that looks like a head's name and put it here
local x = 0   -- Edit Position for head n +left and -Right
local y = -1.2   -- Edit Position for head up and down
local z = 0.2 -- Edit Position for head x3

Character:WaitForChild(Head).Handle.AccessoryWeld:Remove()

local alignpos = Instance.new("AlignPosition", Character)
local alignorien = Instance.new("AlignOrientation", Character)
local att1 = Instance.new("Attachment", Character:WaitForChild(Head).Handle)
local att2 = Instance.new("Attachment", targetwc:WaitForChild("Torso"))

alignpos.Attachment0 = att1
alignpos.Attachment1 = att2
alignpos.RigidityEnabled = false
alignpos.ReactionForceEnabled = false
alignpos.ApplyAtCenterOfMass = true
alignpos.MaxForce = 99999999
alignpos.MaxVelocity = math.huge
alignpos.Responsiveness = 200

alignorien.Attachment0 = att1
alignorien.Attachment1 = att2
alignorien.ReactionTorqueEnabled = false
alignorien.PrimaryAxisOnly = false
alignorien.MaxTorque = 99999999
alignorien.MaxAngularVelocity = math.huge
alignorien.Responsiveness = 200

att2.Position = Vector3.new(x, y, z)

Character:WaitForChild(Head).Handle.Attachment.Rotation = Vector3.new(120, 180, 0)


local MusicOnHat = false -- If You Want To Play Audio In Hat
local StartSound = Instance.new("Sound")
StartSound.SoundId = "rbxassetid://8548558777" -- place sound id here
StartSound.Volume = 0.1

-- Script to grab and store the player's current position
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Store the current position
local currentPosition = character.HumanoidRootPart.Position

-- Print the stored position (optional)
print("Current Position:", currentPosition)




StartSound.Parent = workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart

local YEET = Instance.new("Sound")
YEET.SoundId = "rbxassetid://525743689" -- place sound id here
YEET.Volume = 1



YEET.Parent = workspace:FindFirstChild(game.Players.LocalPlayer.Name).HumanoidRootPart


StartSound:Play()

local tpbackpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame


game.Players.LocalPlayer.Character.Humanoid.Health = 0

wait(1)
StartSound:Play()
att2.Position = Vector3.new(0, -1.2, 0.3)

wait(0.1)
StartSound:Play()
att2.Position = Vector3.new(0, -1.3, 0.4)

wait(0.1)
StartSound:Play()
att2.Position = Vector3.new(0, -1.4, 0.5)

wait(0.1)
StartSound:Play()
att2.Position = Vector3.new(0, -1.5, 0.6)

wait(0.1)
StartSound:Play()
att2.Position = Vector3.new(0, -1.6, 0.7)

local player = game.Players.LocalPlayer

-- Function to detect when the player respawns
local function onCharacterAdded(character)

    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tpbackpos
end

-- Connect the function to the CharacterAdded event
player.CharacterAdded:Connect(onCharacterAdded)

-- Check if the player already has a character (in case they start alive)
if player.Character then
    onCharacterAdded(player.Character)
end
    end,
}) 



local FindPSection = TabPlayers:Section({
    text = "Stalk"
})

FindPSection:Toggle({
    text     = "Spectate",
    state    = false, -- Default boolean
    callback = function(state)
        local playerToSpectate = nil

        -- Sök igenom alla spelare och hitta spelaren vars namn matchar "pigvicval" delvis
        for _, player in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(player.Name), string.lower(pigvicval)) then
                playerToSpectate = player
                break
            end
        end

        -- Om vi har hittat en spelare att spectate
        if playerToSpectate then
            if state then
                -- Spara den nuvarande kameran
                local currentCamera = workspace.CurrentCamera
                -- Sätt kamerans Subject till spelarens humanoid för att spectate
                currentCamera.CameraSubject = playerToSpectate.Character:FindFirstChild("Humanoid")
                currentCamera.CameraType = Enum.CameraType.Custom
            else
                -- Återställ kameran till spelarens karaktär
                local currentCamera = workspace.CurrentCamera
                currentCamera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                currentCamera.CameraType = Enum.CameraType.Custom
            end
        else
            warn("No player found with name matching: " .. pigvicval)
        end
    end
})


local player = game.Players.LocalPlayer
  -- Partial name to search for
local pingEnabled = false   -- Track if the Ping feature is enabled

local selectedEmoji = "⬇️"  -- Default emoji (down arrow)
local emojis = {"⬇️", "⭐", "🔥", "💀", "👀", "😊"}  -- List of emojis for the dropdown

-- Create a BillboardGui to mark the player
local function createPingMark(player)
    -- Make sure there isn't already a mark
    if player:FindFirstChild("PingMark") then
        return
    end
    
    -- Create the BillboardGui and text label
    local mark = Instance.new("BillboardGui")
    mark.Name = "PingMark"
    mark.Parent = player.Character.Head
    mark.Adornee = player.Character.Head
    mark.Size = UDim2.new(0, 50, 0, 50)
    mark.StudsOffset = Vector3.new(0, 3, 0)  -- Adjust the distance above the head
    mark.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Parent = mark
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = selectedEmoji  -- Use the selected emoji
    label.TextSize = 20
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Remove the PingMark from a player
local function removePingMark(player)
    if player:FindFirstChild("PingMark") then
        player.PingMark:Destroy()
    end
end

-- Search for players with a partial name and add/remove symbols
local function pingPlayers()
    -- Iterate through all players
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        -- Check if the player's name matches the partial name
        if otherPlayer.Name:lower():find(pigvicval:lower()) then
            if not otherPlayer:FindFirstChild("PingMark") then
                createPingMark(otherPlayer)  -- Add the symbol if not already present
            end
        else
            removePingMark(otherPlayer)  -- Remove the symbol if name doesn't match
        end
    end
end

-- Button to toggle Ping on/off
FindPSection:Button({
    text     = "Ping Player",
    callback = function()
        pingEnabled = not pingEnabled  -- Toggle the state
        if pingEnabled then
            -- Start searching for players when the button is clicked
            pingConnection = game:GetService("RunService").Heartbeat:Connect(function()
                pingPlayers()
            end)
        else
            -- If the button is clicked again (turning off), remove all marks and disconnect the loop
            if pingConnection then
                pingConnection:Disconnect()  -- Disconnect the loop
                pingConnection = nil
            end
            -- Remove all PingMarks
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                removePingMark(otherPlayer)  -- Properly remove PingMark when button is clicked again
            end
        end
    end
})

-- Dropdown to select an emoji for the Ping Mark
FindPSection:Dropdown({
    text = "Select Emoji",
    list = emojis,
    default = selectedEmoji,
    callback = function(selected)
        selectedEmoji = selected  -- Update the emoji when the user selects a new one
        -- When emoji changes, apply it to any existing marks
        for _, otherPlayer in pairs(game.Players:GetPlayers()) do
            if otherPlayer:FindFirstChild("PingMark") then
                otherPlayer.PingMark.TextLabel.Text = selectedEmoji
            end
        end
    end
})



local TabAim = maintab:Tab({
    text = "Aim",
    icon = "rbxassetid://7999345313",
})

local AimLockSection = TabAim:Section({
    text = "Aim Lock"
})

AimLockSection:Button({
    text     = "Azure",
    callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded"))()
    end,
})

local TabAnims = maintab:Tab({
    text = "Animations",
    icon = "rbxassetid://7999345313",
})

local R6Section = TabAnims:Section({
    text = "R6"
})

R6Section:Toggle({
    text     = "Hug",
    state    = false, -- Default boolean
    callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Load Animation for Backflip
        local backflipAnimation = Instance.new("Animation")
        backflipAnimation.AnimationId = "rbxassetid://27432686" -- Backflip animation ID

        -- Create Animator
        local humanoid = character:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

        if state then
            -- Play the backflip animation if it's not already playing
            if not backflipAnimationTrack or not backflipAnimationTrack.IsPlaying then
                backflipAnimationTrack = animator:LoadAnimation(backflipAnimation)
                backflipAnimationTrack:Play()
            end
        else
            -- Stop the backflip animation if it's currently playing
            if backflipAnimationTrack and backflipAnimationTrack.IsPlaying then
                backflipAnimationTrack:Stop()
            end
        end
    end
})

R6Section:Button({
    text     = "Head Throw",
    callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Load Animation
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://35154961" -- Replace with the desired animation ID

-- Create Animator
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

-- Play the animation
local animationTrack = animator:LoadAnimation(animation)
animationTrack:Play()
    end,
})

R6Section:Button({
    text     = "Floating Head",
    callback = function()
        local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Load Animation
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://121572214" -- Replace with the desired animation ID

-- Create Animator
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

-- Play the animation
local animationTrack = animator:LoadAnimation(animation)
animationTrack:Play()
wait(2)
animationTrack:Stop()
    end,
})

R6Section:Toggle({
    text     = "Crouch",
    state    = false, -- Default boolean
    callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Load Animation for Backflip
        local crouchAnimation = Instance.new("Animation")
        crouchAnimation.AnimationId = "rbxassetid://182724289" -- Backflip animation ID

        -- Create Animator
        local humanoid = character:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

        if state then
            -- Play the backflip animation if it's not already playing
            if not crouchAnimationTrack or not crouchAnimationTrack.IsPlaying then
                crouchAnimationTrack = animator:LoadAnimation(crouchAnimation)
                crouchAnimationTrack:Play()
            end
        else
            -- Stop the backflip animation if it's currently playing
            if crouchAnimationTrack and crouchAnimationTrack.IsPlaying then
                crouchAnimationTrack:Stop()
            end
        end
    end
})


local R15Section = TabAnims:Section({
    text = "R15"
})

R15Section:Toggle({
    text     = "Jump Dance",
    state    = false, -- Default boolean
    callback = function(state)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        -- Load Animation for Jump Dance
        local jumpDanceAnimation = Instance.new("Animation")
        jumpDanceAnimation.AnimationId = "rbxassetid://507771019" -- Dab animation ID

        -- Create Animator
        local humanoid = character:WaitForChild("Humanoid")
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

        if state then
            -- Play the jump dance animation if it's not already playing
            if not jumpDanceAnimationTrack or not jumpDanceAnimationTrack.IsPlaying then
                jumpDanceAnimationTrack = animator:LoadAnimation(jumpDanceAnimation)
                jumpDanceAnimationTrack:Play()
            end
        else
            -- Stop the jump dance animation if it's currently playing
            if jumpDanceAnimationTrack and jumpDanceAnimationTrack.IsPlaying then
                jumpDanceAnimationTrack:Stop()
            end
        end
    end
})



