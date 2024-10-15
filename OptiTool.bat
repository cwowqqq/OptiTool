@echo off
title OptiTool v2.99.3
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
echo                 OptiTool v2.99 
echo ==================================================
echo.

:: Menu de optimizaciones
echo *1 - Optimizar PC
echo *2 - Optimizar RAM
echo *3 - Crear punto de restauracion (Recomendado)
echo *4 - Opciones de Defender
echo *5 - Litear Windows
echo *6 - Opciones extra
echo.

set /p op=Opcion: 
if "%op%"=="" goto :start
if "%op%"=="1" goto :optimization
if "%op%"=="2" goto :optiram
if "%op%"=="3" goto :respoint
if "%op%"=="4" goto :defoptions
if "%op%"=="5" goto :lite
if "%op%"=="6" goto :extra
(
    echo Opcion no valida. Por favor, elige una opcion del menu.
    timeout /t 2 /nobreak > nul
    goto :start
) else (
    goto :start
)



:optimization
cls
echo.
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.
echo Activando OptiGamingMode...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Recursos\Plan de Energia CPU\OptiGamingMode.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo.
echo Borrando Archivos Temporales...
del /S /F /Q "%temp%"
del /S /F /Q "%WINDIR%\Temp\*.*" >nul 2>&1
del /S /F /Q "%WINDIR%\Prefetch\*.*" >nul 2>&11
echo.
echo Aplicando Optimizaciones de Regedit
regedit /S "Recursos\Servicios\Optimizar Servicios.reg"
regedit /S "Recursos\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "Recursos\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Recursos\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graficos\Optimizar INTEL.reg"
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
timeout /t 3 /nobreak
goto :done

:optiram
cls
echo.
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.
echo Activando OptiGamingMode...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Recursos\Plan de Energia CPU\OptiGamingMode.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
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
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
echo.
echo Instalando MemReduct x86...
xcopy "Recursos\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
timeout /t 3 /nobreak
goto :doneram

:respoint
cls
echo ----------------------------------------------------
echo               Punto de restauracion
echo ----------------------------------------------------
echo.
echo Creando punto de restauracion...
echo.
echo.
"powershell.exe" -Command "Checkpoint-Computer -Description 'Antes Optimizacion'"
cls
echo Punto de restauracion creado.
timeout /t 2 /nobreak
goto :start


:defoptions
cls
echo --------------------------------------------------
echo                   Opciones de Defender
echo --------------------------------------------------
echo.
echo *1 - Deshabilitar Windows Defender
echo *2 - Habilitar Windows Defender
echo *3 - Comprobar el estado de Windows Defender
echo *4 - Regresar al menu.
echo.
set /p defop=Opción: 
if "%defop%"=="1" goto :defoff
if "%defop%"=="2" goto :defon
if "%defop%"=="3" goto :defcheck
if "%defop%"=="4" goto :start
goto :start

:defcheck
cls
echo --------------------------------------------------
echo         Verificacion de Windows Defender
echo --------------------------------------------------
echo.
echo Comprobando el estado de Windows Defender...
echo.
echo.
rem Comprobando el estado de Windows Defender...
echo.
echo.
powershell -Command "if ((Get-MpComputerStatus).RealTimeProtectionEnabled) { exit 0 } else { exit 1 }"
if %errorlevel%==0 (
    cls
    echo --------------------------------------------------
    echo                  Verificacion
    echo --------------------------------------------------
    echo.
    echo Windows Defender esta ACTIVADO! :)
    echo.
    echo NOTA: Este script no funciona bien, puede dar falsos
    echo datos, proximamente encontrare el error :)
) else (
    cls
    echo --------------------------------------------------
    echo                  Verificacion
    echo --------------------------------------------------
    echo.
    echo Windows Defender esta DESACTIVADO :(
    echo.
    echo NOTA: Este script no funciona bien, puede dar falsos
    echo datos, proximamente encontrare el error :)
)

pause
timeout /t 3 /nobreak >nul
goto :start

:defoff
cls
echo --------------------------------------------------
echo                   Defender
echo --------------------------------------------------
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
echo --------------------------------------------------
echo                   Defender
echo --------------------------------------------------
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

:lite
cls
echo --------------------------------------------------
echo                Litear Windows
echo --------------------------------------------------
echo.
echo  Esta seccion  borrara componentes del sistema
echo  para reducir el espacio y optimizar el HDD/SSD.
echo.
echo  En pocas palabras, tu sistema operativo se volvera
echo  ULTRA lite, lo que puede generar fallos
echo.  
echo     ESTO PUEDE ROMPER TU WINDOWS! ! !
echo.
echo !!! NO ME HAGO RESPONSABLE DE LO QUE PASE CON TU
echo            COMPUTADORA/LAPTOP ! ! !
echo.
echo.
echo --------------------------------------------------
echo.
timeout /t 5
pause
cls
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

:extinf
echo ===================================
echo          Informacion extra
echo ===================================
echo.
echo.
echo Esto es un secreto entre tu y yo... Eres ingles o español?
echo no importa, porque proximamente se vendran diferentes idiomas, como
echo Español, Ingles, Portugues etc. Posiblemente esto llegue para
echo la version 4.2 o 4.0, asi mas personas podrian entenderle.
echo. 
echo Si ven una gran tardanza entre la version 3.0 - 4.0 es por eso mismo
echo es porque estoy programe y programe los idiomas porque alch, usare IA para
echo eso de los idiomas, pero yo quiero hacer una gran mejora entre 3.0 - 4.0
echo Una mejora estetica, funcional, util y para que por fin, bye bye errores
echo entonces no te preocupes si tarda 3 meses cambiar de la 3.0 a 4.0
echo.
echo Este es un secreto, no le digas a nadie...
timeout /t 10 /nobreak > nul
goto :start

:extra
cls
echo --------------------------------------------------
echo                 Opciones extra
echo --------------------------------------------------
echo.
echo *1 - Informacion del sistema
echo *2 - Creditos
echo *3 - Regresar al menu principal.
echo.
set /p extraop=Opcion: 
if "%extraop%"=="1" goto :sysinf
if "%extraop%"=="2" goto :credits
if "%extraop%"=="3" goto :start
goto :extra


:done
cls
echo --------------------------------------------------
echo        Optimizacion realizada con exito
echo --------------------------------------------------
echo.
echo Tu sistema operativo fue optimizado correctamente!	  
echo Por favor reinicia tu PC para aplicar los cambios.
echo.
echo            Gracias por probar!
echo.
echo By OptiStudio
echo.
echo --------------------------------------------------
timeout /t 10 /nobreak
goto :start

:doneram
cls
echo --------------------------------------------------
echo      Optimizacion de RAM realizada con exito
echo --------------------------------------------------
echo.
echo Tu RAM fue optimizada  correctamente!	  
echo Por favor reinicia tu computadora para realizar los
echo cambios!
echo.
echo             Gracias por probar!
echo.
echo By OptiStudio
echo.
echo --------------------------------------------------
timeout /t 10 /nobreak
goto :start

:donelite
cls
echo --------------------------------------------------
echo      Sistema comprimido y liteado con exito
echo --------------------------------------------------
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
echo --------------------------------------------------
timeout /t 10 /nobreak
goto :start

:exit1
cls
echo Saliendo...
timeout /t 5 /nobreak >nul
exit

:exit2
cls
echo Confirme la salida...
pause
exit


:: Este programa es de uso abierto y puede ser modificado por todos. Solo no olvides darle
:: Creditos a su creador OptiStudio.
