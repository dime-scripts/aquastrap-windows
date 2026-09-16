#!/usr/bin/env python3
import os,sys,subprocess,urllib.request
from pathlib import Path
REPO="dime-scripts/aquastrap-windows"
URLS=[
f"https://raw.githubusercontent.com/{REPO}/refs/heads/main/main.py",
f"https://raw.githubusercontent.com/{REPO}/main/main.py"
]
LOCAL=Path(os.environ.get("LOCALAPPDATA") or str(Path.home()/"AppData"/"Local"))
BASE=LOCAL/"Aquastrap"
BASE.mkdir(parents=True,exist_ok=True)
CACHE=BASE/"main.py"
def emit(tag,msg):
    print(f"[{tag}]: {msg}",flush=True)
def valid(code):
    if len(code)<500:
        return False
    try:
        compile(code,"main.py","exec")
        return True
    except Exception:
        return False
def fetch():
    for u in URLS:
        try:
            req=urllib.request.Request(u,headers={"User-Agent":"Aquastrap-Launcher"})
            with urllib.request.urlopen(req,timeout=20) as r:
                code=r.read().decode("utf-8","replace")
            if valid(code):
                return code
            emit("WARNING",f"downloaded file looks invalid: {u}")
        except Exception as e:
            emit("WARNING",f"download failed ({u}): {e}")
    return None
def main():
    emit("AQUA","launcher starting")
    code=fetch()
    if code is not None:
        tmp=BASE/".main.new.py"
        tmp.write_text(code,encoding="utf-8")
        if valid(code):
            os.replace(tmp,CACHE)
            emit("AQUA","latest main.py downloaded")
        else:
            emit("WARNING","downloaded main.py broken, keeping cached copy")
            try:tmp.unlink()
            except Exception:pass
    elif CACHE.exists():
        emit("WARNING","offline, running cached main.py")
    else:
        emit("ERROR","download failed and no cached main.py exists")
        try:
            import ctypes
            ctypes.windll.user32.MessageBoxW(0,"Aquastrap could not download the app and no cached copy exists. Check your internet connection and try again.","Aquastrap",0x10)
        except Exception:pass
        sys.exit(1)
    proc=subprocess.Popen([sys.executable,str(CACHE)]+sys.argv[1:],cwd=str(BASE))
    sys.exit(proc.wait())
if __name__=="__main__":
    main()
