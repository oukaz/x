local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local workspaceService = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local currentCamera = workspaceService.CurrentCamera

local v1 = {
  Enabled = false,
  Sticky = false,
  TeamCheck = false,
  WallCheck = false,
  ShowFOV = false,
  Smoothness = 0.08,
  Prediction = 0,
  Strength = 200,
  FOVThickness = 2,
  FOVColor = Color3.fromRGB(255, 255, 255),
  Rainbow = false,
  TargetPart = "Head",
  CamLockKey = "Q",
  ToggleGuiKey = "RightShift",
  HSV = { H = 0, S = 0, V = 1 },
}

local v2 = { "Head", "UpperTorso", "HumanoidRootPart" }
local v3 = 1

local camLockUniversalV8 = Instance.new("ScreenGui")
camLockUniversalV8.Name = "CamLockUniversal_v8"
camLockUniversalV8.IgnoreGuiInset = true
camLockUniversalV8.ResetOnSpawn = false
camLockUniversalV8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if not pcall(function() camLockUniversalV8.Parent = coreGui end) then
  camLockUniversalV8.Parent = localPlayer:WaitForChild("PlayerGui")
end

local fovRing = Instance.new("Frame")
fovRing.Name = "FOVRing"
fovRing.Parent = camLockUniversalV8
fovRing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
fovRing.BackgroundTransparency = 1
fovRing.AnchorPoint = Vector2.new(0.5, 0.5)
fovRing.Visible = false
fovRing.ZIndex = 1
fovRing.Size = UDim2.new(0, v1.Strength * 2, 0, v1.Strength * 2)

local uiStroke = Instance.new("UIStroke")
uiStroke.Parent = fovRing
uiStroke.Color = v1.FOVColor
uiStroke.Thickness = v1.FOVThickness
uiStroke.Transparency = 0
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(1, 0)
uiCorner.Parent = fovRing

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = camLockUniversalV8
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
mainFrame.Size = UDim2.new(0, 260, 0, 710)
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 10

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 8)
uiCorner2.Parent = mainFrame

local textLabel = Instance.new("TextLabel")
textLabel.Parent = mainFrame
textLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
textLabel.BorderSizePixel = 0
textLabel.Size = UDim2.new(1, 0, 0, 30)
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "  Camlock Universal - made by mango1337"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 12
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.ZIndex = 11

local v4, position, position2

textLabel.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
    v4 = true
    position = input.Position
    position2 = mainFrame.Position
  end
end)

local v5

textLabel.InputChanged:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseMovement then
    v5 = input2
  end
end)

userInputService.InputChanged:Connect(function(input3)
  if input3 == v5 and v4 then
    local v6 = input3.Position - position

    mainFrame.Position = UDim2.new(
      position2.X.Scale, position2.X.Offset + v6.X, position2.Y.Scale, position2.Y.Offset + v6.Y
    )
  end
end)

userInputService.InputEnded:Connect(function(input4)
  if input4.UserInputType == Enum.UserInputType.MouseButton1 then
    v4 = false
  end
end)

local v7 = 40

local function f1(index)
  v7 = v7 + index
end

local textButton = Instance.new("TextButton")
textButton.Parent = mainFrame
textButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
textButton.Position = UDim2.new(0, 15, 0, v7)
textButton.Size = UDim2.new(0, 230, 0, 30)
textButton.Font = Enum.Font.GothamBold
textButton.Text = "CamLock: OFF"
textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton.TextSize = 14
textButton.ZIndex = 11

Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
local v8

textButton.MouseButton1Click:Connect(function()
  v1.Enabled = not v1.Enabled

  if v1.Enabled then
    textButton.Text = "CamLock: ON"
    textButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    v8 = nil
  else
    textButton.Text = "CamLock: OFF"
    textButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    v8 = nil
  end
end)

f1(40)

