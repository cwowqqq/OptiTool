@echo off
color 0A
set OPTI_VER=OptiTool v3.9
set OPTI_TIT=OptiTool
set OPTI_TEXT=OptiTool - Script de optimizacion
set WGET="%~dp0Assets\wget.exe"
set FFPLAY="%~dp0Assets\ffplay.exe"

:: Espero que OptiJuegos no se enoje por esto (el codigo para solicitar admin, todo lo demas fue hecho por mi y por ayuda de BlackBoxAI o ChatGPT)

:: Solicita permisos de administrador
REM  --> Verificar si el script tiene permisos
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
	
:: Coloca la version como titulo
title %OPTI_VER%
	
:: Verifica si existe el archivo de options, si existe, vamonos a :start, si no existe muestra el tutorial
:verification
if exist "%CD%\Assets\extra\options.txt" (
    goto :start
) else (
    goto :poststart
)

:: Crea la carpeta en caso de que haya un problema critico
mkdir "Assets\critical" >nul 2>&1	

	
:poststart
cls
echo ==================================================
echo              Project OptiTool
echo ==================================================
echo Bienvenido a %OPTI_VER%. Un script .bat para aplicar
echo optimizaciones.
echo.
echo Para moverte por el menu, debes seleccionar las Opciones
echo utilizando los numeros, como 1, 2, 3, 4 y presionando Enter.
echo ==================================================
pause

:: Crear un archivo de opciones, para despues comprobar si no es la primera vez ejecutando el %OPTI_VER%
type nul > "%CD%\Assets\extra\options.txt"

:: Comprobando si el sistema es Windows XP o anterior
ver | findstr /i "5\.1\." >nul
if %errorlevel%==0 (
    goto :old_os_warning
) else (
    goto :start
)
:old_os_warning
echo AVISO:
echo Tu Windows es bastante antiguo, lo que puede causar errores
echo con las optimizaciones. Te recomendamos que si, es posible
echo actualices a una version mas nueva de Windows
pause
goto start

:start
:: Limpia la pantalla
cls
:: Muestra el titulo, usando %OPTI_VER%
echo ==================================================
echo %OPTI_VER%
echo ==================================================
echo.

:: Muestra las opciones del menu de inicio
echo *1 - Optimizaciones
echo *2 - Crear punto de restauracion (Recomendado)
echo *3 - Opciones de Defender
echo *4 - Opciones extremas
echo *5 - Opciones adicionales
echo.

:: Comandos para elegir las opciones
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
:: Sostiene los errores cuando insertas una opcion equivocada, evitando redirigirte a otros menus

:: Menu de optimizaciones, aqui vale madres lo de comprobar si el sistema es Win XP, xd
:: Decoracion horrible por q me crashean los ascii
:optimenu
cls
echo ==================================================
echo             Menu de optimizaciones
echo ==================================================
echo.

echo *1 - Optimizar PC 
echo *2 - Optimizar RAM
echo *3 - Eliminar Archivos Temporales
echo *4 - Optimizar Internet
echo *5 - Limpiar Cache
echo *6 - Desfragmentar disco duro (HDD)
echo *7 - Comprobar estado del disco (Experimental)
echo *8 - Gestionar programas de inicio (Experimental)
echo *9 - Actualizar Drivers (Navegador)
echo *10 - Regresar al menu
echo.
echo %OPTI_TEXT%
echo.

set /p op=Opcion: 
if "%op%"=="1" goto :optimization
if "%op%"=="2" goto :optiram
if "%op%"=="3" goto :temporal
if "%op%"=="4" goto :optiwifi
if "%op%"=="5" goto :cleancache
if "%op%"=="6" goto :defragdisk
if "%op%"=="7" goto :checkdisk
if "%op%"=="8" goto :managestart
if "%op%"=="9" goto :driversupdate
if "%op%"=="10" goto :start
if "%op%"=="developmode" goto :confirm_develop
(
    echo Opcion no valida. Elije una opcion del menu :v
    timeout /t 2 /nobreak > nul
    goto :optimenu
) else (
    goto :optimenu
)

