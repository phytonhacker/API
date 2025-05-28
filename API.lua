local GuiAPI = {}
GuiAPI.__index = GuiAPI

function GuiAPI.new()
	local self = setmetatable({}, GuiAPI)
	self.Gui = nil
	self.Window = nil
	return self
end

function GuiAPI:CreateWindow(movable)
	local player = game:GetService("Players").LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	local gui = Instance.new("ScreenGui")
	gui.Name = "CustomWindow"
	gui.ResetOnSpawn = false
	gui.Parent = playerGui

	local window = Instance.new("Frame")
	window.Size = UDim2.new(0, 300, 0, 200)
	window.Position = UDim2.new(0.5, -150, 0.5, -100)
	window.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	window.BorderSizePixel = 0
	window.Parent = gui

	if movable then
		window.Active = true
		window.Draggable = true
	end

	self.Gui = gui
	self.Window = window
end

return GuiAPI
