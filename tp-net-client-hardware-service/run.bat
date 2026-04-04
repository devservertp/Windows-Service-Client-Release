@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo [1] Killing by port 1886...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":1886 " ^| findstr "LISTENING"') do (
    taskkill /PID %%a /F /T >nul 2>&1
)
echo [2] Killing by name...
taskkill /IM "Windows Service Wrapper.exe" /F /T >nul 2>&1

echo [3] Waiting 5 seconds...
timeout /t 5 /nobreak >nul

echo [4] Starting service...
call "launch\Windows Service Wrapper.exe"

echo Done.