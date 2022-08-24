--// Initialization

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Blackbird = require(ReplicatedStorage:WaitForChild("Blackbird"))

--// Functions

local function LoadModuleTest(ThetaModule)
	--/ Run a check to see if we can load the module directly.
	
	require(ThetaModule)
	
	--/ This will run if the previous check is passed, now we check if Blackbird can load it.
	
	Blackbird:LoadLibrary(ThetaModule.Name)
end

local function Check(Folder)
	for _, Module in ipairs(Folder:GetChildren()) do
		if Module:IsA("ModuleScript") then
			if not Module.Name:find(".spec") then
				LoadModuleTest(Module)
			end
		end
	end
end

--/ Run the check
Check(ReplicatedStorage.Libraries)
