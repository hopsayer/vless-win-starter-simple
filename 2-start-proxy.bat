@echo off
setlocal

rem Check if sing-box.exe exists
if not exist "sing-box.exe" (
    echo ERROR: sing-box.exe not found!
    echo Please run prepare-files.bat first.
    pause
    exit /b 1
)

rem Check if client.json exists
if not exist "client.json" (
    echo ERROR: client.json not found!
    echo Please create client.json with your server details.
    echo You can use client.json.example as template.
    pause
    exit /b 1
)

rem Start sing-box VLESS client
echo Starting sing-box...
start "" /b sing-box.exe run -c client.json

rem Small delay to let sing-box start
timeout /t 2 /nobreak >nul

rem Enable system proxy 127.0.0.1:1080
echo Enabling system proxy...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "127.0.0.1:1080" /f >nul

echo.
echo ========================================
echo  Proxy enabled on 127.0.0.1:1080
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
