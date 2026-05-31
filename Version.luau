local Version = {}

local HttpService = game:GetService("HttpService")

Version.Version = "1.0.0"
Version.LatestVersion = nil

local Link = "https://raw.githubusercontent.com/iamrykerpierce-art/Luabu/main/version.json"

task.spawn(function()
	local success, response = pcall(function()
		return HttpService:GetAsync(Link)
	end)

	if success then
		local data = HttpService:JSONDecode(response)
		Version.LatestVersion = data.version
		print(data.version)
		
	if Version.Version ~= data.version then
		warn("[Luabu] Luabu is outdated")
	end
	end
end)

return Version
