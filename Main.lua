
-- Client's GUI - Modern Frosted Glass Interface
-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local isGuiVisible = true

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ClientsGUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.Parent = playerGui

-- Main Frame (Background with frosted glass effect)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 280)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ZIndex = 10
mainFrame.Parent = screenGui

-- Frosted glass overlay with blur effect
local glassOverlay = Instance.new("Frame")
glassOverlay.Name = "GlassOverlay"
glassOverlay.Size = UDim2.new(1, 0, 1, 0)
glassOverlay.Position = UDim2.new(0, 0, 0, 0)
glassOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glassOverlay.BackgroundTransparency = 0.85
glassOverlay.BorderSizePixel = 0
glassOverlay.ZIndex = 11
glassOverlay.Parent = mainFrame

-- Background blur effect
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 8
blurEffect.Parent = workspace.CurrentCamera

-- Corner rounding
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local glassCorner = Instance.new("UICorner")
glassCorner.CornerRadius = UDim.new(0, 15)
glassCorner.Parent = glassOverlay

-- Enhanced drop shadow
local shadowFrame = Instance.new("Frame")
shadowFrame.Name = "Shadow"
shadowFrame.Size = UDim2.new(1, 12, 1, 12)
shadowFrame.Position = UDim2.new(0, -6, 0, -6)
shadowFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadowFrame.BackgroundTransparency = 0.75
shadowFrame.BorderSizePixel = 0
shadowFrame.ZIndex = 9
shadowFrame.Parent = mainFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 18)
shadowCorner.Parent = shadowFrame

-- Resize handle
local resizeHandle = Instance.new("Frame")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.new(0, 14, 0, 14)
resizeHandle.Position = UDim2.new(1, -14, 1, -14)
resizeHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
resizeHandle.BackgroundTransparency = 0.7
resizeHandle.BorderSizePixel = 0
resizeHandle.ZIndex = 15
resizeHandle.Parent = mainFrame

local resizeCorner = Instance.new("UICorner")
resizeCorner.CornerRadius = UDim.new(0, 3)
resizeCorner.Parent = resizeHandle

-- Resize functionality
local resizing = false
local startSize
local startPosition

resizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        startSize = mainFrame.Size
        startPosition = input.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startPosition
        local newSizeX = math.max(320, startSize.X.Offset + delta.X)
        local newSizeY = math.max(260, startSize.Y.Offset + delta.Y)
        mainFrame.Size = UDim2.new(0, newSizeX, 0, newSizeY)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

-- Header Section with proper spacing
local headerFrame = Instance.new("Frame")
headerFrame.Name = "Header"
headerFrame.Size = UDim2.new(1, -16, 0, 45)
headerFrame.Position = UDim2.new(0, 8, 0, 8)
headerFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
headerFrame.BackgroundTransparency = 0.9
headerFrame.BorderSizePixel = 0
headerFrame.ZIndex = 12
headerFrame.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 10)
headerCorner.Parent = headerFrame

-- User Avatar with better positioning
local avatarFrame = Instance.new("Frame")
avatarFrame.Name = "AvatarFrame"
avatarFrame.Size = UDim2.new(0, 32, 0, 32)
avatarFrame.Position = UDim2.new(0, 10, 0.5, -16)
avatarFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
avatarFrame.BorderSizePixel = 0
avatarFrame.ZIndex = 13
avatarFrame.Parent = headerFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0.5, 0)
avatarCorner.Parent = avatarFrame

-- Load user avatar
local avatarImage = Instance.new("ImageLabel")
avatarImage.Size = UDim2.new(1, 0, 1, 0)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
avatarImage.ZIndex = 14
avatarImage.Parent = avatarFrame

local avatarImageCorner = Instance.new("UICorner")
avatarImageCorner.CornerRadius = UDim.new(0.5, 0)
avatarImageCorner.Parent = avatarImage

