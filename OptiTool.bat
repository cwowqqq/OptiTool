@echo off
title OptiTool v3.1.1
color 0A

:: BatGotAdmin
REM  --> Verificar permisos
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> Si se establece la bandera de error, no tenemos permisos de administrador.
if '%errorlevel%' NEQ '0' (
    goto UACP
) else (
    goto AdminEnable
)

:UACP
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:AdminEnable
    pushd "%CD%"
    CD /D "%~dp0"

:start
cls
echo ==================================================
echo                  OptiTool 
echo ==================================================
echo.

echo *1 - Optimizaciones
echo *2 - Crear punto de restauracion (Recomendado)
echo *3 - Opciones de Defender
echo *4 - Opciones extremas
echo *5 - Opciones adicionales
echo.

set /p op=A elegir: 
if "%op%"=="" goto :start
if "%op%"=="1" goto :optimenu
if "%op%"=="2" goto :respoint
if "%op%"=="3" goto :defoptions
if "%op%"=="4" goto :extreme
if "%op%"=="5" goto :extra
(
    echo Opcion no valida. Elije una opcion del menu :v
    timeout /t 2 /nobreak > nul
    goto :start
) else (
    goto :start
)

:optimenu
cls
echo ==================================================
echo             Menu de optimizaciones
echo ==================================================
echo.

echo *1 - Optimizar PC 
echo *2 - Optimizar RAM
echo *3 - Eliminar Archivos Temporales
echo *4 - Optimizar Internet (BETA)
echo *5 - Regresar al menu
echo.

set /p op=Opcion: 
if "%op%"=="1" goto :optimization
if "%op%"=="2" goto :optiram
if "%op%"=="3" goto :temporal
if "%op%"=="4" goto :optiwifi
if "%op%"=="5" goto :start


:optimization
cls
echo.
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.
echo Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Recursos\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo.
echo Borrando Archivos Temporales...

start "" "%~dp0Assets\batchutilities\FastTempDel.bat"

timeout /t 2 /nobreak >nul
echo.
echo Aplicando Optimizaciones de Regedit
regedit /S "Recursos\Servicios\Optimizar Servicios.reg"
regedit /S "Recursos\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "Recursos\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Recursos\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graficos\Optimizar INTEL.reg"
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Cortana.reg"
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
timeout /t 3 /nobreak
goto :done

:temporal
cls
echo ==================================================
echo           Borrar archivos temporales
echo ==================================================
echo.
echo Iniciando herramienta...
timeout /t 1 /nobreak >nul

start "" "%~dp0Assets\batchutilities\FastTempDel.bat"

pause
goto start

:optiwifi
cls
echo Aumentando el tamano de la cache de DNS...
netsh interface ip set global autotuninglevel=normal

echo Desactivando busqueda de servidor de nombres...
netsh interface ip set dns "Conexión de area local" dhcp

echo Limpiando cache de DNS...
ipconfig /flushdns

echo Restableciendo Winsock...
netsh winsock reset

echo Restableciendo la pila TCP/IP...
netsh int ip reset

echo.
echo Optimizacion completa. Por favor, reinicia tu computadora para aplicar todos los cambios.
echo.
echo Nota:Algunos cambios, como el restablecimiento de Winsock y TCP/IP, pueden afectar configuraciones personalizadas.
echo Es importante que los usuarios comprendan lo que hace cada comando antes de ejecutarlo.
pause
goto start


:optiram
cls
echo.
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.
echo Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Recursos\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo.
echo Borrando Archivos Temporales...
del /S /F /Q "%temp%"
del /S /F /Q "%WINDIR%\Temp\*.*" >nul 2>&1
del /S /F /Q "%WINDIR%\Prefetch\*.*" >nul 2>
echo.
echo Aplicando Optimizacion Regedit...
regedit /S "Recursos\Servicios\Optimizar Servicios.reg"
regedit /S "Recursos\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "Recursos\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Recursos\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graficos\Optimizar INTEL.reg"
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Cortana.reg"
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
echo.
echo Instalando MemReduct x86...
xcopy "Recursos\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
timeout /t 3 /nobreak
goto :doneram

:uninstalltool
cls
echo ==================================================
echo           Desinstalacion de programas
echo ==================================================
echo.
echo 1. Ejecutar Uninstall Tool
echo 2. Regresar al menu
echo.
set /p option=Opcion: 

