@echo off
title overlay
color 0A

set "logDir=%~dp0sysinfo_files"
set "logFile=%logDir%\ComputerSpecs.txt"

:: Crear la carpeta "logs" si no existe
if not exist "%logDir%" (
    mkdir "%logDir%"
)

:menu
cls
echo ================================
echo        Menu Principal
echo ================================
echo 1. Mostrar Informacion del Sistema
echo 2. Guardar Informacion en un Archivo
echo 3. Ayuda
echo 4. Salir
echo.
set /p choice="Selecciona una opcion (1-4): "

rem Validacion de entrada
if "%choice%"=="1" goto info
if "%choice%"=="2" goto save
if "%choice%"=="3" goto help
if "%choice%"=="4" exit

echo Opcion no valida. Intenta de nuevo.
pause
goto menu

:info
cls
echo ================================
echo     Informacion del Sistema
echo ================================
echo.
:: Muestra la informacion general del sistema
echo Informacion General:
systeminfo
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

:: Mostrar variables de entorno
echo Variables de Entorno:
set
echo.
echo.
echo Version de Sysinfo: v7.0 Rev A
echo.
echo Presiona cualquier tecla para volver al menu...
pause >nul
goto menu

:save
cls
echo ================================
echo     Guardar Informacion del Sistema
echo ================================
echo.
echo Guardando la informacion en "%logFile%"...
systeminfo > "%logFile%"
if errorlevel 1 (
    echo Error al guardar la informacion. Verifica permisos.
) else (
    echo Informacion guardada con exito.
    echo Puedes revisar el archivo en la carpeta "logs".
)
echo.
pause
goto menu

:help
cls
echo ================================
echo             Ayuda
echo ================================
echo Este script proporciona opciones para mostrar y guardar
echo la informacion del sistema en tu computadora.
echo.
echo 1. Mostrar Informacion del Sistema: Muestra los detalles
echo    del sistema directamente en la consola.
echo 2. Guardar Informacion en un Archivo: Guarda la informacion basica
echo    del sistema en un archivo de texto llamado "ComputerSpecs.txt" en
echo    la carpeta de "sysinfo_files"
echo 3. Ayuda: Muestra esta ayuda.
echo 4. Salir: Cierra el script.
echo.
echo Presiona cualquier tecla para volver al menu...
pause >nul
goto menu
