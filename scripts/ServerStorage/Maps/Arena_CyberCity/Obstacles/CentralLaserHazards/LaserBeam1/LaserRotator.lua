local beam = script.Parent
local speed = 60 -- Degrees per second

-- Rotate loop
task.spawn(function()
    while true do
        beam.CFrame = beam.CFrame * CFrame.Angles(0, math.rad(speed * task.wait()), 0)
    end
end)

-- Touched handler
beam.Touched:Connect(function(hit)
    local char = hit.Parent
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    
    if humanoid and root and not char:FindFirstChild("LaserCooldown") then
        -- Hit cooldown
        local cd = Instance.new("Configuration")
        cd.Name = "LaserCooldown"
        cd.Parent = char
        game.Debris:AddItem(cd, 0.8)
        
        -- Play zap sound
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9125633391" -- Cyber zap sound
        sound.Volume = 0.8
        sound.Parent = root
        sound:Play()
        game.Debris:AddItem(sound, 1.5)
        
        -- Damage player
        humanoid:TakeDamage(15)
        
        -- Dynamic sparks particles on hit
        local sparks = Instance.new("ParticleEmitter")
        sparks.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 255))
        sparks.Size = NumberSequence.new(0.5, 0)
        sparks.Speed = NumberRange.new(15, 30)
        sparks.SpreadAngle = Vector2.new(360, 360)
        sparks.Lifetime = NumberRange.new(0.2, 0.4)
        sparks.Rate = 100
        sparks.Parent = root
        task.spawn(function()
            task.wait(0.25)
            sparks.Enabled = false
            task.wait(0.5)
            sparks:Destroy()
        end)
        
        -- Apply minor knockback force away from laser center
        local forceDir = (root.Position - Vector3.new(-15, root.Position.Y, -32)).Unit
        root.AssemblyLinearVelocity = forceDir * 60 + Vector3.new(0, 20, 0)
    end
end)
