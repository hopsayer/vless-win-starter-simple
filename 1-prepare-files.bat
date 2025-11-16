@echo off
setlocal

set SINGBOX_VERSION=1.9.7
set SINGBOX_ZIP=sing-box-%SINGBOX_VERSION%-windows-amd64.zip
set SINGBOX_URL=https://github.com/SagerNet/sing-box/releases/download/v%SINGBOX_VERSION%/%SINGBOX_ZIP%

echo ========================================
echo  sing-box Setup
echo ========================================
echo.

rem Check if sing-box.exe already exists
if exist "sing-box.exe" (
    echo sing-box.exe already exists
    echo Setup complete!
    echo.
    echo You can now run start-proxy.bat
    pause
    exit /b 0
)

rem Check if zip exists
if not exist "%SINGBOX_ZIP%" (
    echo Downloading sing-box %SINGBOX_VERSION%...
    echo URL: %SINGBOX_URL%
    echo.
    curl -L -o "%SINGBOX_ZIP%" "%SINGBOX_URL%"
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to download sing-box!
        echo Please check your internet connection.
        pause
        exit /b 1
    )
    echo.
    echo Download complete
) else (
    echo Found existing %SINGBOX_ZIP%
)

rem Extract zip
echo.
echo Extracting sing-box...
tar -xf "%SINGBOX_ZIP%"
if errorlevel 1 (
    echo.
    echo ERROR: Failed to extract sing-box!
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Setup complete!
echo ========================================
echo.
echo Next steps:
echo 1. Edit client.json with your server details
echo 2. Run start-proxy.bat
echo.
pause

endlocal
exit
