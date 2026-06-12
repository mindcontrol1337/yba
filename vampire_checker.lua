-- Vampire Auto-Target Checker
-- Runs independently, teleports to valid vampires every 3s

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getValidVampire()
    for _, v in pairs(workspace.Living:GetChildren()) do
        if v.Name == "Vampire" 
            and v:FindFirstChild("HumanoidRootPart") 
            and v:FindFirstChild("Humanoid") 
            and v.Humanoid.Health > 0 then
            
            local hrp = v.HumanoidRootPart
            if hrp.Transparency < 1 and hrp.Size.Magnitude > 1 then
                return v
            end
        end
    end
    return nil
end

task.spawn(function()
    print("[VampireChecker] Started")
    while task.wait(3) do
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            continue
        end
        
        local vampire = getValidVampire()
        if vampire and vampire:FindFirstChild("HumanoidRootPart") then
            print("[VampireChecker] Valid vampire found, teleporting...")
            LocalPlayer.Character.HumanoidRootPart.CFrame = vampire.HumanoidRootPart.CFrame - Vector3.new(0, 15, 0)
        else
            print("[VampireChecker] No valid vampire found")
        end
    end
end)

print("[VampireChecker] Loaded - runs every 3 seconds")