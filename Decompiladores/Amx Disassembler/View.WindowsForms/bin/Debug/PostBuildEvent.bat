@echo off
if not exist "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Debug\\viewtypes" mkdir "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Debug\\viewtypes"
copy "View.WindowsForms.*" "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Debug\\viewtypes"
if errorlevel 1 goto CSharpReportError
goto CSharpEnd
:CSharpReportError
echo Project error: A tool returned an error code from the build event
exit 1
:CSharpEnd