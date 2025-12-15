@echo off
set "SCRIPT_NAME=WindowManager.ahk"
set "STARTUP_FOLDER=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

if not exist "%SCRIPT_NAME%" (
    echo ERROR: "%SCRIPT_NAME%" not found. Cannot proceed.
    goto :EXIT_PROMPT
)

copy "%SCRIPT_NAME%" "%STARTUP_FOLDER%" /Y >nul

echo.
echo -----%SCRIPT_NAME% is installing-----
echo.
echo script installed in %STARTUP_FOLDER%\%SCRIPT_NAME%
echo.
echo press any key to exit... (restart the system manually to take effect)
pause >nul


:EXIT_PROMPT
