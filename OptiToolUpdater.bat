@echo off
title OptiTool Updater v1.0
color 0A

del "OptiTool.bat"
"%CD%\Assets\wget.exe" -q --show-progress --connect-timeout=15 --tries=3 -P "%CD%" "https://raw.githubusercontent.com/OptiStudioXD/OptiTool/main/OptiTool.bat"

pause
exit
