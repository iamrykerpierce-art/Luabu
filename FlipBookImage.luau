local FlipBookImage = {}

local Luabu = require(game.ReplicatedStorage.Luabu)

local Player = game.Players.LocalPlayer
local FlipBookUI = Player.PlayerGui:WaitForChild("FlipBook")

function FlipBookImage.Create(Name, ImgIdsList)
	assert(typeof(ImgIdsList) == "table", "ImgIdsList must be a table")

	-- Store flipbook data
	Luabu.CreateTable(Name, {
		Images = ImgIdsList
	})
	
	

	local Frames = {}

	for Index, ImageId in ipairs(ImgIdsList) do
		local ImageLabel = Instance.new("ImageLabel")

		ImageLabel.Name = "Frame_" .. Index
		ImageLabel.Size = UDim2.new(1, 0, 1, 0)
		ImageLabel.BackgroundTransparency = 1
		ImageLabel.Image = ImageId

		ImageLabel.Visible = Index == 1

		ImageLabel.Parent = FlipBookUI

		table.insert(Frames, ImageLabel)
	end

	return Frames
end

return FlipBookImage
