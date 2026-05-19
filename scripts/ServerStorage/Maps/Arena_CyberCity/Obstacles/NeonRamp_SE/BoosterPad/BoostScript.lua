local pad = script.Parent
pad.Touched:Connect(function(hit)
    local char = hit.Parent
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    if root and not char:FindFirstChild("BoostCooldown") then
        -- Add cooldown tag to prevent double triggers
        local cd = Instance.new("Configuration")
        cd.Name = "BoostCooldown"
        cd.Parent = char
        game.Debris:AddItem(cd, 1.5)
        
        -- Play a high launch sound if possible, or just apply force
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://9126214101" -- Cyber booster sound
        sound.Volume = 1.0
        sound.Parent = root
        sound:Play()
        game.Debris:AddItem(sound, 2)
        
        -- Apply a major forward and upward velocity boost
        local launchDirection = pad.CFrame.LookVector
        -- Force it to go forward and upward relative to the ramp slope
        root.AssemblyLinearVelocity = (launchDirection * 140) + Vector3.new(0, 90, 0)
        
        -- Add a cool fire/wind trail effect to the player temporarily
        local attachment = Instance.new("Attachment", root)
        local trail = Instance.new("Trail", attachment)
        trail.Color = ColorSequence.new(Color3.fromRGB(255, 100, 0), Color3.fromRGB(255, 255, 0))
        trail.Lifetime = 0.5
        trail.WidthScale = NumberSequence.new(1, 0)
        -- We attach to two points to make the trail visible
        local a0 = Instance.new("Attachment", root)
        a0.Position = Vector3.new(0, 1, 0)
        local a1 = Instance.new("Attachment", root)
        a1.Position = Vector3.new(0, -1, 0)
        trail.Attachment0 = a0
        trail.Attachment1 = a1
        
        task.wait(1.2)
        a0:Destroy()
        a1:Destroy()
        attachment:Destroy()
    end
end)
