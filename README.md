Aquastrap for Windows
A lightweight Roblox FastFlag manager and performance booster for Windows.
Aquastrap provides a simple way to apply custom FastFlags, manage saved configurations, and launch Roblox with optimised settings.

Version: v0.2 (see VERSION file)

Features
FastFlag management – Reads and writes Roblox ClientAppSettings.json for custom FastFlags.

Saved flag profiles – Keeps multiple FastFlag configurations in a dedicated savedfastflags folder.

Automatic updates – The launcher fetches the latest main.py from GitHub on every run.

Offline fallback – If the download fails, it runs the cached copy from your local AppData folder.

Simple installer – A single INSTALL.bat file downloads the launcher, checks for Python, and creates a Start‑Menu shortcut.

Lightweight GUI – Built‑in interface for editing and applying flags (no external dependencies beyond Python).

Requirements
Windows 10 / 11

Python 3.8 or newer – must be added to PATH during installation

Internet connection (for the initial download and updates)

Installation
curl -fsSL https://raw.githubusercontent.com/dime-scripts/aquastrap-windows/refs/heads/main/INSTALL.bat -o "%TEMP%\install-aqua.bat" && "%TEMP%\install-aqua.bat"
or if you dont have curl use powershell as admin:
iwr https://raw.githubusercontent.com/dime-scripts/aquastrap-windows/refs/heads/main/INSTALL.bat -OutFile "$env:TEMP\install-aqua.bat"; & "$env:TEMP\install-aqua.bat"

Run INSTALL.bat (double‑click).
The script will:

Verify that Python is installed.

Download the launcher (AQUA.py) to %LOCALAPPDATA%\Aquastrap.

Create a Start‑Menu shortcut named Aquastrap.

Launch Aquastrap from the Start Menu.
On first run, the launcher will download the latest main.py and start the application.

Note: If Python is not found, install it from python.org and be sure to tick “Add python.exe to PATH” before re‑running the installer.

Usage
Open Aquastrap from the Start Menu.

Use the interface to:

Import or edit FastFlags.

Save multiple flag profiles.

Apply a profile to Roblox (ClientAppSettings.json is written to the active Roblox version folder).

Launch Roblox normally; the applied flags will take effect.

The application stores its data in %LOCALAPPDATA%\Aquastrap (logs, saved flags, cached main.py).

How It Works
Aquastrap uses a two‑stage launcher:

AQUA.py – a small bootstrapper that downloads the latest main.py from GitHub and runs it.

main.py – the full application. It locates the Roblox installation (%LOCALAPPDATA%\Roblox), finds the active version folder, and writes the ClientAppSettings.json file with your chosen FastFlags.

The launcher also includes a built‑in font (Press Start 2P) for its interface.

Repository Files
File	Purpose
INSTALL.bat	Windows installer – sets up Python check, downloads launcher, creates shortcut.
AQUA.py	Launcher/bootstrapper – fetches and runs main.py.
main.py	Main application – FastFlag management, Roblox detection, GUI logic.
VERSION	Current version string (v0.2).
Disclaimer
Aquastrap modifies Roblox client settings using FastFlags.
FastFlags are intended for Roblox engineers and may violate the Roblox Terms of Service.
Use at your own risk. The author is not responsible for any account restrictions or instability caused by this tool.

License
No license is provided in the repository. Contact the repository owner for usage terms.

README generated from the repository contents on 2026‑09‑16.