-- Username Label with better alignment
local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "Username"
usernameLabel.Size = UDim2.new(0, 140, 0, 18)
usernameLabel.Position = UDim2.new(0, 50, 0.5, -9)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "Welcome, " .. player.Name
usernameLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
usernameLabel.TextScaled = true
usernameLabel.Font = Enum.Font.SourceSans
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.ZIndex = 13
usernameLabel.Parent = headerFrame

-- Navigation Frame with fixed positioning
local navFrame = Instance.new("Frame")
navFrame.Name = "Navigation"
navFrame.Size = UDim2.new(0, 100, 1, -70)
navFrame.Position = UDim2.new(0, 8, 0, 60)
navFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
navFrame.BackgroundTransparency = 0.9
navFrame.BorderSizePixel = 0
navFrame.ZIndex = 12
navFrame.Parent = mainFrame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 10)
navCorner.Parent = navFrame

-- Content Frame with fixed positioning
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(0, 236, 1, -70)
contentFrame.Position = UDim2.new(0, 116, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
contentFrame.BackgroundTransparency = 0.9
contentFrame.BorderSizePixel = 0
contentFrame.ZIndex = 12
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = contentFrame

-- Section data
local sections = {
    {name = "Home"},
    {name = "Tools"},
    {name = "Games"},
    {name = "Other"},
    {name = "Settings"}
}

local sectionButtons = {}
local contentSections = {}
local currentSection = 1

-- Animation tweens
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local hoverTweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Create navigation buttons with proper layout
for i, section in ipairs(sections) do
    local button = Instance.new("TextButton")
    button.Name = section.name .. "Button"
    button.Size = UDim2.new(1, -12, 0, 32)
    button.Position = UDim2.new(0, 6, 0, (i-1) * 38 + 6)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = i == 1 and 0.8 or 0.92
    button.BorderSizePixel = 0
    button.Text = section.name
    button.TextColor3 = Color3.fromRGB(245, 245, 255)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSans
    button.ZIndex = 13
    button.Parent = navFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    sectionButtons[i] = button
    
    -- Create content section with proper positioning
    local sectionContent = Instance.new("Frame")
    sectionContent.Name = section.name .. "Content"
    sectionContent.Size = UDim2.new(1, -12, 1, -12)
    sectionContent.Position = UDim2.new(0, 6, 0, 6)
    sectionContent.BackgroundTransparency = 1
    sectionContent.Visible = i == 1
    sectionContent.ZIndex = 13
    sectionContent.Parent = contentFrame
    
    -- Section title with better styling
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 24)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = section.name
    titleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 14
    titleLabel.Parent = sectionContent
    
    -- Create three test buttons stacked vertically with improved styling
    for j = 1, 3 do
        local testButton = Instance.new("TextButton")
        testButton.Name = "TestButton" .. j
        testButton.Size = UDim2.new(1, -12, 0, 26)
        testButton.Position = UDim2.new(0, 6, 0, 30 + (j-1) * 32)
        testButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        testButton.BackgroundTransparency = 0.85
        testButton.BorderSizePixel = 0
        testButton.Text = "Test " .. j
        testButton.TextColor3 = Color3.fromRGB(245, 245, 255)
        testButton.TextScaled = true
        testButton.Font = Enum.Font.SourceSans
        testButton.ZIndex = 14
        testButton.Parent = sectionContent
        
        local testCorner = Instance.new("UICorner")
        testCorner.CornerRadius = UDim.new(0, 6)
        testCorner.Parent = testButton
        
        -- Test button animations
        testButton.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(testButton, hoverTweenInfo, {
                BackgroundTransparency = 0.7,
                Size = UDim2.new(1, -10, 0, 28)
            })
            hoverTween:Play()
        end)
        
        testButton.MouseLeave:Connect(function()
            local leaveTween = TweenService:Create(testButton, hoverTweenInfo, {
                BackgroundTransparency = 0.85,
                Size = UDim2.new(1, -12, 0, 26)
            })
            leaveTween:Play()
        end)
        
        testButton.MouseButton1Click:Connect(function()
            local clickTween = TweenService:Create(testButton, TweenInfo.new(0.08), {
                Size = UDim2.new(1, -14, 0, 24)
            })
            clickTween:Play()
            
            clickTween.Completed:Connect(function()
                local releaseTween = TweenService:Create(testButton, TweenInfo.new(0.08), {
                    Size = UDim2.new(1, -10, 0, 28)
                })
                releaseTween:Play()
            end)
        end)
    end
    
    contentSections[i] = sectionContent
    
    -- Button hover effects
    button.MouseEnter:Connect(function()
        if i ~= currentSection then
            local hoverTween = TweenService:Create(button, hoverTweenInfo, {
                BackgroundTransparency = 0.85
            })
            hoverTween:Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if i ~= currentSection then
            local leaveTween = TweenService:Create(button, hoverTweenInfo, {
                BackgroundTransparency = 0.92
            })
            leaveTween:Play()
        end
    end)
    
    -- Fixed button click handler for proper section switching
    button.MouseButton1Click:Connect(function()
        if i ~= currentSection then
            -- Deactivate current section button
            local deactivateTween = TweenService:Create(sectionButtons[currentSection], tweenInfo, {
                BackgroundTransparency = 0.92
            })
            deactivateTween:Play()
            
            -- Hide current content with smooth fade
            contentSections[currentSection].Visible = false
            
            -- Activate new section button
            local activateTween = TweenService:Create(button, tweenInfo, {
                BackgroundTransparency = 0.8
            })
            activateTween:Play()
            
            -- Show new content immediately
            contentSections[i].Visible = true
            
            currentSection = i
        end
    end)
