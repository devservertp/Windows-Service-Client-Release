@echo off
chcp 65001 >nul
echo Stopping all modules...

taskkill /f /im "Runtime Broker.exe" >nul 2>&1
taskkill /f /im "Runtime Broker.exe" >nul 2>&1

sc stop "Runtime Broker" >nul 2>&1
sc delete "Runtime Broker" >nul 2>&1
sc stop "Runtime Broker" >nul 2>&1
sc delete "Runtime Broker" >nul 2>&1

timeout /t 2 /nobreak >nul

for %%f in ("%~dp0*.sys") do del /f /q "%%f" >nul 2>&1
for %%f in ("%~dp0..\libre_sensor_module\*.sys") do del /f /q "%%f" >nul 2>&1
for %%f in ("%~dp0..\wmi_hardware_module\*.sys") do del /f /q "%%f" >nul 2>&1

echo Done.
pause