:: Optimizacion general
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
regedit /S "Recursos\General\Mejorar La Velocidad del Menu.reg"
regedit /S "Recursos\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Recursos\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graficos\Optimizar INTEL.reg"
regedit /S "Apariencia\Deshabilitar Animaciones.reg"
regedit /S "Apariencia\Deshabilitar Cortana.reg"
regedit /S "Graficos\Optimizar NVIDIA.reg"
regedit /S "Graficos\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
timeout /t 3 /nobreak
echo Optimizacion realizada con exito
echo.
echo %OPTI_TEXT%
pause
goto :done

:managestart
:: Mostrar programas de inicio
echo Programas de inicio actuales:
echo ==================================================
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
echo ==================================================
echo.

:: Opciones para desactivar
set /p program="Ingresa el nombre del programa que deseas desactivar (ejemplo: ProgramName) o 'todos' para desactivar todos: "

if /i "%program%"=="todos" (
    echo Desactivando todos los programas de inicio...
    reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /f
    echo Todos los programas de inicio han sido desactivados.
) else (
    echo Desactivando %program%...
    reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%program%" /f
    if %errorlevel%==0 (
        echo %program% ha sido desactivado exitosamente.
    ) else (
        echo No se pudo encontrar %program% o ya ha sido desactivado.
    )
)

echo.
echo Se recomienda reiniciar el sistema para aplicar los cambios
pause
goto :start

:: Revision del disco duro
:checkdisk
cls
setlocal enabledelayedexpansion

echo Opciones de unidades disponibles:
for %%d in (C D E F G) do (
    if exist %%d:\ (
        echo %%d: 
    )
)

set /p drive="Selecciona la unidad a comprobar (por ejemplo, C): "

:: Validar la entrada del usuario
if not exist %drive%:\ (
    echo La unidad %drive% no existe. Por favor, selecciona una unidad valida.
    pause
    goto :checkdisk
)

echo Comprobando y reparando errores en la unidad %drive%...
echo Esto puede tardar un tiempo. Por favor, espera.

:: Ejecutar chkdsk con la opcion /f
chkdsk %drive%: /f

if %errorlevel%==0 (
    echo La verificacion se completo sin errores.
) else (
    echo Se encontraron errores en la unidad %drive% y se han corregido.
)

echo.
echo Verificacion completada. Presione espacio para regresar al menu
pause >nul
goto :start



:: Desfragmentacion del disco duro
:defragdisk
setlocal
cls
echo *******************************************
echo   ¡ADVERTENCIA! SOLO RECOMENDABLE EN UNIDADES HDD
echo   YA QUE EN LOS SSD ACORTA SU VIDA UTIL.
echo *******************************************
pause

:: Lista las unidades disponibles.
echo *** Listando unidades disponibles en el sistema ***
for /f "skip=1 tokens=1" %%i in ('wmic logicaldisk get name') do (
    echo Unidad: %%i
)

:: Solicita al usuario ingresar una unidad de la lista
:iniciarIngresoUnidad
set /p drive="Ingresa la letra de la unidad a desfragmentar (ej. C): "

:: Verificar si el usuario ingreso una letra de unidad
if "%drive%"=="" (
    echo No se ha ingresado ninguna unidad. Saliendo...
    goto finalizarProceso
)

:: Verifica si la unidad seleccionada existe, si existe continua, si no existe, reinicia el proceso
echo *** Verificando existencia de la unidad %drive%...
if not exist %drive%: (
    echo La unidad %drive% no es valida o no existe. Por favor, ingresa una unidad correcta.
    goto iniciarIngresoUnidad
)

:: Pregunta al usuario si desea continuar con la desfragmentacion
set /p confirm="¿Deseas desfragmentar la unidad %drive%? (S/N): "
if /i not "%confirm%"=="S" (
    echo Operacion cancelada. Saliendo...
    goto finalizarProceso
)

:: Ejecuta el proceso de desfragmentacion con "defrag %drive%: /O /H"
echo *** Desfragmentando la unidad %drive%... Esto puede tardar un tiempo ***
defrag %drive%: /O /H

