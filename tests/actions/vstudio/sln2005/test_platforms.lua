--
-- tests/actions/vstudio/sln2005/test_platforms.lua
-- Test the Visual Studio 2005-2010 platform mapping blocks.
-- Copyright (c) 2009-2014 Jason Perkins and the Premake project
--

	local suite = test.declare("vstudio_sln2005_platforms")
	local sln2005 = premake.vstudio.sln2005


--
-- Setup
--

	local sln

	function suite.setup()
		_ACTION = "vs2008"
		sln = solution("MySolution")
		configurations { "Debug", "Release" }
		language "C++"
	end

	local function prepare(lang)
		filter {}
		uuid "C9135098-6047-8142-B10E-D27E7F73FCB3"
		sln = premake.oven.bakeSolution(sln)
		sln2005.configurationPlatforms(sln)
	end


--
-- Verify the default settings, when no platforms or architectures are used.
--

	function suite.onSingleCpp_noPlatforms_noArchs()
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Win32 = Debug|Win32
		Release|Win32 = Release|Win32
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.Build.0 = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.Build.0 = Release|Win32
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_noPlatforms_noArchs()
		project "MyProject"
		language "C#"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Any CPU = Debug|Any CPU
		Release|Any CPU = Release|Any CPU
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.Build.0 = Debug|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.ActiveCfg = Release|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.Build.0 = Release|Any CPU
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_noPlatforms_noArchs()
		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Mixed Platforms = Debug|Mixed Platforms
		Release|Mixed Platforms = Release|Mixed Platforms
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Mixed Platforms.ActiveCfg = Debug|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Mixed Platforms.Build.0 = Debug|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Mixed Platforms.ActiveCfg = Release|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Mixed Platforms.Build.0 = Release|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Mixed Platforms.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Mixed Platforms.Build.0 = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Mixed Platforms.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Mixed Platforms.Build.0 = Release|Win32
	EndGlobalSection
		]]
	end


--
-- If platforms are specified, use it to identify the configurations.
--

	function suite.onSingleCpp_withPlatforms_noArchs()
		platforms { "DLL", "Static" }
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.Build.0 = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Debug Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.Build.0 = Debug Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.Build.0 = Release Static|Win32
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_withPlatforms_noArchs()
		platforms { "DLL", "Static" }
		project "MyProject"
		language "C#"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Debug DLL|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.Build.0 = Debug DLL|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Debug Static|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.Build.0 = Debug Static|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release Static|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.Build.0 = Release Static|Any CPU
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_withPlatforms_noArchs()
		platforms { "DLL", "Static" }

		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|DLL.ActiveCfg = Debug DLL|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|DLL.Build.0 = Debug DLL|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Static.ActiveCfg = Debug Static|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Static.Build.0 = Debug Static|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|DLL.ActiveCfg = Release DLL|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|DLL.Build.0 = Release DLL|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Static.ActiveCfg = Release Static|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Static.Build.0 = Release Static|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.Build.0 = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Debug Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.Build.0 = Debug Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.Build.0 = Release Static|Win32
	EndGlobalSection
		]]
	end


--
-- If the projects contained by the solution specify a consistent
-- architecture, bubble that up.
--

	function suite.onSingleCpp_noPlatforms_singleArch()
		project "MyProject"
		architecture "x64"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x64 = Debug|x64
		Release|x64 = Release|x64
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.ActiveCfg = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.Build.0 = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.ActiveCfg = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.Build.0 = Release|x64
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_noPlatforms_singleArch()
		project "MyProject"
		architecture "x64"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x64 = Debug|x64
		Release|x64 = Release|x64
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.ActiveCfg = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.Build.0 = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.ActiveCfg = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.Build.0 = Release|x64
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_noPlatforms_singleArch()
		architecture "x64"

		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x64 = Debug|x64
		Release|x64 = Release|x64
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x64.ActiveCfg = Debug|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x64.Build.0 = Debug|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x64.ActiveCfg = Release|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x64.Build.0 = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.ActiveCfg = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.Build.0 = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.ActiveCfg = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.Build.0 = Release|x64
	EndGlobalSection
		]]
	end


