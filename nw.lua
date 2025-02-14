local islandLocations = {}
local shipNames = {'Battleship', 'Carrier', 'Heavy Cruiser', 'Cruiser', 'Destroyer', 'Submarine'}
local vehicleLocations = {}
local allDescendants = game.Workspace:GetDescendants()

-- get island locations
for _, v in ipairs(allDescendants) do
    if v.Name == "Island" then
        islandLocations[v:FindFirstChild("IslandCode").Value] = v:GetPivot().Position
    end
end

local function processAllShips(shipClass)
    for _, v in ipairs(allDescendants) do
        if v.Name == shipClass then
            local owner = v:FindFirstChild("Owner")
            owner = owner and owner.Value or nil
            local occupant = v:FindFirstChild("Occupant")
            occupant = occupant and occupant.Value or nil

            identifier = shipClass..'.'..(owner ~= "" and owner or "default")
            vehicleLocations[identifier] = {
                ["location"] = v:GetPivot().Position,
                ["owner"] = (owner ~= "" and owner or "default"),
                ["occupant"] = (occupant ~= "" and occupant or "N/A")
            }
        end
    end
end 

-- get everything locations
for i, shipClass in ipairs(shipNames) do
    processAllShips(shipClass)
end

local function makeLabel(text, parent)
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 0.2, 0)
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = parent
    return textLabel
end


-- ui shit
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 200)
frame.Position = UDim2.new(0.5, -300, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui
local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)
padding.Parent = frame
makeLabel("Echelon 3", frame)
makeLabel("Teleport", frame).TextXAlignment = Enum.TextXAlignment.Left

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0, 300, 0, 400)
scrollFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
scrollFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scrollFrame.ScrollBarThickness = 10
scrollFrame.Parent = frame

-- Create a UIListLayout for buttons
local layout = Instance.new("UIListLayout")
layout.Parent = scrollFrame
layout.Padding = UDim.new(0, 10)

-- Add buttons to the scroll frame
for i = 1, 10 do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 250, 0, 50)
    button.Text = "Button " .. i
    button.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Parent = scrollFrame
end