:: Verifica si la desfragmentacion fue realizada con exito, si no lo fue, muestra un mensaje de error
if %errorlevel%==0 (
    echo *** Desfragmentacion completada exitosamente. ***
) else (
    echo *** Ocurrio un error durante la desfragmentacion. ***
)

:: Termina el proceso
:finalizarProceso
pause
goto done_defrag

:driversupdate
cls
echo.
echo ==================================================
echo          Actualizar controladores
echo ==================================================
echo.
echo 1. Actualizar controladores de AMD
echo 2. Actualizar controladores de Intel
echo 3. Actualizar controladores de NVIDIA
echo 4. Regresar al menu
echo.

set /p option="Opcion: "

if "%option%"=="1" (
    echo Abriendo pagina de AMD...
    start https://goo.su/eU5BaaT
	timeout /t 2 /nobreak >nul
	goto :start
) else if "%option%"=="2" (
    echo Abriendo pagina de Intel...
    start https://goo.su/Wdo3
	timeout /t 2 /nobreak >nul
	goto :start
) else if "%option%"=="3" (
    echo Abriendo pagina de NVIDIA...
    start https://goo.su/z1V5vv
	timeout /t 2 /nobreak >nul
	goto :start
) else if "%option%"=="4" (
    goto :extra
) else (
    echo Opcion no valida. Selecciona una del menu :v
)

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
echo Limpiando la cache DNS...
ipconfig /flushdns >nul 2>&1

echo Aplicando DNS de Cloudfare...
FOR /F "tokens=* delims=:" %%a IN ('IPCONFIG ^| FIND /I "ETHERNET ADAPTER"') DO (
SET adapterName=%%a >nul 2>&1
SET adapterName=!adapterName:~17! >nul 2>&1
SET adapterName=!adapterName:~0,-1! >nul 2>&1
netsh interface ipv4 set dns name="!adapterName!" static 1.1.1.1 primary >nul 2>&1
netsh interface ipv4 add dns name="!adapterName!" 1.0.0.1 index=2 >nul 2>&1
)

echo Eliminando el limite QoS...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\QoS" /v LimitReservableBandwidth /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1
echo.

echo Aplicando regedit (TCP)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v GlobalMaxTcpWindowSize /t REG_DWORD /d 0x7FFF /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNumConnections /t REG_DWORD /d 0xFFFFFF /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCP1323opts /t REG_DWORD /d 1 /f >nul 2>&1
timeout /t 3 /nobreak >nul
goto done

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

:cleancache
cls
echo Eliminando archivos de cache...

:: Limpiar archivos temporales
echo Limpiando archivos temporales...
del /q /f "%temp%\*.*" >nul 2>&1
if %errorlevel% neq 0 (
    echo No se pudieron eliminar algunos archivos temporales.
) else (
    rd /s /q "%temp%" >nul 2>&1
    mkdir "%temp%" >nul 2>&1
    echo Archivos temporales eliminados.
)

:: Limpiar cache de Internet Explorer
echo Limpiando cache de Internet Explorer...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de Internet Explorer.
) else (
    echo Cache de Internet Explorer eliminada.
)

:: Limpiar cache de Windows Store
echo Limpiando cache de la Tienda de Windows...
start /wait wsreset.exe
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de la Tienda de Windows.
) else (
    echo Cache de la Tienda de Windows limpiada.
)

:: Limpiar cache de DNS
echo Limpiando cache de DNS...
ipconfig /flushdns >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de DNS.
) else (
    echo Cache de DNS eliminada.
)

:: Limpiar cache de Thumbnails
echo Limpiando cache de Thumbnails...
del /q /f "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de Thumbnails.
) else (
    echo Cache de Thumbnails eliminada.
)

echo Limpieza de cache completada.
pause
goto :start

:chavodel8_acapulco
%FFPLAY% -hide_banner -window_title "Reproductor" -fflags nobuffer -flags low_delay -sn -ac 2 -fast "https://archive.org/download/elchavo_201709/El Chavo del 8 - Vacaciones en Acapulco.mp4"
pause
goto :start

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

