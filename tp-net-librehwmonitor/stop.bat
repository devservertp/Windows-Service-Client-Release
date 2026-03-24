@echo off
setlocal enabledelayedexpansion
set BASE=%~dp0

:: ── Kill by PID files ──────────────────────────────────────────
for %%f in ("%BASE%\wmi_hardware.pid" "%BASE%\libre_sensor.pid") do (
    if exist "%%f" (
        set /p PID=<"%%f"
        if defined PID (
            echo Killing PID !PID! from %%~nxf
            taskkill /pid !PID! /f >nul 2>&1
            del /f /q "%%f" >nul 2>&1
            set PID=
        )
    )
)

:: ── Kill all remaining processes whose executable is under BASE ─
for /f "skip=1 tokens=2 delims=," %%p in ('wmic process where "ExecutablePath like '%%tp-net-librehwmonitor%%'" get ProcessId /format:csv 2^>nul') do (
    set PID=%%p
    set PID=!PID: =!
    if defined PID (
        echo Killing leftover PID !PID!
        taskkill /pid !PID! /f >nul 2>&1
    )
)

echo Done.
exit /b 0
