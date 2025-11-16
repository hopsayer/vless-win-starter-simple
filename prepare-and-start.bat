@echo off
setlocal

set SINGBOX_VERSION=1.9.7
set SINGBOX_ZIP=sing-box-%SINGBOX_VERSION%-windows-amd64.zip
set SINGBOX_URL=https://github.com/SagerNet/sing-box/releases/download/v%SINGBOX_VERSION%/%SINGBOX_ZIP%

rem Check if sing-box.exe exists
if not exist "sing-box.exe" (
    echo sing-box.exe not found
    
    rem Check if zip exists
    if not exist "%SINGBOX_ZIP%" (
        echo Downloading sing-box %SINGBOX_VERSION%...
        curl -L -o "%SINGBOX_ZIP%" "%SINGBOX_URL%"
        if errorlevel 1 (
            echo ERROR: Failed to download sing-box!
            pause
            exit /b 1
        )
        echo Download complete
    )
    
    rem Extract zip
    echo Extracting sing-box...
    tar -xf "%SINGBOX_ZIP%"
    if errorlevel 1 (
        echo ERROR: Failed to extract sing-box!
        pause
        exit /b 1
    )
    echo Extraction complete
)

rem Check if client.json exists
if not exist "client.json" (
    echo ERROR: client.json not found! Please create config file.
    echo You can use client.json.example as template.
    pause
    exit /b 1
)

rem Start sing-box VLESS client
echo Starting sing-box...
start "" /b sing-box.exe run -c client.json

rem Small delay to let sing-box start
timeout /t 2 /nobreak >nul

rem Enable system proxy 127.0.0.1:1084
echo Enabling system proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "127.0.0.1:1084" /f >nul

echo.
echo ========================================
echo  Proxy enabled on 127.0.0.1:1084
echo  Press any key to stop and disable
echo ========================================
echo.

pause >nul

rem Disable system proxy
echo Disabling system proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1

rem Kill sing-box
echo Stopping sing-box...
taskkill /im sing-box.exe /f >nul 2>&1

echo Done!
timeout /t 2 /nobreak >nul

endlocal
exit