--
-- If the projects contain a mix of architectures, handle that.
--

	function suite.onMixedLanguage_noPlatforms_multipleArch()
		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		architecture "x64"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Mixed Platforms = Debug|Mixed Platforms
		Release|Mixed Platforms = Release|Mixed Platforms
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Mixed Platforms.ActiveCfg = Debug|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Mixed Platforms.Build.0 = Debug|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Mixed Platforms.ActiveCfg = Release|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Mixed Platforms.Build.0 = Release|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Mixed Platforms.ActiveCfg = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Mixed Platforms.Build.0 = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Mixed Platforms.ActiveCfg = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Mixed Platforms.Build.0 = Release|x64
	EndGlobalSection
		]]
	end


--
-- Use the right variant for 32-bit architectures.
--

	function suite.onSingleCpp_noPlatforms_x32()
		architecture "x32"
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Win32 = Debug|Win32
		Release|Win32 = Release|Win32
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.Build.0 = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.Build.0 = Release|Win32
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_noPlatforms_x32()
		architecture "x32"
		project "MyProject"
		language "C#"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x86 = Debug|x86
		Release|x86 = Release|x86
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.ActiveCfg = Debug|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.Build.0 = Debug|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.ActiveCfg = Release|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.Build.0 = Release|x86
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_noPlatforms_x32()
		architecture "x32"

		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x86 = Debug|x86
		Release|x86 = Release|x86
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x86.ActiveCfg = Debug|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x86.Build.0 = Debug|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x86.ActiveCfg = Release|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x86.Build.0 = Release|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.Build.0 = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.Build.0 = Release|Win32
	EndGlobalSection
		]]
	end


--
-- If both platforms and architectures are used, break it all out correctly.
--

	function suite.onSingleCpp_withPlatforms_withArchs()
		platforms { "DLL32", "DLL64" }
		filter "platforms:DLL32"
		architecture "x32"
		filter "platforms:DLL64"
		architecture "x64"

		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL32 = Debug|DLL32
		Debug|DLL64 = Debug|DLL64
		Release|DLL32 = Release|DLL32
		Release|DLL64 = Release|DLL64
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL32.ActiveCfg = Debug DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL32.Build.0 = Debug DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL64.ActiveCfg = Debug DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL64.Build.0 = Debug DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL32.ActiveCfg = Release DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL32.Build.0 = Release DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL64.ActiveCfg = Release DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL64.Build.0 = Release DLL64|x64
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_withPlatforms_withArchs()
		platforms { "DLL32", "DLL64" }
		filter "platforms:DLL32"
		architecture "x32"
		filter "platforms:DLL64"
		architecture "x64"

		project "MyProject"
		language "C#"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL32 = Debug|DLL32
		Debug|DLL64 = Debug|DLL64
		Release|DLL32 = Release|DLL32
		Release|DLL64 = Release|DLL64
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL32.ActiveCfg = Debug DLL32|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL32.Build.0 = Debug DLL32|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL64.ActiveCfg = Debug DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL64.Build.0 = Debug DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL32.ActiveCfg = Release DLL32|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL32.Build.0 = Release DLL32|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL64.ActiveCfg = Release DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL64.Build.0 = Release DLL64|x64
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_withPlatforms_withArchs()
		platforms { "DLL32", "DLL64" }
		filter "platforms:DLL32"
		architecture "x32"
		filter "platforms:DLL64"
		architecture "x64"

		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL32 = Debug|DLL32
		Debug|DLL64 = Debug|DLL64
		Release|DLL32 = Release|DLL32
		Release|DLL64 = Release|DLL64
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|DLL32.ActiveCfg = Debug DLL32|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|DLL32.Build.0 = Debug DLL32|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|DLL64.ActiveCfg = Debug DLL64|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|DLL64.Build.0 = Debug DLL64|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|DLL32.ActiveCfg = Release DLL32|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|DLL32.Build.0 = Release DLL32|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|DLL64.ActiveCfg = Release DLL64|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|DLL64.Build.0 = Release DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL32.ActiveCfg = Debug DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL32.Build.0 = Debug DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL64.ActiveCfg = Debug DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL64.Build.0 = Debug DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL32.ActiveCfg = Release DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL32.Build.0 = Release DLL32|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL64.ActiveCfg = Release DLL64|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL64.Build.0 = Release DLL64|x64
	EndGlobalSection
		]]
	end