local textLabel2 = Instance.new("TextLabel")
textLabel2.Parent = mainFrame
textLabel2.BackgroundTransparency = 1
textLabel2.Position = UDim2.new(0, 15, 0, v7)
textLabel2.Size = UDim2.new(0, 80, 0, 30)
textLabel2.Font = Enum.Font.Gotham
textLabel2.Text = "Keybind:"
textLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.TextSize = 14
textLabel2.ZIndex = 11

local textBox = Instance.new("TextBox")
textBox.Parent = mainFrame
textBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textBox.Position = UDim2.new(0, 80, 0, v7)
textBox.Size = UDim2.new(0, 165, 0, 30)
textBox.Font = Enum.Font.GothamBold
textBox.Text = v1.CamLockKey
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 14
textBox.ZIndex = 11

Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

textBox.FocusLost:Connect(function()
  if textBox.Text == "" then
    textBox.Text = v1.CamLockKey
  else
    v1.CamLockKey = textBox.Text:sub(1, 1):upper()
    textBox.Text = v1.CamLockKey
  end
end)

f1(40)

local textButton2 = Instance.new("TextButton")
textButton2.Parent = mainFrame
textButton2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textButton2.Position = UDim2.new(0, 15, 0, v7)
textButton2.Size = UDim2.new(0, 230, 0, 30)
textButton2.Font = Enum.Font.Gotham
textButton2.Text = "Sticky Camlock: OFF"
textButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton2.TextSize = 13
textButton2.ZIndex = 11

Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 6)

textButton2.MouseButton1Click:Connect(function()
  v1.Sticky = not v1.Sticky

  if v1.Sticky then
    textButton2.Text = "Sticky Camlock: ON"
    textButton2.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
  else
    textButton2.Text = "Sticky Camlock: OFF"
    textButton2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    v8 = nil
  end
end)

f1(40)

local textButton3 = Instance.new("TextButton")
textButton3.Parent = mainFrame
textButton3.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textButton3.Position = UDim2.new(0, 15, 0, v7)
textButton3.Size = UDim2.new(0, 230, 0, 30)
textButton3.Font = Enum.Font.Gotham
textButton3.Text = "Target Part: Head"
textButton3.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton3.TextSize = 13
textButton3.ZIndex = 11

Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 6)

textButton3.MouseButton1Click:Connect(function()
  v3 = v3 + 1

  if v3 > #v2 then
    v3 = 1
  end

  v1.TargetPart = v2[v3]
  textButton3.Text = "Target Part: " .. v1.TargetPart
end)

f1(40)

local textButton4 = Instance.new("TextButton")
textButton4.Parent = mainFrame
textButton4.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textButton4.Position = UDim2.new(0, 15, 0, v7)
textButton4.Size = UDim2.new(0, 230, 0, 30)
textButton4.Font = Enum.Font.Gotham
textButton4.Text = "Wall Check: OFF"
textButton4.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton4.TextSize = 13
textButton4.ZIndex = 11

Instance.new("UICorner", textButton4).CornerRadius = UDim.new(0, 6)

textButton4.MouseButton1Click:Connect(function()
  v1.WallCheck = not v1.WallCheck

  if v1.WallCheck then
    textButton4.Text = "Wall Check: ON"
    textButton4.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
  else
    textButton4.Text = "Wall Check: OFF"
    textButton4.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
  end
end)

f1(40)

local textButton5 = Instance.new("TextButton")
textButton5.Parent = mainFrame
textButton5.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textButton5.Position = UDim2.new(0, 15, 0, v7)
textButton5.Size = UDim2.new(0, 230, 0, 30)
textButton5.Font = Enum.Font.Gotham
textButton5.Text = "Team Check: OFF"
textButton5.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton5.TextSize = 13
textButton5.ZIndex = 11

Instance.new("UICorner", textButton5).CornerRadius = UDim.new(0, 6)

textButton5.MouseButton1Click:Connect(function()
  v1.TeamCheck = not v1.TeamCheck

  if v1.TeamCheck then
    textButton5.Text = "Team Check: ON"
    textButton5.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
  else
    textButton5.Text = "Team Check: OFF"
    textButton5.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
  end
end)

f1(35)

