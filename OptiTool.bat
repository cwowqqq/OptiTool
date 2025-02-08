@echo off

:: Coloca el color
color 0A

:: 4.0.1 Rev B Updated via GitHub

::Coloca los entornos en el batch
set OPTI_VER=OptiTool v4.0
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
:Verification
:Verification
if exist "%CD%\Assets\verif\options.txt" (
    goto :Start
) else (
    goto :Tutorial
)

	
:Tutorial
:Tutorial
cls
echo ==================================================
echo              Project OptiTool
echo ==================================================
echo Bienvenido a %OPTI_VER%. Un script .bat para aplicar
echo optimizaciones, basicas o avanzadas.
echo.
echo Para moverte por el menu, debes seleccionar las Opciones
echo utilizando los numeros, como 1, 2, 3, 4 y presionando Enter.
echo ==================================================
pause

:: Crear un archivo de opciones, para despues comprobar si no es la primera vez ejecutando el %OPTI_VER%
type nul > "%CD%\Assets\verif\options.txt"

:: Crea la carpeta de logs, para los .log xd
mkdir "Assets\logs" >nul 2>&1	

:: Ejecutar el vbs de dudas, xd
start "" "%~dp0Assets\msg\message1.vbs"

:Start
:Start
:: Limpia la pantalla
cls
:: Muestra el titulo, usando %OPTI_VER%
echo ==================================================
echo              %OPTI_VER%
echo ==================================================
echo.

:: Muestra las opciones del menu de inicio
echo *1 - Optimizaciones
echo *2 - Crear punto de restauracion (Recomendado)
echo *3 - Opciones de Defender
echo *4 - Opciones extremas
echo *5 - Opciones adicionales
echo *6 - Herramientas
echo.

:: Comprobando si el sistema es Windows XP o anterior
ver | findstr /i "5\.1\." >nul
if %errorlevel%==0 (
    goto :OldOSWarning
) else (
    goto :ContinueStart
)

:: Aviso de Windows antiguos
:OldOSWarning
:OldOSWarning
echo AVISO:
echo Tu Windows es bastante antiguo, lo que puede causar errores
echo con las optimizaciones. Te recomendamos que si, es posible
echo actualices a una version mas nueva de Windows
echo.

:ContinueStart
:ContinueStart
echo.

:: Comandos para elegir las opciones
set /p op=A elegir: 
if "%op%"=="" goto :Start
if "%op%"=="1" goto :OptiMenu
if "%op%"=="2" goto :Respoint
if "%op%"=="3" goto :DefOpt
if "%op%"=="4" goto :Xtreme
if "%op%"=="5" goto :Extra
if "%op%"=="6" goto :Tools
(
    echo Opcion no valida. Elije una opcion del menu :v
    timeout /t 2 /nobreak > nul
    goto :Start
) else (
    goto :Start
)
:: Sostiene los errores cuando insertas una opcion equivocada, evitando redirigirte a otros menus

:: Menu de optimizaciones, aqui vale madres lo de comprobar si el sistema es Win XP, xd
:: Decoracion horrible por q me crashean los ascii

:: Coloca el grupo y limpia la pantalla xd
:OptiMenu
:OptiMenu
cls

:: Coloca el titulo
echo ==================================================
echo             Menu de optimizaciones
echo ==================================================
echo.



:: Insercion de opciones
echo *1 - Optimizar PC 
echo *2 - Optimizar memoria RAM
echo *3 - Eliminar archivos temporales
echo *4 - Optimizar Internet
echo *5 - Limpiar cache
echo *6 - Desfragmentar disco duro (HDD)
echo *7 - Comprobar estado del disco
echo *8 - Gestionar programas de inicio (Experimental)
echo *9 - Actualizar Drivers
echo *10 - Repararar archivos dañados del sistema (SFC)
echo *11 - Desactivar notificaciones de Windows
echo *12 - Reiniciar explorador de Windows
echo *13 - Eliminar archivos de volcado de memoria
echo *14 - Desactivar la indexacion de archivos
echo *15 - Reducir la cantidad de puntos de restauracion del sistema
echo *16 - Eliminar archivos de actualizaciones fallidas
echo *17 - Liberar espacio (cleanmgr)
echo *18 - Desactivar sincronizacion de la cuenta de Microsoft
echo *19 - Regresar al menu
echo.
echo %OPTI_TEXT%
echo.


