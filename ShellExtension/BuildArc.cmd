pushd "%~dp0"

setlocal
set PATH="%ProgramFiles%\7-zip";"%ProgramFiles(x86)%\7-zip";%PATH%
set DISTDIR=..\Build\Releases

mkdir ..\Build\ShellExtension 2> NUL
mkdir ..\Build\ShellExtension\x64 2> NUL
mkdir ..\Build\ShellExtension\ARM 2> NUL
mkdir ..\Build\ShellExtension\ARM64 2> NUL

copy /y "..\Build\Release\ShellExtensionU.dll" ..\Build\ShellExtension\
copy /y "..\Build\x64\Release\ShellExtensionX64.dll" ..\Build\ShellExtension\
copy /y "..\Build\x64\Release\WinMergeContextMenu.dll" ..\Build\ShellExtension\x64
copy /y "..\Build\ARM\Release\ShellExtensionARM.dll" ..\Build\ShellExtension\
copy /y "..\Build\ARM64\Release\ShellExtensionARM64.dll" ..\Build\ShellExtension\
copy /y "..\Build\ARM64\Release\WinMergeContextMenu.dll" ..\Build\ShellExtension\ARM64
copy /y "..\Build\x64\Release\WinMergeContextMenuPackage.msix" ..\Build\ShellExtension\

WMIC Path CIM_DataFile WHERE Name='%CD:\=\\%\\..\\Build\\ShellExtension\\ShellExtensionX64.dll' Get Version | findstr /v Version > _tmp_.txt
set /P DLLVERSIONTMP=<_tmp_.txt
set DLLVERSION=%DLLVERSIONTMP: =%
del _tmp_.txt

7z.exe a -tzip "%DISTDIR%\ShellExtension-%DLLVERSION%.zip" ..\Build\ShellExtension

popd
goto :eof

