@echo off
chcp 65001 >nul
echo Stopping libre_sensor...

taskkill /f /im libre_sensor.exe >nul 2>&1
sc stop libre_sensor >nul 2>&1
sc delete libre_sensor >nul 2>&1
timeout /t 2 /nobreak >nul

for %%f in ("%~dp0*.sys") do del /f /q "%%f" >nul 2>&1

echo Done.
pause
