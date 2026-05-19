-- LobbyLightAnimator.server.lua
-- Animates the Lobby lights and neon parts to create a smooth, premium, "friendly-to-the-eyes" nightclub pulse and color-cycling effect.

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local lobby = script.Parent

-- Soft, subdued, pastel nightclub color palette (very relaxed, high-end lounge vibes)
local PALETTE = {
	Color3.fromRGB(30, 110, 150),    -- Soft Steel Blue (subdued cyan)
	Color3.fromRGB(90, 50, 140),     -- Soft Muted Violet
	Color3.fromRGB(140, 40, 100),    -- Soft Rose Gold / Wine Magenta
	Color3.fromRGB(50, 40, 110),     -- Muted Twilight Indigo
	Color3.fromRGB(40, 130, 140)     -- Pastel Teal (softer cyan)
}

-- Settings (tuned for a beautiful, bright showroom atmosphere)
local COLOR_CYCLE_SPEED = 0.12 -- Speed of color fading
local PULSE_SPEED = 1.2 -- Smooth breathing rhythm
local MIN_BRIGHTNESS = 1.0 -- Increased from 0.3 for a much brighter base light level
local MAX_BRIGHTNESS = 2.8 -- Increased from 1.6 to make the local lights shine beautifully bright

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

print("[LobbyLightAnimator] Animating " .. #pulseLights .. " lights and " .. #neonParts .. " neon elements with brighter, vibrant, comfortable ambient hues!")

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
	local currentBrightness = MIN_BRIGHTNESS + (pulseMultiplier * (MAX_BRIGHTNESS - MIN_BRIGHTNESS))
	
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
