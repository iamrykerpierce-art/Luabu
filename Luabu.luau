local Luabu = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local Shared = script:WaitForChild("Shared")
local Packages = script:WaitForChild("Packages")

local ServerPackages = Packages.ServerPackages
local ClientPackages = Packages.ClientPackages

local initialized = false

local Version
local Enums
local TableManager

local function LoadPackages()
	if #ClientPackages:GetChildren() == 0 then
		warn("[Luabu] No client packages were found")
	end
	
	if #ServerPackages:GetChildren() == 0 then
		warn("[Luabu] No server packages were found")
		return
	end
	
	if RunService:IsServer() then
		for _, package in ipairs(ServerPackages:GetChildren()) do
			if not package:IsA("ModuleScript") then
				warn("[Luabu] Invalid Server package: " .. package.Name)
				continue
			else
				require(package)
			end
		end
	else
		for _, package in ipairs(ClientPackages:GetChildren()) do
			if not package:IsA("ModuleScript") then
				warn("[Luabu] Invalid Client package: " .. package.Name)
				continue
			else
				local success, result = pcall(require, package)
				if not success then
					warn("[Luabu] Failed:", package.Name, result)
				end
			end
		end
	end
end

function Luabu.init()
	if initialized then
		warn("[Luabu] Already initialized")
		return
	end
	
	initialized = true
	
	if script.Parent ~= ReplicatedStorage then warn("[Luabu] Luabu must be parented to ReplicatedStorage to work") return end
	
	Enums = require(script:WaitForChild("Shared"):WaitForChild("Enums"))
	TableManager = require(script:WaitForChild("Shared"):WaitForChild("TableManager"))
	
	if RunService:IsServer() then
		Version = require(script:WaitForChild("Version"))
		print("[Luabu] Version: " .. Version.Version)
	end
	
	LoadPackages()
end

function Luabu.StringToEnum(str: string)
	return Enums.StringToEnum(str)
end

function Luabu.CreateTable(name:string, defaultdata)
	return TableManager.Create(name, defaultdata)
end

function Luabu.GetTable(name)
	return TableManager.Get(name)
end

function Luabu.UpdateTable(name, key, value)
	return TableManager.Update(name, key, value)
end

function Luabu.RemoveTable(name)
	return TableManager.Remove(name)
end

function Luabu.TableExists(name)
	return TableManager.Exists(name)
end

function Luabu.ClearTables()
	return TableManager.Clear()
end

return Luabu
