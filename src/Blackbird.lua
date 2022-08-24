--[[
	This game uses the "Blackbird" framework written and licensed by Midnightific.
	Further information can be found here: https://www.github.com/Midnightific/Blackbird
]]--

--// Initialization

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Blackbird = {
	Modules = {}
}
Blackbird.__index = Blackbird

local Cache = {}

local LibrariesFolder = ReplicatedStorage.Libraries::Folder

--// Functions

local function Index(ObjectName, ObjectClass, ObjectParent)
	--/ Searches to retrieve an object/instance and creates a new one if it cannot find it.
	
	local Theta = ObjectParent:FindFirstChild(ObjectName)
	
	if not Theta then
		local Theta = Instance.new(ObjectClass)
		
		Theta.Name = ObjectName
		Theta.Parent = ObjectParent
	end
	
	return Theta
end

function Blackbird._BindToTag(Tag, InstanceCallback)
	--/ Binds a function to an instance.
	
	CollectionService:GetInstanceAddedSignal(Tag):Connect(InstanceCallback)
	
	for _, Item in ipairs(CollectionService:GetTagged(Tag)) do
		InstanceCallback(Tag)
	end
end

function Blackbird:LoadLibrary(Index)
	--/ Searches for a module, returns it if it is founds, returns an error if it is not.
	if not Index then
		print("You must specify an index for Blackbird to load!")
	end
	
	local Theta
	
	if Blackbird.Modules[Index] then
		Theta = require(self.Modules[Index])
		
		return require(Theta)
	end
	
	if not Theta then
		for _, Module in ipairs(CollectionService:GetDescendants("bModule")) do
			if Module.Name:upper() == Index:upper() then
				Theta = Index
			end
		end
	end
	
	return Theta
end

return Blackbird
