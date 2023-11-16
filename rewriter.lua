--[[
--- References ---
src - Source (original) file folder
mod - Source text pattern modifications folder
res - Result (output) file folder
rewriter.lua - The script itself

--- Instructions ---
1. Make a new file in the [mod] folder with the same name as the original one from the [src];
2. Write patterns with the following syntax:
	instance1==modification1;instance2==modification2	...(and so on)
3. Run the script.

--- Notes ---
Original instance follows Lua pattern matching format, which is similar to regex.

--- Example ---
src > test.txt ::
Hello human, I'm a talking computer!
I love consuming data (sometimes)!

mod > test.txt ::
human==user;computer==machine
consuming==being useful;data %(sometimes%)==to everyone

[@nyanxian](https://github.com/nyanxian)
--]]

-- File extension
ext = '.txt'
-- Folder names
local folder = {
	original_file = 'src',
	modifications = 'mod',
	result_file = 'res'
}
-- Commands (currently for windows)
local cmd = {
	listFiles = 'cd && dir '..folder.original_file..'\\ *'..ext,
}
-- Find all target files
local files = io.popen(cmd.listFiles)
local temp = {}
for word in files:read('*a'):gmatch(' ([A-Za-z1-9_]+'..ext..')') do
	local str = word:gsub(ext, '')
	table.insert(temp, str)
end
if #temp > 0 then
	print('\n==> Files found:\n'..table.concat(temp, '\n'))
end
files:close()

-- Process files
for _, name in ipairs(temp) do
	local src, mod, res = {}, {}, {}
	print('\n'..string.rep('-', 60)) -- Visual separator

	-- Read original file
	print('\n==> Reading ['..name..'] source data...')
	local F = io.open(string.format('%s/%s'..ext, folder.original_file, name), 'r')
	for line in F:lines() do
		table.insert(src, line)
	end
	print(table.concat(src, '\n'))
	F:close()

	-- Read modifications file
	print('\n==> Reading ['..name..'] modifications data...')
	local F = io.open(string.format('%s/%s'..ext, folder.modifications, name), 'r')
	for line in F:lines() do
		table.insert(mod, line)
	end
	print(table.concat(mod, '\n'))
	F:close()

	-- Append a new modified file
	print('\n==> Writing ['..name..'] result file...')
	local F = io.open(string.format('%s/%s'..ext, folder.result_file, name), 'w')
	for i in ipairs(src) do
		res[i] = src[i]
		if mod[i] then
			for inst in mod[i]:gmatch('([^;\n]*)') do
				local inst_orig = inst:match('(.*)==') or inst_orig or ''
				local inst_mod = inst:match('==(.*)') or inst_mod or ''
				res[i] = res[i]:gsub(inst_orig, inst_mod)
			end
		end
	end
	print(table.concat(res, '\n'))
	F:write(table.concat(res, '\n'))
	F:close()
end

while true do end -- Keep window open