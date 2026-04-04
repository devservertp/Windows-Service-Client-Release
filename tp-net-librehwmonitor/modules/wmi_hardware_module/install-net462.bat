@echo off
chcp 65001 >nul

:: Check .NET 4.6.2 in registry
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release >nul 2>&1
if errorlevel 1 goto install

for /f "tokens=3" %%v in ('reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release 2^>nul ^| find "Release"') do set RELEASE=%%v

:: 394802 = .NET 4.6.2
if %RELEASE% GEQ 394802 (
    echo .NET 4.6.2 or later is already installed.
    goto end
)

:install
echo Installing .NET Framework 4.6.2...
set INSTALLER=%TEMP%\ndp462-kb3151800-x86-x64-allos-enu.exe
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://go.microsoft.com/fwlink/?LinkId=780596' -OutFile '%INSTALLER%'"
if errorlevel 1 (
    echo Download failed. Please install .NET 4.6.2 manually.
    pause
    exit /b 1
)
start /wait %INSTALLER% /quiet /norestart
echo Done.

:end
pause
