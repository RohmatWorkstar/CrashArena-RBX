------------------------------------
modelname="1b"
------------------------------------

function onTouched(part)
	if part.Parent ~= nil then
		local h = part.Parent:FindFirstChild("Humanoid")
		if h ~= nil then
			local teleportfrom = script.Parent.Enabled.Value
			if teleportfrom ~= 0 then
				local teleportto = script.Parent.Parent:FindFirstChild(modelname)
				if teleportto ~= nil then
					local torso = h.Parent:FindFirstChild("HumanoidRootPart") or h.Parent:FindFirstChild("Torso")
					if torso ~= nil then
						local location = {teleportto.Position}
						local i = 1

						local x = location[i].x
						local y = location[i].y
						local z = location[i].z
					
						x = x + math.random(-1, 1)
						z = z + math.random(-1, 1)
						y = y + math.random(2, 3)

						script.Parent.Enabled.Value = 0
						teleportto.Enabled.Value = 0
						
						torso.CFrame = CFrame.new(Vector3.new(x, y, z))
						print("[Teleport] Teleported player " .. h.Parent.Name .. " to " .. modelname)
						
						wait(3)
						script.Parent.Enabled.Value = 1
						teleportto.Enabled.Value = 1
					end
				else
					print("Could not find teleporter!")
				end
			end
		end
	end
end

script.Parent.Touched:Connect(onTouched)