if "%option%"=="1" (
    start "" "%~dp0Assets\batchutilities\desinstalar-tool\UninstallToolPortable.exe"
) else if "%option%"=="2" (
    goto start
) else (
    echo Opcion no valida. Intente nuevamente.
    goto uninstalltool
)

goto start


:roblaunchdownload
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto roblaunchdownload_2
if /I "%option%"=="y" goto roblaunchdownload_2
if /I "%option%"=="yes" goto roblaunchdownload_2
if /I "%option%"=="YES" goto roblaunchdownload_2 
if /I "%option%"=="N" goto start
if /I "%option%"=="n" goto start
if /I "%option%"=="no" goto start
if /I "%option%"=="NO" goto start

echo Invalid option. Exiting.
goto start

:roblaunchdownload_2
cls

start "" "%~dp0Assets\roblaunch\roblauncher-downloader.bat"

pause
goto start

:extreme
cls
echo ==================================================
echo        Opciones de optimizacion extremas
echo ==================================================
echo.
echo 1* - Litear Windows
echo 2* - Optimizacion extrema
echo 3* - Regresar al menu
echo.
echo Ya se agregaran mas!
echo.

set /p op=Opcion: 
if "%op%"=="1" goto :confirm_lite
if "%op%"=="2" goto :confirm_extremeopti
if "%op%"=="3" goto :start


:respoint
cls
echo ==================================================
echo               Punto de restauracion
echo ==================================================
echo.
echo Creando punto de restauracion...
echo.
timeout /t 1 /nobreak>nul
"powershell.exe" -Command "Checkpoint-Computer -Description 'Antes Optimizacion'"
cls
echo Punto de restauracion creado.
pause
goto :start

:extremeopti
cls
echo.
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.
echo Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Recursos\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo.
echo Borrando Archivos Temporales...
del /S /F /Q "%temp%"
del /S /F /Q "%WINDIR%\Temp\*.*" >nul 2>&1
del /S /F /Q "%WINDIR%\Prefetch\*.*" >nul 2>
echo.
echo Aplicando Optimizacion Regedit...
regedit /S "Recursos\Servicios\Optimizar Servicios.reg"
regedit /S "Recursos\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "Recursos\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Recursos\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graficos\Optimizar INTEL.reg"
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Cortana.reg"
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
echo.
echo Instalando MemReduct x86...
xcopy "Recursos\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
timeout /t 3 /nobreak
echo.
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.
echo Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Recursos\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo.
echo Borrando Archivos Temporales...

start "" "%~dp0Assets\batchutilities\FastTempDel.bat"

timeout /t 2 /nobreak >nul
echo.
echo Aplicando Optimizaciones de Regedit
regedit /S "Recursos\Servicios\Optimizar Servicios.reg"
regedit /S "Recursos\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "Recursos\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Recursos\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graficos\Optimizar INTEL.reg"
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Centro Acciones.reg"
regedit /S "Apariencia\Deshabilitar Transparencias.reg"
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Cortana.reg"
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
timeout /t 3 /nobreak
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotificationOnLockScreen" /t REG_DWORD /d 1 /f
echo Windows Defender fue deshabilitado correctamente.
timeout /t 3 /nobreak
echo.
echo Consiguiendo acceso a WinSxS...
echo.
takeown /F "%WINDIR%\WinSxS" /R /A
icacls "%WINDIR%\WinSxS" /grant *S-1-3-4:F /t /c /l /q
takeown /F "%WINDIR%\System32\Recovery" /R /A
icacls "%WINDIR%\System32\Recovery" /grant *S-1-3-4:F /t /c /l /q
echo Borrando Componentes WinSxS...
echo.
del /S /F /Q "%WINDIR%\WinSxS\Backup"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-font-truetype*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-font-truetype*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-shell-sounds*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-shell-sounds*"
del /S /F /Q "%WINDIR%\WinSxS\wow64*"
del /S /F /Q "%WINDIR%\WinSxS\msil*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-edgechromium*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-edgechromium*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_dual*"
del /S /F /Q "%WINDIR%\WinSxS\x86_dual*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_windows-defender*"
del /S /F /Q "%WINDIR%\WinSxS\x86_windows-defender*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-dynamic-image*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-dynamic-image*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-shell-sounds*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-shell-sounds*"
echo.
echo Borrando Sys Recovery...
del /S /F /Q "%WINDIR%\System32\Recovery"
echo.
echo Borrando Defender...
del /S /F /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender\Definition Updates"
echo.
echo Borrando Apps UWP...
echo.
powershell Get-AppxPackage -AllUsers | Where-Object { $_.Name -notlike "*store*" } | Remove-AppxPackage

