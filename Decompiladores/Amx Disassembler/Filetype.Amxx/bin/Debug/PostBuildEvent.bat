@echo off
if not exist "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Debug\\filetypes" mkdir "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Debug\\filetypes"
copy "Filetype.Amxx.*" "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Debug\\filetypes"
if errorlevel 1 goto CSharpReportError
goto CSharpEnd
:CSharpReportError
echo Project error: A tool returned an error code from the build event
exit 1
:CSharpEnd