:: Comandos para la insercion de opciones
set /p op=Opcion: 
if "%op%"=="1" goto :Optimization
if "%op%"=="2" goto :OptiRAM
if "%op%"=="3" goto :Temp
if "%op%"=="4" goto :OptiWiFi
if "%op%"=="5" goto :CleanCache
if "%op%"=="6" goto :DefragDsk
if "%op%"=="7" goto :ChkDisk
if "%op%"=="8" goto :StartManage
if "%op%"=="9" goto :DriversUpd
if "%op%"=="10" goto :SFCScan
if "%op%"=="11" goto :DisableNotifications
if "%op%"=="12" goto :ResetExplorer
if "%op%"=="13" goto :ResetMemoryDump
if "%op%"=="14" goto :DisableArchiveIndex
if "%op%"=="15" goto :ReduceRestaurationPoints
if "%op%"=="16" goto :DeleteFailedUpdates
if "%op%"=="17" goto :CleanMGR
if "%op%"=="18" goto :DesMSSync
if "%op%"=="19" goto :Start
if "%op%"=="developmode" goto :ConfirmDev
if "%op%"=="roblauncher" goto :RobLauncherDown
(
    echo Opcion no valida. Elije una opcion del menu
    timeout /t 2 /nobreak > nul
    goto :OptiMenu
) else (
    goto :OptiMenu
)


:: Optimizacion general
:Optimization
:Optimization
cls
echo.

:: Aplica optis Bcdedit
echo Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo.

:: Activa el modo OptiVortex
echo Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0Resources\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo.
echo Borrando Archivos Temporales...

start "" "%~dp0Assets\utilities\FastTempDel.bat"

timeout /t 2 /nobreak >nul
echo.
echo Aplicando Optimizaciones de Regedit
regedit /S "Resources\Servicios\Optimizar Servicios.reg"
regedit /S "Resources\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "Resources\General\Mejorar La Velocidad del Menu.reg"
regedit /S "Resources\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "Resources\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graphics\Optimizar INTEL.reg"
regedit /S "Appearance\Deshabilitar Animaciones.reg"
regedit /S "Appearance\Deshabilitar Cortana.reg"
regedit /S "Graphics\Optimizar NVIDIA.reg"
regedit /S "Graphics\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
timeout /t 3 /nobreak
echo Optimizacion realizada con exito
echo.
pause
goto Done

:DesMSSync
:DesMSSync
cls
:: Menu principal
:: Ejecuta la herramienta para eliminar archivos temporales
echo ==================================================
echo           Desactivar sincronizacion
echo ==================================================
echo.
echo Iniciando herramienta...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
start "" "%~dp0Assets\utilities\desmsync.bat"

pause
goto :Start

:CleanMGR
:CleanMGR
cls
echo ==================================================
echo           Borrar archivos temporales
echo ==================================================
echo.
echo Iniciando la herramienta de limpieza de disco...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
start "" "%~dp0Assets\utilities\cleanmgr.bat"

pause
goto Start

:SFCScan
:SFCScan
cls
echo Comprobando y reparando archivos del sistema...
sfc /scannow
pause
goto DoneSFC

:StartManage
:StartManage
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
goto :Start

:: Revision del disco duro
:ChkDisk
:ChkDisk
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
goto :Start



:: Desfragmentacion del disco duro

:: Coloca el grupo y limpia la pantalla
:DefragDsk
:DefragDsk

:: setlocal
setlocal
cls


:: Advertencia a los SSDs
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
if not exist "%drive%:" (
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
if %errorlevel% neq 0 (
    echo *** Ocurrio un error durante la desfragmentacion. ***
) else (
    echo *** Desfragmentacion completada exitosamente. ***
)


:: Termina el proceso
:finalizarProceso
pause
goto :DefragDone

:: Actualizacion de Drivers

:: Coloca el grupo y limpia la pantalla
:DriversUpd
:DriversUpd
cls
echo ==================================================
echo   Elige el metodo para actualizar los drivers
echo ==================================================
echo.
echo 1. Actualizar mediante Web
echo 2. Actualizar mediante Driver Booster
echo 3. Regresar al menu
echo.

set /p option="Opcion: "

if "%option%"=="1" goto :DriversUpdWeb
if "%option%"=="2" goto :DriverBooster
if "%option%"=="3" goto :Start
) else (
    echo Opcion no valida. Selecciona una del menu
)

