
--==================================================
-- W3NNART SPEED ADJUSTER
-- MADE BY W3NNART
-- ROBLOX STUDIO LOCAL SCRIPT
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local speed = 16
local gui = Instance.new("ScreenGui")
gui.Name = "W3NNART_SPEED_ADJUSTER"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(300,220)
main.Position = UDim2.new(0.5,-150,0.5,-110)
main.BackgroundColor3 = Color3.fromRGB(12,16,20)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0,230,240)
stroke.Thickness = 2
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,45)
header.BackgroundColor3 = Color3.fromRGB(0,35,42)
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.fromOffset(10,0)
title.BackgroundTransparency = 1
title.Text = "W3NNART SPEED"
title.TextColor3 = Color3.fromRGB(0,240,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = header

local function button(text,pos,color)
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(35,32)
    b.Position = pos
    b.Text = text
    b.TextSize = 20
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    b.Parent = header
    return b
end

local minimize = button("−",UDim2.new(1,-80,0,6),
    Color3.fromRGB(20,60,70))

local close = button("X",UDim2.new(1,-40,0,6),
    Color3.fromRGB(130,35,35))

local content = Instance.new("Frame")
content.Size = UDim2.new(1,0,1,-45)
content.Position = UDim2.fromOffset(0,45)
content.BackgroundTransparency = 1
content.Parent = main

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,0,45)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.GothamBold
label.TextSize = 23
label.Parent = content

local function apply()
    speed = math.clamp(math.floor(speed),0,1000)
    label.Text = "Speed: "..speed
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = speed end
end

local slider = Instance.new("TextBox")
slider.Size = UDim2.new(1,-40,0,35)
slider.Position = UDim2.fromOffset(20,65)
slider.BackgroundColor3 = Color3.fromRGB(20,60,70)
slider.TextColor3 = Color3.new(1,1,1)
slider.PlaceholderText = "Enter speed (0-1000)"
slider.Text = ""
slider.ClearTextOnFocus = false
slider.Font = Enum.Font.Gotham
slider.TextSize = 14
slider.Parent = content

local set = Instance.new("TextButton")
set.Size = UDim2.new(1,-40,0,38)
set.Position = UDim2.fromOffset(20,110)
set.BackgroundColor3 = Color3.fromRGB(0,180,190)
set.Text = "SET SPEED"
set.TextColor3 = Color3.new(1,1,1)
set.Font = Enum.Font.GothamBold
set.TextSize = 16
set.Parent = content

set.MouseButton1Click:Connect(function()
    local n = tonumber(slider.Text)
    if n then
        speed = math.clamp(n,0,1000)
        apply()
    end
end)

local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1,0,0,25)
footer.Position = UDim2.new(0,0,1,-28)
footer.BackgroundTransparency = 1
footer.Text = "MADE BY W3NNART"
footer.TextColor3 = Color3.fromRGB(0,230,240)
footer.Font = Enum.Font.GothamBold
footer.TextSize = 13
footer.Parent = content

local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    main.Size = minimized and UDim2.fromOffset(300,45)
        or UDim2.fromOffset(300,220)
    minimize.Text = minimized and "+" or "−"
end)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- DRAG
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position-dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,startPos.X.Offset+delta.X,
            startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

player.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = speed
end)

apply()
print("W3NNART SPEED ADJUSTER LOADED")
