local pet = script.Parent

function givePet(player)
 if player then
  local Character = player.Character		
  if Character then	
   local humRootPart = Character.HumanoidRootPart		
   local newPet = pet:Clone()
   newPet.Parent = Character		
			
   local bodyPos = Instance.new("BodyPosition",newPet)
   bodyPos.MaxForce = Vector3.new(math.huge,math.huge,math.huge)		
			
   local bodyGyro = Instance.new("BodyGyro",newPet)			
   bodyGyro.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)		
			
   while wait()do			
    bodyPos.Position = humRootPart.Position	+ Vector3.new(2,2,3)		
	bodyGyro.CFrame = humRootPart.CFrame		
   end
  end
 end	
end 

game.Players.PlayerAdded:Connect(function(player)
  player.CharacterAdded:Connect(function(char)
  givePet(player)		
 end)
end)


