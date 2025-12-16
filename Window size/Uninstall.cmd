@echo off
set "SCRIPT_NAME=WindowManager.ahk"
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "TARGET_FILE=%STARTUP_FOLDER%\%SCRIPT_NAME%"

echo.
echo ----- Uninstalling %SCRIPT_NAME% -----
echo.

if exist "%TARGET_FILE%" (
    del "%TARGET_FILE%"
    echo SUCCESS: Deleted "%TARGET_FILE%"
    echo.
    echo The script will no longer run automatically after the next system restart.
) else (
    echo INFO: "%TARGET_FILE%" was not found. The script appears to be already uninstalled.
)

echo.
echo Press any key to exit...
pause >nul
