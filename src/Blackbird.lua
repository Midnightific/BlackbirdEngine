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
	Libraries = {},
	Modules = {}
}
Blackbird.__index = Blackbird

local Classes = {"RemoteEvent", "RemoteFunction", "BindableEvent", "BindableFunction"}

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

	if Blackbird.Libraries[Index] then
		Theta = require(self.Libraries[Index])

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

for _, RetrievalClass in ipairs(Classes) do
	local SetFolder = Index(RetrievalClass, "Folder", ReplicatedStorage)

	Blackbird["GetLocal" .. RetrievalClass] = function(self, ItemName)
		return Index(ItemName, RetrievalClass, SetFolder)
	end

	Blackbird["WaitFor" .. RetrievalClass] = function(self, ItemName)
		return SetFolder:WaitForChild(ItemName, math.huge)
	end

	Blackbird["Get" .. RetrievalClass] = function(self, ItemName)
		local Item = SetFolder:FindFirstChild(ItemName)
		if Item then return Item end

		if RunService:IsClient() then
			return SetFolder:WaitForChild(ItemName)
		else
			return self["GetLocal" .. RetrievalClass](self, ItemName)
		end
	end
end

if RunService:IsClient() then
	script:SetAttribute("ClientLoaded", true)
end

if RunService:IsServer() then
	script:SetAttribute("ServerLoaded", true)
end

return Blackbird
