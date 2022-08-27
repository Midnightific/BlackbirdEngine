--// Initialization

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Blackbird = require(ReplicatedStorage:WaitForChild("Blackbird"))


--// Functions

local function NetworkCheck(RemoteEvent)
	--/ Create a function that checks to see if we can load and fire a remote event.
	
	local RemoteEvent = Blackbird:GetRemoteEvent(RemoteEvent)
	
	local success, err = pcall(function()
		if RemoteEvent then
			RemoteEvent:FireServer()
			print("Network check passed.")
		else
			print("Network error: " .. error(debug.traceback()))
		end
	end)
end

NetworkCheck("TestRemoteEvent")