local textLabel3 = Instance.new("TextLabel")
textLabel3.Parent = mainFrame
textLabel3.BackgroundTransparency = 1
textLabel3.Position = UDim2.new(0, 15, 0, v7)
textLabel3.Size = UDim2.new(0, 230, 0, 15)
textLabel3.Font = Enum.Font.Gotham
textLabel3.Text = "Higher Smoothness = Stronger Aimbot"
textLabel3.TextColor3 = Color3.fromRGB(150, 150, 150)
textLabel3.TextSize = 11
textLabel3.TextXAlignment = Enum.TextXAlignment.Center
textLabel3.ZIndex = 11

f1(20)

local function makeTextButton(text, index2, index3, p1, color, fn)
  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Parent = mainFrame
  textLabel4.BackgroundTransparency = 1
  textLabel4.Position = UDim2.new(0, 15, 0, v7)
  textLabel4.Size = UDim2.new(0, 200, 0, 20)
  textLabel4.Font = Enum.Font.Gotham
  textLabel4.Text = text
  textLabel4.TextColor3 = Color3.fromRGB(200, 200, 200)
  textLabel4.TextSize = 12
  textLabel4.TextXAlignment = Enum.TextXAlignment.Left
  textLabel4.ZIndex = 11

  local frame = Instance.new("Frame")
  frame.Parent = mainFrame
  frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
  frame.Position = UDim2.new(0, 15, 0, v7 + 20)
  frame.Size = UDim2.new(0, 230, 0, 8)
  frame.ZIndex = 11

  Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)

  local frame2 = Instance.new("Frame")
  frame2.Parent = frame
  frame2.BackgroundColor3 = color
  frame2.Size = UDim2.new((p1 - index2) / (index3 - index2), 0, 1, 0)
  frame2.ZIndex = 11

  Instance.new("UICorner", frame2).CornerRadius = UDim.new(1, 0)

  local textButton6 = Instance.new("TextButton")
  textButton6.Parent = frame
  textButton6.BackgroundTransparency = 1
  textButton6.Size = UDim2.new(1, 0, 1, 0)
  textButton6.Text = ""
  textButton6.ZIndex = 11

  local v9 = false

  textButton6.InputBegan:Connect(function(input5)
    if input5.UserInputType == Enum.UserInputType.MouseButton1 then
      v9 = true
    end
  end)

  userInputService.InputEnded:Connect(function(input6)
    if input6.UserInputType == Enum.UserInputType.MouseButton1 then
      v9 = false
    end
  end)

  userInputService.InputChanged:Connect(function(input7)
    if v9 and input7.UserInputType == Enum.UserInputType.MouseMovement then
      local getMouseLocation = userInputService:GetMouseLocation()

      local v10 = math.clamp((getMouseLocation.X - frame.AbsolutePosition.X)
        / frame.AbsoluteSize.X, 0, 1)

      frame2.Size = UDim2.new(v10, 0, 1, 0)
      fn(index2 + (index3 - index2) * v10)
    end
  end)

  f1(35)
end

makeTextButton(
  "Smoothness", 0.01, 0.5, v1.Smoothness, Color3.fromRGB(0, 170, 255),
  function(smoothness) v1.Smoothness = smoothness end
)

-- https://discord.gg/AwGHNh7Z7T
makeTextButton(
  "Prediction", 0, 1, v1.Prediction, Color3.fromRGB(0, 170, 255),
  function(prediction) v1.Prediction = prediction end
)

makeTextButton("Fov Radius", 50, 600, v1.Strength, Color3.fromRGB(0, 170, 255), function(index4)
  v1.Strength = index4
  fovRing.Size = UDim2.new(0, index4 * 2, 0, index4 * 2)
end)

makeTextButton("Fov Circle Thickness", 1, 10, v1.FOVThickness, Color3.fromRGB(0, 170, 255), function(p2)
  v1.FOVThickness = p2
  uiStroke.Thickness = p2
end)

f1(5)