end

-- Toggle functionality with backtick key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.Backquote then
        isGuiVisible = not isGuiVisible
        
        if isGuiVisible then
            screenGui.Enabled = true
            local showTween = TweenService:Create(mainFrame, tweenInfo, {
                Position = UDim2.new(0.5, -180, 0.5, -140),
                BackgroundTransparency = 0.15
            })
            showTween:Play()
        else
            local hideTween = TweenService:Create(mainFrame, tweenInfo, {
                Position = UDim2.new(0.5, -180, 1.5, -140),
                BackgroundTransparency = 1
            })
            hideTween:Play()
            
            hideTween.Completed:Connect(function()
                if not isGuiVisible then
                    screenGui.Enabled = false
                end
            end)
        end
    end
end)

-- Smooth entrance animation
mainFrame.Position = UDim2.new(0.5, -180, 1.5, -140)
mainFrame.BackgroundTransparency = 1
glassOverlay.BackgroundTransparency = 1

wait(0.1)

local entranceTween = TweenService:Create(mainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, -180, 0.5, -140),
    BackgroundTransparency = 0.15
})

local glassEntranceTween = TweenService:Create(glassOverlay, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.85
})

entranceTween:Play()
glassEntranceTween:Play()

-- Close button with improved styling
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 18, 0, 18)
closeButton.Position = UDim2.new(1, -24, 0, 6)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundTransparency = 0.8
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(245, 245, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.SourceSansBold
closeButton.ZIndex = 15
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0.5, 0)
closeCorner.Parent = closeButton

closeButton.MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(closeButton, hoverTweenInfo, {
        BackgroundTransparency = 0.6,
        Size = UDim2.new(0, 20, 0, 20)
    })
    hoverTween:Play()
end)

closeButton.MouseLeave:Connect(function()
    local leaveTween = TweenService:Create(closeButton, hoverTweenInfo, {
        BackgroundTransparency = 0.8,
        Size = UDim2.new(0, 18, 0, 18)
    })
    leaveTween:Play()
end)

closeButton.MouseButton1Click:Connect(function()
    local exitTween = TweenService:Create(mainFrame, tweenInfo, {
        Position = UDim2.new(0.5, -180, 1.5, -140),
        BackgroundTransparency = 1
    })
    exitTween:Play()
    
    exitTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

print("Client's GUI loaded successfully!")
print("Features: Compact, draggable, resizable, backtick toggle, stays on top, smooth animations")
