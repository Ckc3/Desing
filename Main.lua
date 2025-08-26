-- Flying Mod for Roblox
-- Auto-enables when loaded

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Flying variables
local flying = false
local speed = 50
local bodyVelocity
local bodyAngularVelocity

-- Create BodyVelocity and BodyAngularVelocity objects
local function createBodyMovers()
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.MaxTorque = Vector3.new(4000, 4000, 4000)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
    bodyAngularVelocity.Parent = rootPart
end

-- Remove BodyMovers
local function removeBodyMovers()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyAngularVelocity then
        bodyAngularVelocity:Destroy()
        bodyAngularVelocity = nil
    end
end

-- Start flying
local function startFlying()
    flying = true
    humanoid.PlatformStand = true
    createBodyMovers()
    print("Flying enabled!")
end

-- Stop flying
local function stopFlying()
    flying = false
    humanoid.PlatformStand = false
    removeBodyMovers()
    print("Flying disabled!")
end

-- Movement function
local function fly()
    if not flying or not bodyVelocity then return end

    local camera = workspace.CurrentCamera
    local moveVector = humanoid.MoveDirection
    local cameraDirection = camera.CFrame.LookVector
    local cameraRight = camera.CFrame.RightVector

    -- Calculate movement direction based on camera and input
    local direction = Vector3.new(0, 0, 0)

    if moveVector.Magnitude > 0 then
        direction = (cameraDirection * moveVector.Z + cameraRight * moveVector.X).Unit
    end

    -- Add vertical movement (jump = up, crouch = down)
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        direction = direction + Vector3.new(0, 1, 0)
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
        direction = direction + Vector3.new(0, -1, 0)
    end

    -- Apply velocity
    bodyVelocity.Velocity = direction * speed
end

-- Connect movement updates
RunService.Heartbeat:Connect(fly)

-- Handle character respawning
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")

    if flying then
        stopFlying()
    end
end)

-- Auto-enable flying when script loads
startFlying()

print("Flying mod loaded and enabled!")
print("Controls: WASD to move, Space to go up, Left Shift to go down")
