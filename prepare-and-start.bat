@echo off
setlocal

set SINGBOX_VERSION=1.9.7
set SINGBOX_ZIP=sing-box-%SINGBOX_VERSION%-windows-amd64-legacy.zip
set SINGBOX_URL=https://github.com/SagerNet/sing-box/releases/download/v%SINGBOX_VERSION%/%SINGBOX_ZIP%

rem Check if sing-box.exe exists
if not exist "sing-box.exe" (
    echo sing-box.exe not found
    
    echo Downloading sing-box %SINGBOX_VERSION%...
    curl -L -o "%SINGBOX_ZIP%" "%SINGBOX_URL%"
    if errorlevel 1 (
        echo ERROR: Failed to download sing-box!
        pause
        exit /b 1
    )
    echo Download complete
    
    rem Extract zip
    echo Extracting sing-box...
    tar -xf "%SINGBOX_ZIP%"
    if errorlevel 1 (
        echo ERROR: Failed to extract sing-box!
        pause
        exit /b 1
    )
    
    rem Move sing-box.exe from subfolder to current directory
    move "sing-box-%SINGBOX_VERSION%-windows-amd64-legacy\sing-box.exe" "sing-box.exe" >nul
    
    rem Clean up
    rmdir /s /q "sing-box-%SINGBOX_VERSION%-windows-amd64-legacy"
    del "%SINGBOX_ZIP%"
    
    echo Extraction complete
)

rem Check if config.json exists
if not exist "config.json" (
    echo ERROR: config.json not found! Please create config file.
    echo You can use config-filled-fake.json as template.
    pause
    exit /b 1
)

rem Start sing-box VLESS client
echo Starting sing-box...
start "" /b sing-box.exe run -c config.json

rem Check if sing-box started successfully
timeout /t 1 /nobreak >nul
tasklist /FI "IMAGENAME eq sing-box.exe" 2>NUL | find /I /N "sing-box.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [OK] sing-box is running
) else (
    echo [ERROR] sing-box failed to start! Check config.json
    pause
    exit /b 1
)

rem Enable system proxy using PowerShell for proper refresh
echo Enabling system proxy...
powershell -ExecutionPolicy Bypass -Command "$regPath='HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'; Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 1; Set-ItemProperty -Path $regPath -Name ProxyServer -Value '127.0.0.1:1084'; Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"wininet.dll\")]public static extern bool InternetSetOption(IntPtr h,int o,IntPtr b,int l);public static void R(){InternetSetOption(IntPtr.Zero,39,IntPtr.Zero,0);InternetSetOption(IntPtr.Zero,37,IntPtr.Zero,0);}}'; [W]::R()"

echo.
echo ========================================
echo  Proxy enabled on 127.0.0.1:1084
echo  Press any key to stop and disable
echo ========================================
echo.

pause >nul

rem Disable system proxy using PowerShell
echo Disabling system proxy...
powershell -ExecutionPolicy Bypass -Command "$regPath='HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings'; Set-ItemProperty -Path $regPath -Name ProxyEnable -Value 0; Remove-ItemProperty -Path $regPath -Name ProxyServer -ErrorAction SilentlyContinue; Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class W{[DllImport(\"wininet.dll\")]public static extern bool InternetSetOption(IntPtr h,int o,IntPtr b,int l);public static void R(){InternetSetOption(IntPtr.Zero,39,IntPtr.Zero,0);InternetSetOption(IntPtr.Zero,37,IntPtr.Zero,0);}}'; [W]::R()"

rem Kill sing-box
echo Stopping sing-box...
taskkill /im sing-box.exe /f >nul 2>&1

echo Done!
timeout /t 2 /nobreak >nul

endlocal
exit