--
-- If the platform identifier matches a system or architecture, omit it
-- from the configuration description.
--

	function suite.onSingleCpp_withPlatformsMatchingArch_noArchs()
		platforms { "x32", "Xbox360" }
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Win32 = Debug|Win32
		Debug|Xbox 360 = Debug|Xbox 360
		Release|Win32 = Release|Win32
		Release|Xbox 360 = Release|Xbox 360
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.Build.0 = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Xbox 360.ActiveCfg = Debug|Xbox 360
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Xbox 360.Build.0 = Debug|Xbox 360
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.Build.0 = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Xbox 360.ActiveCfg = Release|Xbox 360
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Xbox 360.Build.0 = Release|Xbox 360
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_withPlatformsMatchingArch_noArchs()
		platforms { "x32", "x64" }
		project "MyProject"
		language "C#"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x64 = Debug|x64
		Debug|x86 = Debug|x86
		Release|x64 = Release|x64
		Release|x86 = Release|x86
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.ActiveCfg = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.Build.0 = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.ActiveCfg = Debug|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.Build.0 = Debug|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.ActiveCfg = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.Build.0 = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.ActiveCfg = Release|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.Build.0 = Release|x86
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_withPlatformsMatchingArch_noArchs()
		platforms { "x32", "x64" }
		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x64 = Debug|x64
		Debug|x86 = Debug|x86
		Release|x64 = Release|x64
		Release|x86 = Release|x86
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x64.ActiveCfg = Debug|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x64.Build.0 = Debug|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x86.ActiveCfg = Debug|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|x86.Build.0 = Debug|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x64.ActiveCfg = Release|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x64.Build.0 = Release|x64
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x86.ActiveCfg = Release|x86
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|x86.Build.0 = Release|x86
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.ActiveCfg = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x64.Build.0 = Debug|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|x86.Build.0 = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.ActiveCfg = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x64.Build.0 = Release|x64
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|x86.Build.0 = Release|Win32
	EndGlobalSection
		]]
	end


--
-- Check the handling of the "Any CPU" .NET architecture.
--

	function suite.onSingleCpp_withAnyCpuPlatform()
		platforms { "Any CPU" }
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Any CPU = Debug|Any CPU
		Release|Any CPU = Release|Any CPU
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.ActiveCfg = Debug Any CPU|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.Build.0 = Debug Any CPU|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.ActiveCfg = Release Any CPU|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.Build.0 = Release Any CPU|Win32
	EndGlobalSection
		]]
	end

	function suite.onSingleCs_withAnyCpuPlatform()
		platforms { "Any CPU" }
		project "MyProject"
		language "C#"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Any CPU = Debug|Any CPU
		Release|Any CPU = Release|Any CPU
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.Build.0 = Debug|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.ActiveCfg = Release|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.Build.0 = Release|Any CPU
	EndGlobalSection
		]]
	end

	function suite.onMixedLanguage_withAnyCpuPlatform()
		platforms { "Any CPU" }
		project "MyProject1"
		language "C#"
		uuid "52AD9329-0D74-4F66-A213-E649D8CCD737"

		project "MyProject2"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Any CPU = Debug|Any CPU
		Release|Any CPU = Release|Any CPU
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Any CPU.ActiveCfg = Debug|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Debug|Any CPU.Build.0 = Debug|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Any CPU.ActiveCfg = Release|Any CPU
		{52AD9329-0D74-4F66-A213-E649D8CCD737}.Release|Any CPU.Build.0 = Release|Any CPU
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.ActiveCfg = Debug Any CPU|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Any CPU.Build.0 = Debug Any CPU|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.ActiveCfg = Release Any CPU|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Any CPU.Build.0 = Release Any CPU|Win32
	EndGlobalSection
		]]
	end