local textButton7 = Instance.new("TextButton")
textButton7.Parent = mainFrame
textButton7.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textButton7.Position = UDim2.new(0, 15, 0, v7)
textButton7.Size = UDim2.new(0, 230, 0, 30)
textButton7.Font = Enum.Font.Gotham
textButton7.Text = "Show FOV Circle: OFF"
textButton7.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton7.TextSize = 13
textButton7.ZIndex = 11

Instance.new("UICorner", textButton7).CornerRadius = UDim.new(0, 6)

textButton7.MouseButton1Click:Connect(function()
  v1.ShowFOV = not v1.ShowFOV
  fovRing.Visible = v1.ShowFOV

  if v1.ShowFOV then
    textButton7.Text = "Show FOV Circle: ON"
    textButton7.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
  else
    textButton7.Text = "Show FOV Circle: OFF"
    textButton7.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
  end
end)

f1(40)

local textLabel5 = Instance.new("TextLabel")
textLabel5.Parent = mainFrame
textLabel5.BackgroundTransparency = 1
textLabel5.Position = UDim2.new(0, 15, 0, v7)
textLabel5.Size = UDim2.new(0, 200, 0, 20)
textLabel5.Font = Enum.Font.GothamBold
textLabel5.Text = "FOV Circle Color"
textLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel5.TextSize = 13
textLabel5.TextXAlignment = Enum.TextXAlignment.Left
textLabel5.ZIndex = 11

f1(25)
local v11 = 0
local v12 = 0
local v13 = 1

local frame3 = Instance.new("Frame")
frame3.Parent = mainFrame
frame3.Position = UDim2.new(0, 15, 0, v7)
frame3.Size = UDim2.new(0, 230, 0, 100)
frame3.BackgroundTransparency = 1
frame3.ZIndex = 11

local frame4 = Instance.new("Frame")
frame4.Parent = frame3
frame4.Position = UDim2.new(0, 0, 0, 0)
frame4.Size = UDim2.new(1, 0, 0, 20)
frame4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame4.ZIndex = 12

Instance.new("UICorner", frame4).CornerRadius = UDim.new(0, 4)

local uiGradient = Instance.new("UIGradient")
uiGradient.Parent = frame4

uiGradient.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
  ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
  ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
  ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
  ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
  ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
})

local frame5 = Instance.new("Frame")
frame5.Parent = frame4
frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame5.Size = UDim2.new(0, 2, 1, 0)
frame5.ZIndex = 13
frame5.BorderSizePixel = 0

local frame6 = Instance.new("Frame")
frame6.Parent = frame3
frame6.Position = UDim2.new(0, 0, 0, 25)
frame6.Size = UDim2.new(1, 0, 0, 75)
frame6.BackgroundColor3 = Color3.fromHSV(v11, 1, 1)
frame6.ZIndex = 12
frame6.BorderSizePixel = 0

local uiGradient2 = Instance.new("UIGradient")
uiGradient2.Parent = Instance.new("Frame", frame6)
uiGradient2.Parent.Size = UDim2.new(1, 0, 1, 0)
uiGradient2.Parent.ZIndex = 13
uiGradient2.Parent.BackgroundColor3 = Color3.new(1, 1, 1)
uiGradient2.Parent.BorderSizePixel = 0

uiGradient2.Transparency = NumberSequence.new({
  NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
})

local uiGradient3 = Instance.new("UIGradient")
uiGradient3.Parent = Instance.new("Frame", frame6)
uiGradient3.Parent.Size = UDim2.new(1, 0, 1, 0)
uiGradient3.Parent.ZIndex = 14
uiGradient3.Parent.BackgroundColor3 = Color3.new(0, 0, 0)
uiGradient3.Parent.BorderSizePixel = 0
uiGradient3.Rotation = 90

uiGradient3.Transparency = NumberSequence.new({
  NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
})

local frame7 = Instance.new("Frame")
frame7.Parent = frame6
frame7.Size = UDim2.new(0, 8, 0, 8)
frame7.Position = UDim2.new(0, -4, 1, -4)
frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame7.ZIndex = 15

Instance.new("UICorner", frame7).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", frame7).Thickness = 1