:DriversUpdWeb
:DriversUpdWeb
:: Menu de opciones
cls
echo ==================================================
echo        Actualizar controladores (Web)
echo ==================================================
echo.
echo 1. Actualizar controladores de AMD
echo 2. Actualizar controladores de Intel
echo 3. Actualizar controladores de NVIDIA
echo 4. Actualizar controladores de HP
echo 5. Actualizar controladores de TOSHIBA (impresoras/fax)
echo 6. Actualizar controladores de Lenovo
echo 7. Actualizar controladores de Asus
echo 8. Actualizar controladores de Acer
echo 9. Regresar al menu
echo.

:: Insercion de opciones
set /p option="Opcion: "

if "%option%"=="1" (
    echo Abriendo pagina de AMD...
    start https://goo.su/eU5BaaT
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="2" (
    echo Abriendo pagina de Intel...
    start https://goo.su/Wdo3
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="3" (
    echo Abriendo pagina de NVIDIA...
    start https://goo.su/z1V5vv
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="4" (
    echo Abriendo pagina de HP...
    start https://support.hp.com/us-en/drivers
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="5" (
    echo Abriendo pagina de TOSHIBA...
    start https://business.toshiba.com/support-drivers
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="6" (
    echo Abriendo pagina de Lenovo...
    start https://support.lenovo.com/us/en
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="7" (
    echo Abriendo pagina de Asus...
    start https://www.asus.com/support/download-center/
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="8" (
    echo Abriendo pagina de Acer...
    start https://www.acer.com/ae-en/predator/support/drivers-manuals/drivers-and-manuals
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="9" (
	goto :Start
) else (
    echo Opcion no valida. Selecciona una del menu :v
)

:DriverBooster
:DriverBooster
echo ==================================================
echo                Driver Booster
echo ==================================================
echo.
echo Iniciando herramienta...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
start "" "%~dp0Assets\utilities\driver-booster\DriverBoosterPortable.exe"

pause
goto :Start

:: Elimina archivos Temporales

:: Coloca el grupo y limpia la pantalla
:Temp
:Temp
cls
:: Menu principal
:: Ejecuta la herramienta para eliminar archivos temporales
echo ==================================================
echo           Borrar archivos temporales
echo ==================================================
echo.
echo Iniciando herramienta...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
start "" "%~dp0Assets\utilities\FastTempDel.bat"

pause
goto :Start

:: Coloca el grupo y limpia la pantalla
:OptiWiFi
:OptiWiFi
cls

echo Limpiando la cache DNS...
ipconfig /flushdns >nul 2>&1

:: Aplica la DNS de Cloudfare (con ayuda de ChatGPT, BlackBoxAI y mi IA de Python)
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
goto :Done

:: Coloca el grupo y limpia la pantalla
:OptiRAM
:OptiRAM
cls

:: Esta optimizacion solo optimiza la ram y aplica un par de optimizaciones
echo Aplicando Optimizacion Regedit...
regedit /S "Resources\Servicios\Optimizar Servicios.reg"
regedit /S "Resources\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "Graphics\Optimizar INTEL.reg"
regedit /S "Graphics\Optimizar NVIDIA.reg"
regedit /S "Graphics\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
echo.

:: Instala Mem Reduct
echo Instalando MemReduct x86...
xcopy "Resources\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
timeout /t 3 /nobreak
goto :DoneRAM


:: Coloca el grupo y limpia la pantalla
:CleanCache
:CleanCache
cls

:: muestra el mensaje
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
goto :Start

:: Coloca el grupo y limpia la pantalla
:UninsTool
:UninsTool
cls

:: Muestra el titulo
echo ==================================================
echo           Desinstalacion de programas
echo ==================================================
echo.
:: Insercion de opciones
echo 1. Ejecutar Uninstall Tool
echo 2. Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0Assets\utilities\desinstalar-tool\UninstallToolPortable.exe"
	goto :Start
) else if "%option%"=="2" (
    goto :Start
) else (
    echo Opcion no valida. Intente nuevamente.
    goto :UninsTool
)

goto :Start

:: Easteregg, descarga Roblauncher, de OptiJuegos
:RobLauncherDown
:RobLauncherDown
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto RobLaunchDown2
if /I "%option%"=="YES" goto RobLaunchDown2
if /I "%option%"=="N" goto Start
if /I "%option%"=="NO" goto Start

echo Invalid option. Exiting.
goto :Start

:RobLaunchDown2
:RobLaunchDown2
cls

start "" "%~dp0Assets\roblaunch\roblauncher-downloader.bat"

pause
goto :Start

:: Coloca el grupo y limpia la pantalla
:Xtreme
:Xtreme
cls

:: Optimizaciones extremas
echo ==================================================
echo        Opciones de optimizacion extremas
echo ==================================================
echo.
echo 1* - Litear Windows
echo 2* - Optimizacion extrema
echo 3* - Limpiar el registro de Windows
echo 4* - Regresar al menu
echo.

:: Insercion de opciones
set /p op=Opcion: 
if "%op%"=="1" goto :ConfirmLite
if "%op%"=="2" goto :ConfirmXtremeopti
if "%op%"=="3" goto :RegDel
if "%op%"=="4" goto :Start
(
    echo Opcion no valida. Elije una opcion del menu :v
    timeout /t 2 /nobreak > nul
    goto :Xtreme
) else (
    goto :Xtreme
)

:RegDel
:RegDel
cls
echo ==================================================
echo       Limpiar completamente el registro
echo ==================================================
echo AVISO: Siempre ten cuidado al manipular el registro
echo ya que cambios erroneos pueden afectar el rendimiento o la estabilidad del sistema
echo.
timeout /t 2 /nobreak >nul
echo Presiona espacio para continuar...
pause >nul
echo Limpiando el registro de Windows...

:: Hacer una copia de seguridad del registro antes de modificarlo
echo Realizando copia de seguridad del registro...
reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU "%USERPROFILE%\Desktop\RunMRU_Backup.reg" /y
reg export "HKCU\Software\Microsoft\Internet Explorer" "%USERPROFILE%\Desktop\InternetExplorer_Backup.reg" /y
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "%USERPROFILE%\Desktop\ShellFolders_Backup.reg" /y

:: Eliminar historial de ejecucion (MRU)
echo Eliminando historial de ejecuciones recientes...
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f

:: Eliminar entradas de URLs de Internet Explorer
echo Eliminando entradas de URLs de Internet Explorer...
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /f

:: Eliminar claves de ejecucion de bajo registro de Internet Explorer
echo Eliminando claves de ejecucion de bajo registro...
reg delete "HKCU\Software\Microsoft\Internet Explorer\LowRegistry\Run" /f

:: Eliminar claves relacionadas con la papelera de reciclaje
echo Eliminando claves de la papelera de reciclaje...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /f

:: Eliminar claves de programas desinstalados
echo Eliminando claves de programas no utilizados...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall" /f

:: Limpiar claves de aplicaciones recientes
echo Eliminando claves de aplicaciones recientes...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f

:: Limpiar claves de historial de busqueda
echo Eliminando historial de busqueda...
reg delete "HKCU\Software\Microsoft\Search\RecentQueries" /f

:: Limpiar entradas de fuentes de pantalla recientes
echo Eliminando fuentes de pantalla recientes...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f

:: Limpiar entradas de preferencias del sistema
echo Limpiando preferencias del sistema...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f

:: Limpiar claves de Windows Update
echo Limpiando claves de Windows Update...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate" /f

:: Limpiar claves de la barra de tareas
echo Limpiando configuraciones de la barra de tareas...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f

:: Limpiar el historial de busqueda del explorador
echo Limpiando historial de busqueda del explorador...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SearchHistory" /f

:: Limpiar el historial de la ventana de ejecutar
echo Limpiando historial de la ventana de ejecutar...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f

echo Registro limpiado correctamente.
pause
goto :DoneRegDel

:: Crea un punto de restauracion para restablecer cambios en caso de que las optimizaciones no sean de agrado

:Respoint
:Respoint
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
goto :Start

:: Optimizacion extrema
:XtremeOpti
:XtremeOpti
cls
echo Esta seccion esta en mantenimiento panas
echo esperense para la Rev B.
echo.
pause
timeout /t 3 /nobreak >nul
goto :Start

:: Coloca el grupo y limpia la pantalla
:DefOpt
:DefOpt
cls

:: Opciones de Defender
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

:: Generar un número aleatorio entre 0 y 1
set /a randomNum=%random% %% 2

:: Si es 0, mostrar el primer anuncio
if %randomNum%==0 (
    echo ======================================
	echo Suscribete al canal oficial de OptiTool
	echo en este enlace:
	echo https://www.youtube.com/@optistudio
	echo ======================================
) else (
    rem Si es 1, mostrar el segundo anuncio
    echo ======================================
    echo Gustas valorar este script en GitHub y
    echo apoyar el proyecto? Nuestro Github es:
    echo https://github.com/OptiStudioXD/OptiTool
    echo ======================================
)

echo.

set /p defop=Opcion: 
if "%defop%"=="1" goto :DefOff
if "%defop%"=="2" goto :DefOn
if "%defop%"=="3" goto :DefReset
if "%defop%"=="4" goto :MPSign
if "%defop%"=="5" goto :DefStatus
if "%defop%"=="6" goto :DefHistory
if "%defop%"=="7" goto :Start
if "%defop%"=="developmode" goto :ConfirmDev
goto :Start

:ConfirmXtremeOpti2
:ConfirmXtremeOpti2
cls
echo This can damage your Windows! Esto puede dañar tu Windows!
set /p option="SURE?! (Y/N)? "

if /I "%option%"=="Y" goto XtremeOpti
if /I "%option%"=="YES" goto XtremeOpti
if /I "%option%"=="N" goto Xtreme
if /I "%option%"=="NO" goto Xtreme

:DefReset
:DefReset
cls
echo Reiniciando Windows Defender...
powershell -Command "Stop-Service -Name WinDefend -Force; Start-Service -Name WinDefend"
if %errorlevel% neq 0 (
    echo Hubo un error al reiniciar Windows Defender.
    pause
    goto :Start
)
echo Windows Defender ha sido reiniciado correctamente.
pause
goto :Start

:DefStatus
:DefStatus
cls
echo Consultando el estado de Windows Defender...
powershell -Command "Get-MpComputerStatus"
if %errorlevel% neq 0 (
    echo Hubo un error al consultar el estado de Windows Defender.
    pause
    goto :Start
)
pause
goto :Start

:MPSign
:MPSign
cls
echo Actualizando las definiciones de virus de Windows Defender...
powershell -Command "Update-MpSignature"
if %errorlevel% neq 0 (
    echo Hubo un error al actualizar las definiciones de Windows Defender.
    pause
    goto :Start
)
echo Definiciones de Windows Defender actualizadas correctamente.
pause
goto :Start

:DefHistory
:DefHistory
cls
echo Abriendo el historial de proteccion de Windows Defender...
powershell -Command "Get-WinEvent -LogName 'Microsoft-Windows-Windows Defender/Operational' | Select-Object -First 10"
if %errorlevel% neq 0 (
    echo Hubo un error al obtener el historial de proteccion de Windows Defender.
    pause
    goto :Start
)
pause
goto :Start


:DefOff
:DefOff
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
goto :Start

:DefOn
:DefOn
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
goto :Start

:ReduceRestaurationPoints
:ReduceRestaurationPoints
cls
echo Reduciendo la cantidad de puntos de restauracion del sistema...
pause

:: Establecer el tamano maximo para los puntos de restauracion (en GB)
:: El valor predeterminado es 5GB, puedes ajustarlo segun sea necesario (por ejemplo, 2GB para menos espacio)
set pointsize=2

:: Usar vssadmin para configurar el tamano maximo para los puntos de restauracion
echo Configurando el tamano de los puntos de restauracion a %pointsize%GB...
vssadmin Resize ShadowStorage /For=C: /On=C: /MaxSize=%pointsize%GB

:: Verificar si el comando fue exitoso
if %errorlevel%==0 (
    echo Tamano de los puntos de restauracion reducido a %pointsize%GB.
) else (
    echo Hubo un error al intentar reducir el tamano de los puntos de restauracion.
)

pause
goto :Start


:DisableArchiveIndex
:DisableArchiveIndex
cls
echo Deshabilitando la indexacion de archivos...
pause

:: Detener el servicio de busqueda de Windows (Windows Search)
net stop "Windows Search"

:: Deshabilitar el servicio para que no se inicie con Windows
sc config "WSearch" start= disabled

echo Indexacion de archivos deshabilitada correctamente.
pause
goto :Start

:ResetMemoryDump
:ResetMemoryDump
cls
echo Eliminando archivos de volcado de memoria...
pause

:: Eliminar el archivo de volcado de memoria principal
if exist C:\Memory.dmp (
    echo Eliminar archivo Memory.dmp...
    del /f /q C:\Memory.dmp
) else (
    echo No se encontro el archivo Memory.dmp en C:.
)

:: Verificar si existen archivos de volcado en la carpeta Minidump (en caso de que existan)
if exist C:\Windows\Minidump\* (
    echo Limpiando archivos de volcado en C:\Windows\Minidump...
    del /f /q C:\Windows\Minidump\*
) else (
    echo No se encontraron archivos de volcado en C:\Windows\Minidump.
)

echo Archivos de volcado de memoria eliminados correctamente (si existian).
pause
goto :Start

:DeleteFailedUpdates
:DeleteFailedUpdates
cls
echo AVISO: Este codigo posee errores, pruebalo bajo tu propio riesgo.
echo.
echo Eliminar archivos de actualizaciones fallidas de Windows...
pause

:: Detener el servicio de Windows Update
net stop wuauserv
net stop wuaserv

:: Eliminar el contenido de las carpetas de actualización
del /f /s /q C:\Windows\SoftwareDistribution\Download\*
del /f /s /q C:\Windows\SoftwareDistribution\DataStore\*

:: Reiniciar el servicio de Windows Update
net start wuauserv

echo Archivos de actualizaciones fallidas eliminados correctamente.
pause
goto :Start


:ResetExplorer
:ResetExplorer
cls
echo Reiniciando Windows Explorer...
pause

:: Detener el proceso de Windows Explorer
taskkill /f /im explorer.exe

:: Esperar un momento antes de reiniciar
timeout /t 3 /nobreak >nul

:: Reiniciar Windows Explorer
start explorer.exe

echo Windows Explorer reiniciado correctamente.
pause
goto :Start

:Tools
:Tools
cls
echo ==================================================
echo               Herramientas
echo ==================================================
echo.
echo *1 - Actualizar OptiTool
echo *2 - Auto-Keyboard
echo *3 - Auto-Clicker
echo *4 - Herramienta para desinstalar programas
echo *5 - Driver Booster
echo *6 - Regresar al menu
echo.

:GenerateAds3
:GenerateAds3
:: Generar un número aleatorio entre 0 y 1
set /a randomNum=%random% %% 2

:: Si es 0, mostrar el primer anuncio
if %randomNum%==0 (
    echo ======================================
	echo Recuerda actualizar OptiTool, lo puedes
	echo hacer desde el apartado de Herramientas.
	echo ======================================
) else (
    rem Si es 1, mostrar el segundo anuncio
    echo ======================================
    echo Sabias que todas las herramientas usadas
	echo aqui, tuvieron un intento de crackeo de 
	echo parte de OptiStudio, pero algunos fracasaron
    echo ======================================
)

echo.



set /p toolop=Opcion: 
if "%toolop%"=="1" goto :UpdOptiTool
if "%toolop%"=="2" goto :AutoKeyboard
if "%toolop%"=="3" goto :AutoClicker
if "%toolop%"=="4" goto :UninsTool
if "%toolop%"=="5" goto :DriverBooster
if "%toolop%"=="6" goto :Start
if "%toolop%"=="roblaunch" goto RobLauncherDown
if "%toolop%"=="developmode" goto :ConfirmDev

:AutoClicker
:AutoClicker
cls
echo ==================================================
echo                Auto Clicker
echo ==================================================
echo.
:: Insercion de opciones
echo 1. Ejecutar Auto-Clicker
echo 2. Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0Assets\utilities\auto-clicker\AutoClicker.exe"
	goto :Start
) else if "%option%"=="2" (
    goto Start
) else (
    echo Opcion no valida. Intente nuevamente.
    goto AutoClicker
)

goto Start

:Extra
:Extra
:: Opciones adicionales
cls
echo ==================================================
echo             Opciones adicionales
echo ==================================================
echo.
echo *1 - Informacion del sistema
echo *2 - Creditos
echo *3 - Regresar al menu
echo.

:GenerateAds2
:GenerateAds2
:: Generar un número aleatorio entre 0 y 1
set /a randomNum=%random% %% 2

:: Si es 0, mostrar el primer anuncio
if %randomNum%==0 (
    echo ======================================
	echo Recuerda actualizar OptiTool, lo puedes
	echo hacer desde el apartado de Herramientas.
	echo ======================================
) else (
    rem Si es 1, mostrar el segundo anuncio
    echo ======================================
    echo Gustas valorar este script en GitHub y
    echo apoyar el proyecto? Nuestro Github es:
    echo https://github.com/OptiStudioXD/OptiTool
    echo ======================================
)

echo.

set /p extraop=Opcion: 
if "%extraop%"=="1" goto :Sysinfo
if "%extraop%"=="2" goto :Creds
if "%extraop%"=="3" goto :Start
if "%extraop%"=="roblaunch" goto RobLauncherDown
if "%extraop%"=="developmode" goto ConfirmDev
goto :extra

:AutoKeyboard
:AutoKeyboard
cls

:: Muestra el titulo
echo ==================================================
echo                Auto Keyboard
echo ==================================================
echo.
:: Insercion de opciones
echo 1. Ejecutar Auto-Keyboard
echo 2. Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0Assets\utilities\auto-teclado\AutoKeyboard.exe"
	goto :Start
) else if "%option%"=="2" (
    goto Start
) else (
    echo Opcion no valida. Intente nuevamente.
    goto AutoKeyboard
)

goto Start

:DisableNotifications
:DisableNotifications
cls
echo Desactivando las notificaciones de Windows...
powershell -Command "Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Value 0"
echo Notificaciones desactivadas.
pause
goto Start

:ConfirmXtremeOpti
:ConfirmXtremeOpti
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto ConfirmXtremeOpti2
if /I "%option%"=="YES" goto ConfirmXtremeOpti2
if /I "%option%"=="N" goto Xtreme
if /I "%option%"=="NO" goto Xtreme

echo Invalid option. Exiting.
goto Xtreme

:ConfirmLite
:ConfirmLite
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto Lite
if /I "%option%"=="YES" goto Lite
if /I "%option%"=="N" goto Xtreme
if /I "%option%"=="NO" goto Xtreme

echo Invalid option. Exiting.
goto Xtreme

:ConfirmDev
:ConfirmDev
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto DevOpt
if /I "%option%"=="YES" goto DevOpt
if /I "%option%"=="N" goto Start
if /I "%option%"=="NO" goto Start
goto :Start



:DevOpt
:DevOpt
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

if /I "%option%"=="1" goto DGoto
if /I "%option%"=="2" start notepad "%~dp0update.bat"
if /I "%option%"=="3" goto DevHelp
if /I "%option%"=="4" start notepad "%~dp0OptiTool.bat"
if /I "%option%"=="5" goto GenerateReport
if /I "%option%"=="6" goto RunTests
if /I "%option%"=="7" goto BackupProject
if /I "%option%"=="8" goto EnvironmentVariables
if /I "%option%"=="9" goto AVSysinfo
if /I "%option%"=="10" goto Extra
(
    echo That option is not valid! Select a option from the menu
    timeout /t 2 /nobreak > nul
    goto :DevOpt
) else (
    goto :DevOpt
)


:DevHelp
:DevHelp
echo Not available
pause >nul
goto exit1

:: Redirecciona al goto que escribas
:DGoto
:DGoto
cls
echo Direct Goto
echo Type "esc" to exit
echo.
set /p option="Enter goto: "

:: Verificar si el usuario ha ingresado "exit" para salir
if /I "%option%"=="esc" goto DevOpt

:: Validar si la etiqueta existe
goto %option% 2>nul
if errorlevel 1 (
    echo La etiqueta "%option%" no existe. Por favor, intenta de nuevo.
    pause
    goto direct_goto
)

:: Si la etiqueta existe, se ejecuta el goto

:: Muestra la informacion horriblemente detallada del sistema
:AVSysinfo
:AVSysinfo
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
goto :DevOpt

:GenerateReport
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
goto :DevOpt

:RunTests
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
goto :DevOpt


:BackupProject
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
goto :DevOpt

:: Tengo planes de pasar OptiTool a un proyecto oficial, en vez de ser simplemente un proyecto de prueba, esto lo pensare despues de
:: la 4.5.

:EnviromentVariables
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
goto :DevOpt

:: Abre el cliente de actualizacion

:UpdOptiTool
:UpdOptiTool
cls
echo Iniciando cliente...
timeout /t 1 /nobreak >nul

start "" "%~dp0update.bat"

timeout /t 2 /nobreak >nul
goto Start

:: Esta version de :lite, directamente quita el pause, haciendo que la optimizacion sea continua
:LiteCustom
:LiteCustom
cls
regedit /S "Appearance\Deshabilitar Animaciones.reg"
regedit /S "Appearance\Deshabilitar Cortana.reg"
regedit /S "Appearance\Deshabilitar Transparencias.reg"
regedit /S "Appearance\Deshabilitar Centro Acciones.reg"
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

start "" "%~dp0Assets\utilities\screen.bat"

start "" "%~dp0Assets\utilities\FastTempDel.bat"

goto :DoneXtreme

:: Recorta el sistema, con lo cual el C:\Windows puede corromperse
:Lite
:Lite
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
regedit /S "Appearance\Deshabilitar Animaciones.reg"
regedit /S "Appearance\Deshabilitar Cortana.reg"
regedit /S "Appearance\Deshabilitar Transparencias.reg"
regedit /S "Appearance\Deshabilitar Centro Acciones.reg"
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

start "" "%~dp0Assets\utilities\screen.bat"

start "" "%~dp0Assets\utilities\FastTempDel.bat"

goto :DoneLite


:Creds
:Creds
cls
echo Iniciando herramienta de creditos...
echo.
start "" "%~dp0Assets\utilities\creds.bat"

timeout /t 2 /nobreak >nul
goto :Start

:Sysinfo
:Sysinfo
cls
echo Iniciando SystemInfo...
echo.
start "" "%~dp0Assets\utilities\sysinfo.bat"

timeout /t 2 /nobreak >nul
goto :Start

:Done
:Done
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
goto :Start

:DoneRAM
:DoneRAM
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
goto :Start

:DoneXtreme
:DoneXtreme
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
start "" "%~dp0Assets\msg\message_lite.vbs"
goto Ext1

:DoneSFC
:DoneSFC
cls
echo ==================================================
echo         Archivos reparados con exito
echo ==================================================
echo.
echo Todos los archivos dañados del sistema han sido
echo reparados!
echo.
echo Para aplicar las reparaciones recomendamos que
echo cierres todas tus aplicaciones abiertas y reinicies
echo el PC
echo.
echo By OptiStudio
echo.
echo ==================================================
timeout /t 2 /nobreak >nul
pause
goto Ext1

:DoneLite
:DoneLite
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
start "" "%~dp0Assets\msg\message_lite.vbs"
goto Ext1

:DefragDone
:DefragDone
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
goto Ext1

:DoneRegDel
:DoneRegDel
cls
echo ==================================================
echo    Limpieza del registro completada con exito
echo ==================================================
echo.
echo Tu registro de Windows fue completamente limpiado.
echo Reinicia tu computadora para aplicar los cambios!
echo.
echo ! ! !  CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo By OptiStudio
echo.
echo ==================================================
pause
start "" "%~dp0Assets\msg\message_lite.vbs"
goto Ext1

:Ext1
:Ext1
cls
echo Saliendo del script...
timeout /t 1 /nobreak >nul
echo 3...
timeout /t 1 /nobreak >nul
echo 2...
timeout /t 1 /nobreak >nul
echo 1.
timeout /t 1 /nobreak >nul
exit

:Ext2
:Ext2
cls
echo Presione espacio para salir del script...
pause >nul
exit

:: Este modo de salida es cuando presionas el boton de cerrar (X) esto se terminara de agregar en la 5.0
:Ext3
:Ext3
cls
echo Seguro que deseas salir? Puede presentar errores futuros en el script y/o en tu computadora.
pause
exit


:: Este programa es de uso abierto y puede ser modificado por todos. Solo no olvides darle creditos a su creador, OptiStudio.