start "" "%~dp0Assets\batchutilities\screen.bat"

timeout /t 3 /nobreak >nul
goto :done_extreme

:defoptions
cls
echo ==================================================
echo             Opciones de Defender
echo ==================================================
echo.
echo *1 - Deshabilitar Windows Defender
echo *2 - Habilitar Windows Defender
echo *3 - Regresar al menu.
echo.
set /p defop=Opción: 
if "%defop%"=="1" goto :defoff
if "%defop%"=="2" goto :defon
if "%defop%"=="3" goto :start
goto :start

:confirm_extremeopti2
cls
set /p option="SURE?!! (Y/N)? "

echo this can damage your Windows!

if /I "%option%"=="Y" goto extremeopti
if /I "%option%"=="y" goto extremeopti
if /I "%option%"=="yes" goto extremeopti
if /I "%option%"=="YES" goto extremeopti
if /I "%option%"=="N" goto extreme
if /I "%option%"=="n" goto extreme
if /I "%option%"=="no" goto extreme
if /I "%option%"=="NO" goto extreme


:defoff
cls
echo ==================================================
echo             Desactivar Defender
echo ==================================================
echo.
echo Deshabilitando Windows Defender.
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d 4 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotificationOnLockScreen" /t REG_DWORD /d 1 /f
echo Windows Defender fue deshabilitado correctamente.
timeout /t 3 /nobreak
goto :start

:defon
cls
echo ==================================================
echo            Activar Defender
echo ==================================================
echo.
echo Habilitando Windows Defender.
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sense" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc" /v "Start" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotification" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoToastApplicationNotificationOnLockScreen" /t REG_DWORD /d 0 /f
echo Windows Defender fue activado correctamente
timeout /t 3 /nobreak
goto :start

:extra
cls
echo ==================================================
echo             Opciones adicionales
echo ==================================================
echo.
echo *1 - Informacion del sistema
echo *2 - Creditos
echo *3 - Herramienta para desinstalar programas
echo *4 - Actualizar OptiTool
echo *5 - Regresar al menu principal.
echo.
set /p extraop=Opcion: 
if "%extraop%"=="1" goto :sysinf
if "%extraop%"=="2" goto :credits
if "%extraop%"=="3" goto :uninstalltool
if "%extraop%"=="4" goto :updateclient
if "%extraop%"=="5" goto :start
goto :extra

:confirm_extremeopti
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto confirm_extremeopti2
if /I "%option%"=="y" goto confirm_extremeopti2
if /I "%option%"=="yes" goto confirm_extremeopti2
if /I "%option%"=="YES" goto confirm_extremeopti2
if /I "%option%"=="N" goto extreme
if /I "%option%"=="n" goto extreme
if /I "%option%"=="no" goto extreme
if /I "%option%"=="NO" goto extreme

echo Invalid option. Exiting.
goto extreme

:confirm_lite
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto lite
if /I "%option%"=="y" goto lite
if /I "%option%"=="yes" goto lite
if /I "%option%"=="YES" goto lite
if /I "%option%"=="N" goto extreme
if /I "%option%"=="no" goto extreme
if /I "%option%"=="n" goto extreme
if /I "%option%"=="NO" goto extreme

echo Invalid option. Exiting.
goto extreme

:updateclient
cls
echo ==================================================
echo              Actualizar OptiTool
echo ==================================================
echo.
echo Iniciando cliente...
timeout /t 1 /nobreak >nul

start "" "%~dp0Updater.bat"

timeout /t 2 /nobreak >nul
goto exit2


