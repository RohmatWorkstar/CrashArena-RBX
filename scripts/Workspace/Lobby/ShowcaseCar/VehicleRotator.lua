local model = script.Parent
local speed = 18 -- Degrees per second
while true do
    local currentCF = model:GetPivot()
    model:PivotTo(currentCF * CFrame.Angles(0, math.rad(speed * task.wait()), 0))
end