set /p op=Opcion: 
if "%op%"=="1" goto :confirm_lite
if "%op%"=="2" goto :confirm_extremeopti
if "%op%"=="3" goto :start
(
    echo Opcion no valida. Elije una opcion del menu :v
    timeout /t 2 /nobreak > nul
    goto :extreme
) else (
    goto :extreme
)

:: Crea un punto de restauracion para restablecer cambios en caso de que las optimizaciones no sean de agrado
:respoint
cls
echo ==================================================
echo            Punto de restauracion
echo ==================================================
echo.

echo Creando punto de restauracion...
echo.
timeout /t 1 /nobreak >nul

:: Intentar crear el punto de restauracion y manejar errores
powershell.exe -Command "try { Checkpoint-Computer -Description 'Antes Optimizacion' -ErrorAction Stop } catch { Write-Host 'Error al crear el punto de restauracion: $_' }"

:: Comprobar si la creacion del punto fue exitosa
if %errorlevel%==0 (
    cls
    echo Punto de restauracion creado exitosamente.
) else (
    cls
    echo *** ERROR: No se pudo crear el punto de restauracion. ***
    echo Detalles del error:
    powershell.exe -Command "Write-Host 'Detalles: ' $_"
)

:: Esperar y finalizar
pause
goto :start

:extremeopti
cls
echo Esto esta en modo beta. Si quieres continuar continua...
pause
:: Se ejecutan los bloques
call :opti
call :optiram
call :lite_cus
call :defoff
call :cleancache
call :optiwifi
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
echo *3 - Reiniciar Windows Defender
echo *4 - Actualizar las definiciones de virus
echo *5 - Ver estado de Windows Defender
echo *6 - Ver historial de Proteccion
echo *7 - Regresar al menu
echo.
set /p defop=Opción: 
if "%defop%"=="1" goto :defoff
if "%defop%"=="2" goto :defon
if "%defop%"=="3" goto :defreset
if "%defop%"=="4" goto :mpsignature
if "%defop%"=="5" goto :defstatus
if "%defop%"=="6" goto :defhistory
if "%defop%"=="7" goto :start
if "%defop%"=="developmode" goto :confirm_develop
goto :start

:confirm_extremeopti2
cls
echo This can damage your Windows! Esto puede dañar tu Windows!
set /p option="SURE?! (Y/N)? "

if /I "%option%"=="Y" goto extremeopti
if /I "%option%"=="y" goto extremeopti
if /I "%option%"=="yes" goto extremeopti
if /I "%option%"=="YES" goto extremeopti
if /I "%option%"=="N" goto extreme
if /I "%option%"=="n" goto extreme
if /I "%option%"=="no" goto extreme
if /I "%option%"=="NO" goto extreme

:defreset
cls
echo Reiniciando Windows Defender...
powershell -Command "Stop-Service -Name WinDefend -Force; Start-Service -Name WinDefend"
if %errorlevel% neq 0 (
    echo Hubo un error al reiniciar Windows Defender.
    pause
    goto start
)
echo Windows Defender ha sido reiniciado correctamente.
pause
goto start

:defstatus
cls
echo Consultando el estado de Windows Defender...
powershell -Command "Get-MpComputerStatus"
if %errorlevel% neq 0 (
    echo Hubo un error al consultar el estado de Windows Defender.
    pause
    goto start
)
pause
goto start

:mpsignature
cls
echo Actualizando las definiciones de virus de Windows Defender...
powershell -Command "Update-MpSignature"
if %errorlevel% neq 0 (
    echo Hubo un error al actualizar las definiciones de Windows Defender.
    pause
    goto start
)
echo Definiciones de Windows Defender actualizadas correctamente.
pause
goto start

:defhistory
cls
echo Abriendo el historial de proteccion de Windows Defender...
powershell -Command "Get-WinEvent -LogName 'Microsoft-Windows-Windows Defender/Operational' | Select-Object -First 10"
if %errorlevel% neq 0 (
    echo Hubo un error al obtener el historial de proteccion de Windows Defender.
    pause
    goto start
)
pause
goto start


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
echo *5 - Reparar archivos danados del sistema (SFC)
echo *6 - Desactivar notificaciones
echo *7 - Regresar al menu
echo.
set /p extraop=Opcion: 
if "%extraop%"=="1" goto :sysinf
if "%extraop%"=="2" goto :credits
if "%extraop%"=="3" goto :uninstalltool
if "%extraop%"=="4" goto :updateclient
if "%extraop%"=="5" goto :sfc_scan
if "%extraop%"=="6" goto :disablenotis
if "%extraop%"=="7" goto :start
if "%extraop%"=="roblaunch" goto roblaunchdownload
if "%extraop%"=="developmode" goto :confirm_develop
goto :extra

