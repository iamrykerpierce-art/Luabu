local TableManager = {}

local Tables = {}

-- Create a new table
function TableManager.Create(name:string, defaultData)
	if Tables[name] then
		warn(`Table "{name}" already exists`)
		return Tables[name]
	end

	Tables[name] = defaultData or {}

	return Tables[name]
end

-- Get a table
function TableManager.Get(name)
	return Tables[name]
end

-- Set/replace a table
function TableManager.Set(name, newTable)
	Tables[name] = newTable
end

-- Update values inside a table
function TableManager.Update(name, key, value)
	local tbl = Tables[name]

	if not tbl then
		warn(`Table "{name}" does not exist`)
		return
	end

	tbl[key] = value
end

-- Remove a table
function TableManager.Remove(name)
	Tables[name] = nil
end

-- Check if table exists
function TableManager.Exists(name)
	return Tables[name] ~= nil
end

-- Clear everything
function TableManager.Clear()
	table.clear(Tables)
end

return TableManager