local function f2()
  if v1.Rainbow then
    return
  end

  v1.FOVColor = Color3.fromHSV(v11, v12, v13)
  uiStroke.Color = v1.FOVColor
  frame7.BackgroundColor3 = v1.FOVColor
end

local v14 = false
local v15 = false

local function f3(input8)
  local v16 = math.clamp(
    (input8.Position.X - frame4.AbsolutePosition.X) / frame4.AbsoluteSize.X, 0, 1
  )

  frame5.Position = UDim2.new(v16, 0, 0, 0)
  v11 = v16
  frame6.BackgroundColor3 = Color3.fromHSV(v11, 1, 1)
  f2()
end

local function f4(input9)
  local v17 = math.clamp(
    (input9.Position.X - frame6.AbsolutePosition.X) / frame6.AbsoluteSize.X, 0, 1
  )

  local v18 = 1 - math.clamp(
    (input9.Position.Y - frame6.AbsolutePosition.Y) / frame6.AbsoluteSize.Y, 0, 1
  )

  frame7.Position = UDim2.new(v17, -4, 1 - v18, -4)
  v12 = v17
  v13 = v18
  f2()
end

frame4.InputBegan:Connect(function(input10)
  if input10.UserInputType == Enum.UserInputType.MouseButton1 then
    v14 = true
    f3(input10)
  end
end)

frame6.InputBegan:Connect(function(input11)
  if input11.UserInputType == Enum.UserInputType.MouseButton1 then
    v15 = true
    f4(input11)
  end
end)

userInputService.InputEnded:Connect(function(input12)
  if input12.UserInputType == Enum.UserInputType.MouseButton1 then
    v14 = false
    v15 = false
  end
end)

userInputService.InputChanged:Connect(function(input13)
  if input13.UserInputType == Enum.UserInputType.MouseMovement then
    if v14 then
      f3(input13)
    end

    if v15 then
      f4(input13)
    end
  end
end)

f1(110)

local textButton8 = Instance.new("TextButton")
textButton8.Parent = mainFrame
textButton8.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textButton8.Position = UDim2.new(0, 15, 0, v7)
textButton8.Size = UDim2.new(0, 230, 0, 30)
textButton8.Font = Enum.Font.Gotham
textButton8.Text = "Rainbow Fov Circle: OFF"
textButton8.TextColor3 = Color3.fromRGB(255, 255, 255)
textButton8.TextSize = 13
textButton8.ZIndex = 11

Instance.new("UICorner", textButton8).CornerRadius = UDim.new(0, 6)

textButton8.MouseButton1Click:Connect(function()
  v1.Rainbow = not v1.Rainbow

  if v1.Rainbow then
    textButton8.Text = "Rainbow Fov Circle: ON"
    textButton8.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
  else
    textButton8.Text = "Rainbow Fov Circle: OFF"
    textButton8.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    f2()
  end
end)

f1(40)

local textLabel6 = Instance.new("TextLabel")
textLabel6.Parent = mainFrame
textLabel6.BackgroundTransparency = 1
textLabel6.Position = UDim2.new(0, 15, 0, v7)
textLabel6.Size = UDim2.new(0, 100, 0, 30)
textLabel6.Font = Enum.Font.Gotham
textLabel6.Text = "Show Gui:"
textLabel6.TextColor3 = Color3.fromRGB(200, 200, 200)
textLabel6.TextXAlignment = Enum.TextXAlignment.Left
textLabel6.TextSize = 14
textLabel6.ZIndex = 11

local textBox2 = Instance.new("TextBox")
textBox2.Parent = mainFrame
textBox2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
textBox2.Position = UDim2.new(0, 95, 0, v7)
textBox2.Size = UDim2.new(0, 150, 0, 30)
textBox2.Font = Enum.Font.GothamBold
textBox2.Text = v1.ToggleGuiKey
textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox2.TextSize = 14
textBox2.ZIndex = 11

Instance.new("UICorner", textBox2).CornerRadius = UDim.new(0, 6)

