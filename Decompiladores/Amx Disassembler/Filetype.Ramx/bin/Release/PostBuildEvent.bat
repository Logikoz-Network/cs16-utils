@echo off
if not exist "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\\filetypes" mkdir "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\\filetypes"
copy "Filetype.Ramx.*" "D:\Programming\csharp\AmxDisassembler\\Windows GUI\bin\Release\\filetypes"
if errorlevel 1 goto CSharpReportError
goto CSharpEnd
:CSharpReportError
echo Project error: A tool returned an error code from the build event
exit 1
:CSharpEnd