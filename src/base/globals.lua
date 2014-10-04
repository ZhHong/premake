--
-- globals.lua
-- Replacements and extensions to Lua's global functions.
-- Copyright (c) 2002-2014 Jason Perkins and the Premake project
--


--
-- Find and execute a Lua source file present on the filesystem, but
-- continue without error if the file is not present. This is used to
-- handle optional files such as the premake-system.lua script.
--
-- @param fname
--    The name of the file to load. This may be specified as a single
--    file path or an array of file paths, in which case the first
--    file found is run.
-- @return
--    True if a file was found and executed, nil otherwise.
--

	function dofileopt(fname)
		if type(fname) == "string" then fname = {fname} end
		for i = 1, #fname do
			local found = os.locate(fname[i])
			if not found then
				found = os.locate(fname[i] .. ".lua")
			end
			if found then
				dofile(found)
				return true
			end
		end
	end



---
-- Load and run an external script file, with a bit of extra logic to make
-- including projects easier. if "path" is a directory, will look for
-- path/premake5.lua. And each file is tracked, and loaded only once.
--
-- @param fname
--    The name of the directory or file to include. If a directory, will
--    automatically include the contained premake5.lua or premake4.lua
--    script at that lcoation.
---

	io._includedFiles = {}

	function include(fname)
		local fullPath = os.locate(fname, fname .. ".lua", path.join(fname, "premake5.lua"), path.join(fname, "premake4.lua"))
		fname = fullPath or fname
		if not io._includedFiles[fname] then
			io._includedFiles[fname] = true
			dofile(fname)
		end
	end
