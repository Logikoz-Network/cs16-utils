@echo off
if not exist "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\\viewtypes" mkdir "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\\viewtypes"
copy "View.Scasm.*" "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\\viewtypes"
if errorlevel 1 goto CSharpReportError
goto CSharpEnd
:CSharpReportError
echo Project error: A tool returned an error code from the build event
exit 1
:CSharpEnd