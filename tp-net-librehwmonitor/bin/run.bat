@echo off
cd /d "%~dp0"

reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release >nul 2>&1
if %errorlevel% neq 0 goto install_net
for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Release') do set RELEASE=%%a
if %RELEASE% geq 394802 goto run

:install_net
echo .NET Framework 4.6.2 not found. Installing...
call "%~dp0bin\install-net462.bat"

:run
powershell -NoProfile -Command ^
  "$p1 = Start-Process '%~dp0libre_sensor_module\libre_sensor.exe' -NoNewWindow -PassThru; " ^
  "$p2 = Start-Process '%~dp0wmi_hardware_module\wmi_hardware.exe' -NoNewWindow -PassThru; " ^
  "Wait-Process -Id $p1.Id,$p2.Id"
