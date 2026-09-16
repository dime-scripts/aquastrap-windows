
@echo off
setlocal
set AQUA_DIR=%LOCALAPPDATA%\Aquastrap
mkdir "%AQUA_DIR%" 2>nul
echo [AQUA]: checking python...
where python >nul 2>nul
if errorlevel 1 (
    echo [AQUA]: python was not found. Install Python from https://www.python.org/downloads/ and enable "Add python.exe to PATH", then run this again.
    pause
    exit /b 1
)
echo [AQUA]: downloading launcher...
curl -fsSL "https://raw.githubusercontent.com/dime-scripts/aquastrap-windows/refs/heads/main/AQUA.py" -o "%AQUA_DIR%\AQUA.py"
if errorlevel 1 (
    echo [AQUA]: download failed
    pause
    exit /b 1
)
echo [AQUA]: creating start menu shortcut...
powershell -NoProfile -WindowStyle Hidden -Command "$w=New-Object -ComObject WScript.Shell; $s=$w.CreateShortcut([IO.Path]::Combine($env:APPDATA,'Microsoft\Windows\Start Menu\Programs\Aquastrap.lnk')); $py=(Get-Command python).Source; $pyw=(Join-Path (Split-Path $py) 'pythonw.exe'); if(Test-Path $pyw){$py=$pyw}; $s.TargetPath=$py; $s.Arguments='\"%AQUA_DIR%\AQUA.py\"'; $s.WorkingDirectory='%AQUA_DIR%'; $s.Description='Aquastrap'; $s.Save()"
echo [AQUA]: launcher installed - first launch will download the full application
start "" "%AQUA_DIR%\AQUA.py"
endlocal