textBox2.FocusLost:Connect(function()
  if textBox2.Text == "" then
    textBox2.Text = v1.ToggleGuiKey
  else
    if #textBox2.Text == 1 then
      textBox2.Text = textBox2.Text:upper()
    end

    v1.ToggleGuiKey = textBox2.Text
  end
end)

userInputService.InputBegan:Connect(function(input14, p3)
  if not (userInputService:GetFocusedTextBox() ~= nil)
    and input14.KeyCode.Name:lower() == v1.ToggleGuiKey:lower() then
    mainFrame.Visible = not mainFrame.Visible
  end

  if not p3 and input14.KeyCode.Name == v1.CamLockKey then
    v1.Enabled = not v1.Enabled

    textButton.Text = v1.Enabled and "CamLock: ON" or "CamLock: OFF"

    textButton.BackgroundColor3 = v1.Enabled and Color3.fromRGB(0, 200, 100)
      or Color3.fromRGB(255, 60, 60)

    -- Always clear target reference on key toggle so it fetches a new target
    v8 = nil
  end
end)

local function getTargetPart(character)
  if not character then return nil end
  if character:FindFirstChild(v1.TargetPart) then
    return character[v1.TargetPart]
  end
  if v1.TargetPart == "UpperTorso" and character:FindFirstChild("Torso") then
    return character.Torso
  elseif v1.TargetPart == "Torso" and character:FindFirstChild("UpperTorso") then
    return character.UpperTorso
  end
  return character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
end

local function f5(p4)
  if not v1.WallCheck then
    return true
  else
    local position3 = currentCamera.CFrame.Position
    local position4 = p4.Position

    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, p4.Parent }
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude

    return workspaceService:Raycast(position3, position4 - position3, raycastParams) == nil
  end
end

local f6

local function f7()
  local strength = v1.Strength
  local getMouseLocation2 = userInputService:GetMouseLocation()
  local v19

  for key, value in pairs(players:GetPlayers()) do
    if value ~= localPlayer and f6(value) then
      if not (v1.TeamCheck and value.Team ~= nil and value.Team == localPlayer.Team) then
        local targetPart = getTargetPart(value.Character)
        if targetPart and f5(targetPart) then
          local v20, v21 = currentCamera:WorldToViewportPoint(targetPart.Position)

          if v21 then
            local magnitude = (Vector2.new(v20.X, v20.Y) - getMouseLocation2).Magnitude

            if magnitude < strength then
              strength = magnitude
              v19 = value
            end
          end
        end
      end
    end
  end

  return v19
end

function f6(p5)
  return p5 and p5.Character and getTargetPart(p5.Character) ~= nil
    and p5.Character:FindFirstChild("Humanoid") and p5.Character.Humanoid.Health > 0
end

runService.RenderStepped:Connect(function()
  if v1.ShowFOV then
    local getMouseLocation3 = userInputService:GetMouseLocation()
    fovRing.Position = UDim2.new(0, getMouseLocation3.X, 0, getMouseLocation3.Y)
  end

  if v1.Rainbow then
    local v22 = tick()
    local color2 = Color3.fromHSV(v22 % 5 / 5, 1, 1)
    uiStroke.Color = color2
    textButton8.BackgroundColor3 = color2
  end

  if v1.Enabled then
    -- Find a target if we don't have one active
    if v8 == nil or not f6(v8) then
      -- If target died/invalidated while lock was active, automatically disable
      if v8 ~= nil then
        v1.Enabled = false
        v8 = nil
        textButton.Text = "CamLock: OFF"
        textButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
        return
      end

      v8 = f7()
      if v8 == nil then
        return
      end
    end

    if f6(v8) then
      local v24 = getTargetPart(v8.Character)
      if v24 then
        local cframe = CFrame.new(
          currentCamera.CFrame.Position, v24.Position + (v24.Velocity * v1.Prediction)
        )

        local t = math.clamp((v1.Smoothness - 0.01) / 0.49, 0, 1)
        local curvedT = t * t * t
        local alpha = 0.015 + (curvedT * 0.985)
        
        currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, alpha)
      end
    end
  end
end)
