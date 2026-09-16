#lokey you need to stop looking here!

@echo off
setlocal
set AQUA_DIR=%LOCALAPPDATA%\Aquastrap
set AQUA_URL=https://raw.githubusercontent.com/dime-scripts/aquastrap-windows/refs/heads/main/AQUA.py
mkdir "%AQUA_DIR%" 2>nul
echo [AQUA]: checking python...
where python >nul 2>nul
if errorlevel 1 (
    echo [AQUA]: python was not found. Install Python from https://www.python.org/downloads/ and enable "Add python.exe to PATH", then run this again.
    pause
    exit /b 1
)
echo [AQUA]: downloading launcher...
where curl.exe >nul 2>nul
if not errorlevel 1 (
    curl.exe -fsSL "%AQUA_URL%" -o "%AQUA_DIR%\AQUA.py"
) else (
    echo [AQUA]: curl not found, using powershell...
    powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%AQUA_URL%' -OutFile '%AQUA_DIR%\AQUA.py'"
)
if not exist "%AQUA_DIR%\AQUA.py" (
    echo [AQUA]: download failed
    pause
    exit /b 1
)
echo [AQUA]: creating start menu shortcut...
powershell -NoProfile -WindowStyle Hidden -Command "$w=New-Object -ComObject WScript.Shell; $s=$w.CreateShortcut([IO.Path]::Combine($env:APPDATA,'Microsoft\Windows\Start Menu\Programs\Aquastrap.lnk')); $py=(Get-Command python).Source; $pyw=(Join-Path (Split-Path $py) 'pythonw.exe'); if(Test-Path $pyw){$py=$pyw}; $s.TargetPath=$py; $s.Arguments='\"%AQUA_DIR%\AQUA.py\"'; $s.WorkingDirectory='%AQUA_DIR%'; $s.Description='Aquastrap'; $s.Save()"
echo [AQUA]: launcher installed - first launch will download the full application
where pythonw.exe >nul 2>nul
if not errorlevel 1 (
    start "" pythonw.exe "%AQUA_DIR%\AQUA.py"
) else (
    start "" python "%AQUA_DIR%\AQUA.py"
)
endlocal