:lite
cls
echo ==================================================
echo                Litear Windows
echo ==================================================
echo.
echo  Esta seccion  borrara componentes del sistema
echo  para reducir el espacio y optimizar el HDD/SSD.
echo.
echo  En pocas palabras, tu sistema operativo se volvera
echo  ULTRA lite, lo que puede generar fallos
echo.  
echo    ! ! ! ESTO PUEDE ROMPER TU WINDOWS! ! !
echo.
echo !!! NO ME HAGO RESPONSABLE DE LO QUE PASE CON TU
echo            COMPUTADORA/LAPTOP ! ! !
echo.
echo.
echo ==================================================
echo.
timeout /t 5
pause
cls
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Cortana.reg"
regedit /S "Apariencia\Deshabilitar Transparencias.reg"
regedit /S "Apariencia\Deshabilitar Centro Acciones.reg"
echo.
echo Consiguiendo acceso a WinSxS...
echo.
takeown /F "%WINDIR%\WinSxS" /R /A
icacls "%WINDIR%\WinSxS" /grant *S-1-3-4:F /t /c /l /q
takeown /F "%WINDIR%\System32\Recovery" /R /A
icacls "%WINDIR%\System32\Recovery" /grant *S-1-3-4:F /t /c /l /q
echo Borrando Componentes WinSxS...
echo.
del /S /F /Q "%WINDIR%\WinSxS\Backup"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-font-truetype*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-font-truetype*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-shell-sounds*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-shell-sounds*"
del /S /F /Q "%WINDIR%\WinSxS\wow64*"
del /S /F /Q "%WINDIR%\WinSxS\msil*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-edgechromium*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-edgechromium*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_dual*"
del /S /F /Q "%WINDIR%\WinSxS\x86_dual*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_windows-defender*"
del /S /F /Q "%WINDIR%\WinSxS\x86_windows-defender*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-dynamic-image*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-dynamic-image*"
del /S /F /Q "%WINDIR%\WinSxS\amd64_microsoft-windows-shell-sounds*"
del /S /F /Q "%WINDIR%\WinSxS\x86_microsoft-windows-shell-sounds*"
echo.
echo Borrando Sys Recovery...
del /S /F /Q "%WINDIR%\System32\Recovery"
echo.
echo Borrando Defender...
del /S /F /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender\Definition Updates"
echo.
echo Borrando Apps UWP...
echo.
powershell Get-AppxPackage -AllUsers | Where-Object { $_.Name -notlike "*store*" } | Remove-AppxPackage

start "" "%~dp0Assets\batchutilities\screen.bat"

start "" "%~dp0Assets\batchutilities\FastTempDel.bat"

goto :donelite


:credits
cls
echo Iniciando herramienta de creditos...
echo.
start "" "%~dp0Assets\batchutilities\creds.bat"

timeout /t 2 /nobreak >nul
goto exit1

:sysinf
cls
echo Iniciando SystemInfo...
echo.
start "" "%~dp0Assets\batchutilities\sysinfo.bat"

timeout /t 2 /nobreak >nul
goto exit1

:done
cls
echo ==================================================
echo        Optimizacion realizada con exito
echo ==================================================
echo.
echo Tu sistema operativo fue optimizado correctamente!	  
echo Por favor reinicia tu PC para aplicar los cambios.
echo.
echo            Gracias por probar!
echo.
echo By OptiStudio
echo.
echo ==================================================
timeout /t 10 /nobreak
goto :start

:doneram
cls
echo ==================================================
echo      Optimizacion de RAM realizada con exito
echo ==================================================
echo.
echo Tu RAM fue optimizada  correctamente!	  
echo Por favor reinicia tu computadora para realizar los
echo cambios!
echo.
echo             Gracias por probar!
echo.
echo By OptiStudio
echo.
echo ==================================================
timeout /t 10 /nobreak
goto :start

:done_extreme
cls
echo ==================================================
echo          Sistema comprimido al tope
echo ==================================================
echo.
echo     Tu sistema operativo fue comprimido y 
echo           optimizado a no mas poder
echo.
echo Por favor reinicia tu computadora para realizar los
echo cambios!
echo.
echo.
echo ! ! !  CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo             By OptiStudio
echo.
echo ==================================================
start "" "%~dp0Assets\messages\message_lite.vbs"
goto :start


:donelite
cls
echo ==================================================
echo      Sistema comprimido y liteado con exito
echo ==================================================
echo.
echo Tu sistema fue comprimido y liteado a no mas poder  
echo Por favor reinicia tu computadora para realizar los
echo cambios!
echo.
echo.
echo ! ! !  CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo By OptiStudio
echo.
echo ==================================================
pause
start "" "%~dp0Assets\messages\message_lite.vbs"
goto :start

:exit1
cls
echo Saliendo del script...
timeout /t 5 /nobreak >nul
exit

:exit2
cls
echo Saliendo del script...
pause
exit


:: Este programa es de uso abierto y puede ser modificado por todos. Solo no olvides darle
:: Creditos a su creador OptiStudio.