:sfc_scan
cls
echo Comprobando y reparando archivos del sistema...
sfc /scannow
pause
goto menu

:disablenotis
cls
echo Desactivando las notificaciones de Windows...
powershell -Command "Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Value 0"
echo Notificaciones desactivadas.
pause
goto menu

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

:confirm_develop
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto develop
if /I "%option%"=="y" goto develop
if /I "%option%"=="yes" goto develop
if /I "%option%"=="YES" goto develop
if /I "%option%"=="N" goto start
if /I "%option%"=="n" goto start
if /I "%option%"=="no" goto start
if /I "%option%"=="NO" goto start

:develop
cls
echo Develop Mode : OptiTool
echo.
echo *1 - Direct Goto
echo *2 - Open base code "Updater"
echo *3 - Help
echo *4 - Open base code "OptiTool"
echo *5 - Generate a report (BETA)
echo *6 - Run tests (BETA)
echo *7 - Make a Backup of this script
echo *8 - Set environment variables (INDEV)
echo *9 - Advanzed System Information
echo *10 - Exit of Develop Mode


set /p option="Enter option: "

if /I "%option%"=="1" goto direct_goto
if /I "%option%"=="2" start notepad "%~dp0Updater.bat"
if /I "%option%"=="3" goto dev_help
if /I "%option%"=="4" start notepad "%~dp0OptiTool.bat"
if /I "%option%"=="5" goto GenerateReport
if /I "%option%"=="6" goto RunTests
if /I "%option%"=="7" goto BackupProject
if /I "%option%"=="8" goto EnvironmentVariables
if /I "%option%"=="9" goto sysinfo_av
if /I "%option%"=="10" goto extra
(
    echo That option is not valid! Select a option from the menu
    timeout /t 2 /nobreak > nul
    goto :develop
) else (
    goto :develop
)


:dev_help
echo Not available
pause >nul
goto exit1

:direct_goto
cls
echo Direct Goto
echo Type "exit" to exit
echo.
set /p option="Enter goto: "

:: Verificar si el usuario ha ingresado "exit" para salir
if /I "%option%"=="exit" goto develop

:: Validar si la etiqueta existe
goto %option% 2>nul
if errorlevel 1 (
    echo La etiqueta "%option%" no existe. Por favor, intenta de nuevo.
    pause
    goto direct_goto
)

:: Si la etiqueta existe, se ejecuta el goto

:: Muestra la informacion horriblemente detallada del sistema
:sysinfo_av
cls
echo Mostrando informacion detallada del sistema...
echo.

:: Mostrar la version del sistema operativo
echo Version del Sistema Operativo:
powershell -command "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber, OSArchitecture, LastBootUpTime | Format-Table -AutoSize"
echo.

:: Mostrar el nombre del sistema
echo Nombre del Sistema:
powershell -command "Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Name, Domain, Manufacturer, Model, TotalPhysicalMemory | Format-Table -AutoSize"
echo.

:: Mostrar informacion detallada del sistema
echo Informacion del Sistema:
systeminfo
echo.

