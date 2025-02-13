Players = cloneref(game:GetService("Players"))
RunService = cloneref(game:GetService("RunService"))
speaker = Players.LocalPlayer

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function unfling() 
	if flingDied then
		flingDied:Disconnect()
	end
	flinging = false
	wait(.1)
	local speakerChar = speaker.Character
	if not speakerChar or not getRoot(speakerChar) then return end
	for i,v in pairs(getRoot(speakerChar):GetChildren()) do
		if v.ClassName == 'BodyAngularVelocity' then
			v:Destroy()
		end
	end
	for _, child in pairs(speakerChar:GetDescendants()) do
		if child.ClassName == "Part" or child.ClassName == "MeshPart" then
			child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
		end
	end
end

function noclip()
	Clip = false
	wait(0.1)
	local function NoclipLoop()
		if Clip == false and speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
					child.CanCollide = false
				end
			end
		end
	end
	Noclipping = RunService.Stepped:Connect(NoclipLoop)
end

function invisible()
	local ch = speaker.Character
	local prt=Instance.new("Model")
	prt.Parent = speaker.Character
	local z1 = Instance.new("Part")
	z1.Name="Torso"
	z1.CanCollide = false
	z1.Anchored = true
	local z2 = Instance.new("Part")
	z2.Name="Head"
	z2.Parent = prt
	z2.Anchored = true
	z2.CanCollide = false
	local z3 =Instance.new("Humanoid")
	z3.Name="Humanoid"
	z3.Parent = prt
	z1.Position = Vector3.new(0,9999,0)
	speaker.Character=prt
	wait(3)
	speaker.Character=ch
	wait(3)
	for i,v in pairs(speaker.Character:GetChildren()) do
	    if v ~= getRoot(speaker.Character) and  v.Name ~= "Humanoid" then
	        v:Destroy()
	    end
	end
	getRoot(speaker.Character).Transparency = 0
end

function fling()
    local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
    if humanoid then
        humanoid.Died:Connect(function()
        	walkflinging = false
        end)
    end

    noclip()
    walkflinging = true
    repeat RunService.Heartbeat:Wait()
        local character = speaker.Character
        local root = getRoot(character)
        local vel, movel = nil, 0.1

        while not (character and character.Parent and root and root.Parent) do
            RunService.Heartbeat:Wait()
            character = speaker.Character
            root = getRoot(character)
        end

        vel = root.Velocity
        root.Velocity = vel * 1000000 + Vector3.new(0, 1000000, 0)

        RunService.RenderStepped:Wait()
        if character and character.Parent and root and root.Parent then
            root.Velocity = vel
        end

        RunService.Stepped:Wait()
        if character and character.Parent and root and root.Parent then
            root.Velocity = vel + Vector3.new(0, movel, 0)
            movel = movel * -1
        end
    until walkflinging == false
end

fling()
