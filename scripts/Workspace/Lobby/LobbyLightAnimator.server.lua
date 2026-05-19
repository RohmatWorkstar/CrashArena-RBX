-- LobbyLightAnimator.server.lua
-- Animates the Lobby lights and neon parts to create a smooth, premium, "friendly-to-the-eyes" nightclub pulse and color-cycling effect.

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local lobby = script.Parent

-- Premium nightclub color palette (very smooth, luxury lounge vibes)
local PALETTE = {
	Color3.fromRGB(0, 191, 255),    -- Cyan (Deep Sky Blue)
	Color3.fromRGB(138, 43, 226),   -- Blue Violet
	Color3.fromRGB(255, 0, 127),    -- Rose/Pink Magenta
	Color3.fromRGB(75, 0, 130),     -- Indigo
	Color3.fromRGB(0, 255, 255)     -- Bright Cyan
}

-- Settings
local COLOR_CYCLE_SPEED = 0.15 -- Speed of color fading (higher = faster, 0.15 is very relaxed)
local PULSE_SPEED = 1.5 -- Speed of brightness pulsing (smooth breathing rhythm)
local MIN_BRIGHTNESS = 0.5
local MAX_BRIGHTNESS = 3.5

-- Gather lights and neon parts
local pulseLights = {}
local neonParts = {}

-- Find neon parts to cycle color
for _, child in ipairs(lobby:GetDescendants()) do
	if child:IsA("BasePart") then
		if child.Name == "PedestalNeon" or child.Name == "SpawnRing" or child.Name == "SpotlightSupport" then
			table.insert(neonParts, child)
		end
		-- Also target parts with Neon material
		if child.Material == Enum.Material.Neon then
			table.insert(neonParts, child)
		end
	end
	
	if child:IsA("Light") then
		-- Keep a record of their original brightness
		local origBrightness = child.Brightness
		table.insert(pulseLights, {
			instance = child,
			original = origBrightness
		})
	end
end

print("[LobbyLightAnimator] Animating " .. #pulseLights .. " lights and " .. #neonParts .. " neon elements!")

-- Color cycling variables
local colorIndex = 1
local targetIndex = 2
local transitionProgress = 0

RunService.Heartbeat:Connect(function(dt)
	-- 1. Smoothly cycle colors
	transitionProgress = transitionProgress + (dt * COLOR_CYCLE_SPEED)
	if transitionProgress >= 1 then
		transitionProgress = 0
		colorIndex = targetIndex
		targetIndex = (targetIndex % #PALETTE) + 1
	end
	
	local currentColor = PALETTE[colorIndex]:Lerp(PALETTE[targetIndex], transitionProgress)
	
	-- Apply current color to neon parts
	for _, part in ipairs(neonParts) do
		part.Color = currentColor
	end
	
	-- 2. Smoothly pulse brightness using sine wave
	local t = os.clock()
	local pulseMultiplier = (math.sin(t * PULSE_SPEED) + 1) / 2 -- Ranges from 0 to 1
	local currentBrightness = MIN_BRIGHTNESS + (pulseMultiplier * (MAX_BRIGHTNESS - MIN_BRIGNTNESS or 3.0)) -- Fix typo if any
	
	for _, lightData in ipairs(pulseLights) do
		local light = lightData.instance
		if light and light.Parent then
			-- Sync light color with current cycle color
			light.Color = currentColor
			
			-- Scale brightness
			light.Brightness = currentBrightness
		end
	end
end)
