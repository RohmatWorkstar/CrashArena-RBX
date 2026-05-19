local barrel = script.Parent
local hasExploded = false

local function explode()
    if hasExploded then return end
    hasExploded = true

    -- Spawn physics explosion
    local exp = Instance.new("Explosion")
    exp.Position = barrel.Position
    exp.BlastRadius = 25
    exp.BlastPressure = 350000 -- Big push!
    exp.ExplosionType = Enum.ExplosionType.NoCraters
    exp.Parent = game.Workspace

    -- Custom fire and flash effects
    local attachment = Instance.new("Attachment", game.Workspace.Terrain)
    attachment.Position = barrel.Position

    local fire = Instance.new("ParticleEmitter")
    fire.Color = ColorSequence.new({
        ColorKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorKeypoint.new(0.2, Color3.fromRGB(255, 120, 0)),
        ColorKeypoint.new(0.8, Color3.fromRGB(50, 0, 0)),
        ColorKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    fire.Size = NumberSequence.new({
        NumberKeypoint.new(0, 2),
        NumberKeypoint.new(0.3, 10),
        NumberKeypoint.new(1, 0)
    })
    fire.Speed = NumberRange.new(20, 45)
    fire.SpreadAngle = Vector2.new(360, 360)
    fire.Lifetime = NumberRange.new(0.4, 0.8)
    fire.Rate = 500
    fire.Parent = attachment
    
    -- Sound Effect
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9114221199" -- Epic cyber explosion
    sound.Volume = 1.0
    sound.Parent = attachment
    sound:Play()

    -- Clean up barrel instantly
    barrel:Destroy()

    -- Fade out particle emitter
    task.wait(0.2)
    fire.Enabled = false
    task.wait(1.5)
    attachment:Destroy()
end

-- Explode if hit hard by a car or player
barrel.Touched:Connect(function(hit)
    local char = hit.Parent
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    
    -- Detect high speed impacts
    local velocity = barrel.AssemblyLinearVelocity.Magnitude
    local hitVelocity = hit.AssemblyLinearVelocity.Magnitude
    
    if humanoid or velocity > 15 or hitVelocity > 15 then
        explode()
    end
end)