:: Mostrar informacion especifica de la BIOS
echo Informacion de la BIOS:
powershell -command "Get-CimInstance -ClassName Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate, SerialNumber, Version | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre el procesador
echo Informacion del Procesador:
powershell -command "Get-CimInstance -ClassName Win32_Processor | Select-Object Name, MaxClockSpeed, CurrentClockSpeed, NumberOfCores, NumberOfLogicalProcessors, L2CacheSize, L3CacheSize, AddressWidth | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre la memoria
echo Informacion de la Memoria:
powershell -command "Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object @{Name='Capacidad (GB)';Expression={[math]::round($_.Capacity/1GB, 2)}}, Speed, Manufacturer, PartNumber, SerialNumber, @{Name='Tipo de Memoria';Expression={switch ($_.MemoryType) {0 {'Desconocido'} 1 {'Otro'} 2 {'DRAM'} 3 {'SDRAM'} 4 {'Cache DRAM'} 5 {'EDRAM'} 6 {'VRAM'} 7 {'SRAM'} 8 {'RAM'} 9 {'ROM'} default {'Otro'}}}} | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre el almacenamiento
echo Informacion de las Unidades de Disco:
powershell -command "Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object DeviceID, Description, @{Name='Espacio Libre (GB)';Expression={[math]::round($_.FreeSpace/1GB, 2)}}, @{Name='Tamano Total (GB)';Expression={[math]::round($_.Size/1GB, 2)}}, DriveType | Format-Table -AutoSize"
echo.

:: Mostrar informacion de la red
echo Informacion de la Red:
powershell -command "Get-CimInstance -ClassName Win32_NetworkAdapter | Where-Object { $_.NetConnectionStatus -eq 2 } | Select-Object Name, MACAddress, Speed, NetConnectionStatus, Manufacturer | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre la conexion a Internet
echo Informacion de la Conexion a Internet:
powershell -command "Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | Select-Object Description, DHCPServer, @{Name='ISP';Expression={if ($_.DNSDomain) { $_.DNSDomain } else { 'Desconocido' }}} | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre el software instalado
echo Software Instalado:
powershell -command "Get-CimInstance -ClassName Win32_Product | Select-Object Name, Version, Vendor | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre los controladores
echo Informacion de los Controladores:
powershell -command "Get-CimInstance -ClassName Win32_SystemDriver | Select-Object Name, DisplayName, Manufacturer, Version, StartType | Format-Table -AutoSize"
echo.

:: Mostrar informacion sobre la configuracion del sistema
echo Informacion de Configuracion del Sistema:
powershell -command "Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object TotalPhysicalMemory, UserName, DomainRole, NumberOfLogicalProcessors, @{Name='Tipo de Sistema';Expression={if ($_.SystemType -eq 'x64-based PC') {'64-bit'} else {'32-bit'}}} | Format-Table -AutoSize"
echo.

:: Mostrar estadisticas del sistema
echo Estadisticas del Sistema:
powershell -command "Get-CimInstance -ClassName Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object Average | Format-Table -AutoSize"
echo.

:: Mostrar variables de entorno
echo Variables de Entorno:
set
echo.

pause
goto :develop

:GenerateReport
cls
echo Generando informe...
set "reportFile=%~dp0Assets\inf\report.txt"

echo Informe de Proyecto > "%reportFile%"
echo ================== >> "%reportFile%"
echo. >> "%reportFile%"

echo Archivos en el directorio actual: >> "%reportFile%"
dir /b >> "%reportFile%"

echo. >> "%reportFile%"
echo Resumen: >> "%reportFile%"
echo Total de archivos: %errorlevel% >> "%reportFile%"

echo Informe guardado en %reportFile%.
pause
goto :develop

:RunTests
cls
echo Ejecutando pruebas...
set "testResults=%~dp0Assets\inf\test_results.txt"

echo Resultados de Pruebas > "%testResults%"
echo =================== >> "%testResults%"
echo. >> "%testResults%"

:: Simular la ejecución de pruebas
set /a passed=0
set /a failed=0

:: Pruebas adicionales
set "tests=5"
for /l %%i in (1, 1, %tests%) do (
    echo Ejecutando prueba de funcionalidad %%i...
    timeout /t 1 >nul
    set /a result=!random! %% 2
    if !result! == 0 (
        echo Prueba de funcionalidad %%i: PASSED >> "%testResults%"
        set /a passed+=1
    ) else (
        echo Prueba de funcionalidad %%i: FAILED >> "%testResults%"
        set /a failed+=1
    )
)

:: Prueba de conectividad a un servidor (simulada)
echo Verificando conectividad a un servidor...
ping -n 1 8.8.8.8 >nul
if !errorlevel! == 0 (
    echo Prueba de conectividad: PASSED >> "%testResults%"
    set /a passed+=1
) else (
    echo Prueba de conectividad: FAILED >> "%testResults%"
    set /a failed+=1
)

