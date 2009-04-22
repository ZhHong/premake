--
-- gcc.lua
-- Provides GCC-specific configuration strings.
-- Copyright (c) 2002-2008 Jason Perkins and the Premake project
--

	
	premake.gcc = { }
	premake.targetstyle = "linux"
	

--
-- Translation of Premake flags into GCC flags
--

	local cflags =
	{
		ExtraWarnings  = "-Wall",
		FatalWarnings  = "-Werror",
		NoFramePointer = "-fomit-frame-pointer",
		Optimize       = "-O2",
		OptimizeSize   = "-Os",
		OptimizeSpeed  = "-O3",
		Symbols        = "-g",
	}

	local cxxflags =
	{
		NoExceptions   = "-fno-exceptions",
		NoRTTI         = "-fno-rtti",
	}
	
	
--
-- Support platforms, mapped to build configuration suffix
--

	premake.gcc.platforms = 
	{
		Native = { 
			suffix   = "",
			cppflags = "-MMD", 
			flags    = "" ,
			ldflags  = "",
		},
		x32 = { 
			suffix   = "32",
			cppflags = "-MMD", 
			flags    = "-m32",
			ldflags  = "-L/usr/lib32", 
		},
		x64 = { 
			suffix   = "64",
			cppflags = "-MMD",
			flags    = "-m64",
			ldflags  = "-L/usr/lib64",
		},
		Universal = { 
			suffix   = "univ",
			cppflags = "",
			flags    = "-arch i386 -arch x86_64 -arch ppc -arch ppc64",
			ldflags  = "",
		},
		Universal32 = { 
			suffix   = "univ32",
			cppflags = "",
			flags    = "-arch i386 -arch ppc",
			ldflags  = "",
		},
		Universal64 = { 
			suffix   = "univ64",
			cppflags = "",
			flags    = "-arch x86_64 -arch ppc64",
			ldflags  = "",
		},
	}



--
-- Returns a list of compiler flags, based on the supplied configuration.
--

	function premake.gcc.getcppflags(cfg)
		return premake.gcc.platforms[cfg.platform].cppflags
	end

	function premake.gcc.getcflags(cfg)
		local result = table.translate(cfg.flags, cflags)
		if (cfg.kind == "SharedLib" and not os.is("windows")) then
			table.insert(result, "-fPIC")
		end
		if cfg.platform then
			table.insert(result, premake.gcc.platforms[cfg.platform].flags)
		end
		return result		
	end
	
	function premake.gcc.getcxxflags(cfg)
		local result = table.translate(cfg.flags, cxxflags)
		return result
	end
	


--
-- Returns a list of linker flags, based on the supplied configuration.
--

	function premake.gcc.getldflags(cfg)
		local result = { }
		
		if (cfg.kind == "SharedLib") then
			if os.is("macosx") then
				result = table.join(result, { "-dynamiclib", "-flat_namespace" })
			else
				table.insert(result, "-shared")
			end
			
			-- create import library for DLLs under Windows
			if (os.is("windows") and not cfg.flags.NoImportLib) then
				table.insert(result, '-Wl,--out-implib="'..premake.gettarget(cfg, "link", "linux").fullpath..'"')
			end
		end

		if (os.is("windows") and cfg.kind == "WindowedApp") then
			table.insert(result, "-mwindows")
		end
		
		-- OS X has a bug, see http://lists.apple.com/archives/Darwin-dev/2006/Sep/msg00084.html
		if (not cfg.flags.Symbols) then
			if (os.is("macosx")) then
				table.insert(result, "-Wl,-x")
			else
				table.insert(result, "-s")
			end
		end
	
		if cfg.platform then
			table.insert(result, premake.gcc.platforms[cfg.platform].flags)
			table.insert(result, premake.gcc.platforms[cfg.platform].ldflags)
		end
		
		return result
	end
		
	
--
-- Returns a list of linker flags for library search directories and library
-- names. See bug #1729227 for background on why the path must be split.
--

	function premake.gcc.getlinkflags(cfg)
		local result = { }
		for _, value in ipairs(premake.getlinks(cfg, "all", "directory")) do
			table.insert(result, '-L' .. _MAKE.esc(value))
		end
		for _, value in ipairs(premake.getlinks(cfg, "all", "basename")) do
			table.insert(result, '-l' .. _MAKE.esc(value))
		end
		return result
	end
	
	

--
-- Decorate defines for the GCC command line.
--

	function premake.gcc.getdefines(defines)
		local result = { }
		for _,def in ipairs(defines) do
			table.insert(result, '-D' .. def)
		end
		return result
	end


	
--
-- Decorate include file search paths for the GCC command line.
--

	function premake.gcc.getincludedirs(includedirs)
		local result = { }
		for _,dir in ipairs(includedirs) do
			table.insert(result, "-I" .. _MAKE.esc(dir))
		end
		return result
	end