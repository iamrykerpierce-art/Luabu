local Enums = {}

local Types = {
	"Bool",
	"String",
	"Vector3",
	"Vector2",
	"Color3",
	"NumberSequence",
	"NumberRange",
	"Region3",
}

function Enums.StringToEnum(str: string)
	for _, v in ipairs(Types) do
		if str:lower() == v:lower() then
			return v
		end
	end

	warn("[Enums] Invalid Enum Type: " .. tostring(str))
	return nil
end

return Enums