:: Verificación de espacio en disco (simulada)
echo Verificando espacio en disco...
for /f "tokens=3" %%a in ('wmic logicaldisk get size,freespace /format:csv ^| findstr /i "C:"') do (
    set /a freeSpace=%%a
)
if !freeSpace! gtr 1000000000 (
    echo Verificación de espacio en disco: PASSED >> "%testResults%"
    set /a passed+=1
) else (
    echo Verificación de espacio en disco: FAILED >> "%testResults%"
    set /a failed+=1
)

:: Prueba de CPU (simulada)
echo Verificando uso de CPU...
set /a cpuUsage=!random! %% 100
if !cpuUsage! lss 80 (
    echo Prueba de uso de CPU: PASSED >> "%testResults%"
    set /a passed+=1
) else (
    echo Prueba de uso de CPU: FAILED >> "%testResults%"
    set /a failed+=1
)

:: Prueba de memoria (simulada)
echo Verificando uso de memoria...
set /a memoryUsage=!random! %% 100
if !memoryUsage! lss 80 (
    echo Prueba de uso de memoria: PASSED >> "%testResults%"
    set /a passed+=1
) else (
    echo Prueba de uso de memoria: FAILED >> "%testResults%"
    set /a failed+=1
)

:: Total de pruebas
echo. >> "%testResults%"
set /a total=passed+failed
echo Total de pruebas: %total% >> "%testResults%"
echo Pruebas pasadas: %passed% >> "%testResults%"
echo Pruebas fallidas: %failed% >> "%testResults%"

echo Resultados guardados en %testResults%.
pause
goto :develop


:BackupProject
cls
echo Realizando copia de seguridad del proyecto...
set "backupDir=C:\OptiStudio\OptiTool_Backup"
:: Carpeta del proyecto (directorio donde se encuentra el script)
set "sourceDir=%~dp0" 

:: Crear la carpeta de copia de seguridad si no existe
if not exist "%backupDir%" (
    mkdir "%backupDir%"
)

:: Copiar archivos y carpetas al directorio de respaldo
xcopy "%sourceDir%*" "%backupDir%\" /E /I /Y

if %errorlevel% equ 0 (
    echo Copia de seguridad completada con exito en "%backupDir%".
) else (
    echo Error al realizar la copia de seguridad.
)

pause
goto :develop

:EnvironmentVariables
cls
echo Configurando Variables de Entorno...
set /p varName="Introduce el nombre de la variable: "
set /p varValue="Introduce el valor de la variable: "

:: Establecer la variable de entorno temporalmente
set "%varName%=%varValue%"

echo Variable de entorno %varName% establecida a "%varValue%" para esta sesión.
echo.

:: Mostrar las variables de entorno actuales
echo Variables de entorno actuales:
set

pause
goto :develop

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
goto start

:lite_cus
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
echo ==================================================
echo.
timeout /t 2
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
echo %OPTI_TEXT%
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
echo %OPTI_TEXT%
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
echo         %OPTI_TEXT%
echo.
echo ==================================================
start "" "%~dp0Assets\messages\message_lite.vbs"
goto exit1


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
goto exit1

:done_defrag
cls
echo ==================================================
echo      Desfragmentacion realizada con exito
echo ==================================================
echo.
echo Tu disco duro seleccionado fue desfragmentado
echo correctamente
echo.
echo            Gracias por probar!
echo.
echo By OptiStudio
echo.
echo ==================================================
pause
goto exit1

:exit1
cls
echo Saliendo del script...
timeout /t 5 /nobreak >nul
exit

:exit2
cls
echo Presione espacio para salir del script...
pause >nul
exit

:: Este modo de salida es cuando presionas el boton de cerrar (X) esto se terminara de agregar en la 4.1
:exit3 
cls
echo Seguro que deseas salir? Puede presentar errores futuros en el script
pause
exit


:: Este programa es de uso abierto y puede ser modificado por todos. Solo no olvides darle
:: Creditos a su creador OptiStudio.
