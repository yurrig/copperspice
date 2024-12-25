setlocal EnableExtensions

call %~dp0..\vc_setup.cmd

set BUILD=build

title Configuring CopperSpice
%CMAKE% -S . -B %BUILD%

title Building CopperSpice Debug
msbuild /m %BUILD%\copperspice.sln -p:Configuration="Debug"

title Building CopperSpice Release
msbuild /m %BUILD%\copperspice.sln -p:Configuration="RelWithDebInfo"

title Done building CopperSpice

PdbIndexer %DEPS_SOURCE_URL%/copperspice
NuGet.exe pack CopperSpice.Core.nuspec -OutputDirectory %PACKAGES%\nuget_packages
NuGet.exe pack CopperSpice.Gui.Dbg.nuspec -OutputDirectory %PACKAGES%\nuget_packages
NuGet.exe pack CopperSpice.Gui.Rel.nuspec -OutputDirectory %PACKAGES%\nuget_packages
NuGet.exe pack CopperSpice.Gui.nuspec -OutputDirectory %PACKAGES%\nuget_packages

endlocal
