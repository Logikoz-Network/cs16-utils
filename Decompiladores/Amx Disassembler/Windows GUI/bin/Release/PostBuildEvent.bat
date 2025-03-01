@echo off
if exist "D:\Programming\csharp\AmxDisassembler\\Amx\opcodes.txt" copy "D:\Programming\csharp\AmxDisassembler\\Amx\opcodes.txt" "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\"
if errorlevel 1 goto CSharpReportError
goto CSharpEnd
:CSharpReportError
echo Project error: A tool returned an error code from the build event
exit 1
:CSharpEnd