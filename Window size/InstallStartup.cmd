@echo off
title Startup Script Installer
setlocal EnableDelayedExpansion

:: ===== CONFIG =====
set "SCRIPT_NAME=WindowManager.ahk"
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "TARGET=%STARTUP_FOLDER%\%SCRIPT_NAME%"
:: ==================

echo ====================================
echo   WindowManager Startup Installer
echo ====================================
echo.

:: --- Check script file ---
if not exist "%SCRIPT_NAME%" (
    echo [ERROR] Script "%SCRIPT_NAME%" not found!
    echo Place this .cmd file next to the script.
    goto EXIT
)

:: --- Check if already installed ---
if exist "%TARGET%" (
    echo [INFO] Script is already installed in Startup.
    echo Location: %TARGET%
    goto EXIT
)

:: --- Check AutoHotkey ---
where autohotkey >nul 2>&1
if errorlevel 1 (
    echo [WARNING] AutoHotkey is NOT installed!
    echo The script will not run on startup without it.
    echo.
)

:: --- Install ---
echo Installing script...
copy "%SCRIPT_NAME%" "%STARTUP_FOLDER%" /Y >nul

if errorlevel 1 (
    echo [ERROR] Failed to copy file.
    goto EXIT
)

echo [SUCCESS] Installed successfully!
echo Startup path:
echo %TARGET%
echo.

:EXIT
echo Press any key to exit...
pause >nul
endlocal