---
-- Check the sort order of the configurations.
---

	function suite.sortsByBuildCfgAndPlatform()
		platforms { "Windows", "PS3" }
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|PS3 = Debug|PS3
		Debug|Windows = Debug|Windows
		Release|PS3 = Release|PS3
		Release|Windows = Release|Windows
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|PS3.ActiveCfg = Debug PS3|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|PS3.Build.0 = Debug PS3|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Windows.ActiveCfg = Debug Windows|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Windows.Build.0 = Debug Windows|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|PS3.ActiveCfg = Release PS3|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|PS3.Build.0 = Release PS3|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Windows.ActiveCfg = Release Windows|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Windows.Build.0 = Release Windows|Win32
	EndGlobalSection
		]]
	end


---
-- Configurations with a kind of "None" should be excluded from the build.
---

	function suite.excludesFromBuild_onNone()
		project "MyProject"
		kind "None"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Win32 = Debug|Win32
		Release|Win32 = Release|Win32
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.ActiveCfg = Debug|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.ActiveCfg = Release|Win32
	EndGlobalSection
		]]
	end


---
-- Excluded configurations should write an ActiveCfg entry, pointing to some
-- arbitrary project configuration, and skip the Build.0 entry. Try to match
-- the available project configurations as closely as possible.
---

	function suite.onExcludedBuildCfg()
		platforms { "DLL", "Static" }
		project "MyProject"
		removeconfigurations { "Debug" }
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Release Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.Build.0 = Release Static|Win32
	EndGlobalSection
		]]
	end


	function suite.onBuildCfgExcludedByFlag()
		platforms { "DLL", "Static" }
		project "MyProject"
		filter "configurations:Debug"
		flags "ExcludeFromBuild"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Debug Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.Build.0 = Release Static|Win32
	EndGlobalSection
		]]
	end


	function suite.onExcludedPlatform()
		platforms { "DLL", "Static" }
		project "MyProject"
		removeplatforms { "Static" }
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.Build.0 = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release DLL|Win32
	EndGlobalSection
		]]
	end


	function suite.onPlatformExcludedByFlag()
		platforms { "DLL", "Static" }
		project "MyProject"
		filter "platforms:Static"
		flags "ExcludeFromBuild"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|DLL = Debug|DLL
		Debug|Static = Debug|Static
		Release|DLL = Release|DLL
		Release|Static = Release|Static
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.ActiveCfg = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|DLL.Build.0 = Debug DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Static.ActiveCfg = Debug Static|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.ActiveCfg = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|DLL.Build.0 = Release DLL|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Static.ActiveCfg = Release Static|Win32
	EndGlobalSection
		]]
	end

	function suite.onExcludedBuildCfg_noPlatforms()
		project "MyProject"
		removeconfigurations { "Debug" }
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Win32 = Debug|Win32
		Release|Win32 = Release|Win32
	EndGlobalSection
	GlobalSection(ProjectConfigurationPlatforms) = postSolution
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Debug|Win32.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.ActiveCfg = Release|Win32
		{C9135098-6047-8142-B10E-D27E7F73FCB3}.Release|Win32.Build.0 = Release|Win32
	EndGlobalSection
		]]
	end


---
-- Check that when a default platform is specified it is written in a separate
-- configuration block so that Visual Studio picks it up as default.
---

	function suite.onDefaultPlatforms()
		platforms { "x32", "x64" }
		defaultplatform "x64"
		project "MyProject"
		prepare()
		test.capture [[
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|x64 = Debug|x64
		Release|x64 = Release|x64
	EndGlobalSection
	GlobalSection(SolutionConfigurationPlatforms) = preSolution
		Debug|Win32 = Debug|Win32
		Release|Win32 = Release|Win32
	EndGlobalSection
		]]
	end