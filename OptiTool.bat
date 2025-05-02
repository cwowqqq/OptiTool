@echo off

:: VERSION UPDATED IN GITHUB, SOME THINGS CAN FAIL
:: Developed in .cmd
:: Sera dificil sera transladar esto a Linux

:: Coloca el setlocal
setlocal enabledelayedexpansion


:: Ejecutar el vbs de dudas, xd
start "" "%~dp0scassets\msg\message1.vbs"

:: Informacion del sistema xd
:: CPU
for /f "tokens=*" %%a in ('wmic cpu get name') do set "CPUtostada=%%a"

:: RAM
for /f "tokens=*" %%a in ('wmic os get totalvisiblememorysize') do set "RAMemory=%%a"

:: Version de WINDOWS
for /f "tokens=*" %%a in ('ver') do set "WinVersion=%%a"

:: Arquitectura
for /f "tokens=*" %%a in ('wmic os get osarchitecture') do set "Arquitectura=%%a"

:: Version de .NET Framework
for /f "tokens=*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Version') do set "DotNetVersion=%%a" 

::Coloca los entornos en el batch
set OPTI_VER=OptiTool v4.1
set OPTI_TEXT=OptiTool - Script de optimizacion
set WGET="%~dp0wget.exe"
set FFPLAY="%~dp0ffplay.exe"

:: Obtener la fecha y hora actual
for /f "tokens=2 delims==" %%I in ('"wmic OS Get localdatetime /value"') do set datetime=%%I
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set hour=%datetime:~8,2%
set minute=%datetime:~10,2%
set second=%datetime:~12,2%

:: Crear variable con la fecha y hora en formato yyyy-mm-dd_hh-mm-ss
set datetime_log=%year%-%month%-%day%_%hour%-%minute%-%second%

:: Definir el archivo de log
set "logFile=%~dp0scassets\logs\startlog-%datetime_log%.log"

:: Registrar el log de éxito
echo ## Launched via launcher at [%datetime_log%] >> "%logFile%"
echo ## Script request start at [%datetime_log%] >> "%logFile%"
echo ## Session started at [%datetime_log%] >> "%logFile%"
echo ## OptiTool v4.1 [%datetime_log%] >> "%logFile%"

::REINICIA EL SCRIPT >:3
:ResetScript
:: BatchGotAdmin
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0" 


:: Coloca la version como titulo
title %OPTI_VER%

:: Coloca el color
color 0A

:: Mensaje de inicio
set /a randomNum=%random% %% 2

:: Si es 0, mostrar el primer anuncio
if %randomNum%==0 (
	echo decoren optitool
) else (
    rem Si es 1, mostrar el segundo anuncio
    echo NEXUS LAUNCHER PROXIMAMENTE JIJUELAVER-
)

echo.
timeout /t 1 /nobreak>nul
	
:: Verifica si existe el archivo de start, si existe vamonos a :start, si no existe muestra el tutorial

:Verification
:Verification
if exist "%~dp0scassets\startManage\start.txt" (
    goto :Start
) else (
    goto :InitialConfig
)

	
:InitialConfig
:InitialConfig
cls
echo ==================================================
echo              Project: OptiTool
echo ==================================================
echo Bienvenido a %OPTI_VER%. Un script .cmd sencillo y 
echo facil para aplicar optimizaciones basicas, o complejas.
echo.
echo Para moverte por el menu, debes seleccionar las Opciones
echo utilizando los numeros, como 1, 2, 3, 4 y presionando Enter.
echo.
echo Recomiendo crear un punto de restauracion antes de
echo ejecutar este script. 
echo ==================================================
timeout /t 3 /nobreak>nul
pause

:: Crear el archivo de la informacion de la build
echo ## Downloaded version: 4.1 >> "%~dp0scassets\info\build_info.log"
echo. >> "%~dp0scassets\info\build_info.log"
echo ## OptiCore Info: >> "%~dp0scassets\info\build_info.log"
echo ## OptiBuild: nan >> "%~dp0scassets\info\build_info.log"
echo ## OptiCore Version: nan >> "%~dp0scassets\info\build_info.log"
echo ## OptiKernel Version: nan >> "%~dp0scassets\info\build_info.log"
echo. >> "%~dp0scassets\info\build_info.log"
echo ## Build Info:  >> "%~dp0scassets\info\build_info.log"
echo ## Build 4.11100100.5000 >> "%~dp0scassets\info\build_info.log"
echo ## Version: 4.1 Rev A.1 >> "%~dp0scassets\info\build_info.log"
echo ## Version Codename: Sandstorm >> "%~dp0scassets\info\build_info.log"
echo ## Developed in .cmd >> "%~dp0scassets\info\build_info.log"
echo ## Kernel: nan >> "%~dp0scassets\info\build_info.log"
echo. >> "%~dp0scassets\info\build_info.log"
echo ## Linux Info: >> "%~dp0scassets\info\build_info.log"
echo ## Linux Compatibility: N/A >> "%~dp0scassets\info\build_info.log"
echo ## Linux Build: N/A>> "%~dp0scassets\info\build_info.log"

:: Crear un archivo de start, para despues comprobar si no es la primera vez ejecutando el script
echo ## Start verified at [%datetime_log%] >> "%~dp0scassets\startManage\start.txt"

echo. >> "%~dp0scassets\startManage\start.txt"

echo ## %datetime_log% >> "%~dp0scassets\startManage\start.txt"
echo ## %WinVersion% / %DotNetVersion% >> "%~dp0scassets\startManage\start.txt"
echo ## OptiTool v4.1 >> "%~dp0scassets\startManage\start.txt"

echo. >> "%~dp0scassets\startManage\start.txt"

echo ## User: %USERNAME% >> "%~dp0scassets\startManage\start.txt"
echo ## User Domain: %USERDOMAIN% >> "%~dp0scassets\startManage\start.txt"

systeminfo >> "%~dp0scassets\startManage\start.txt"

echo. >> "%~dp0scassets\startManage\start.txt"
echo ## Installed on ">dir\%~dp0" >> "%~dp0scassets\startManage\start.txt"
:: Crea la carpeta de logs, para los .log xd
mkdir "scassets\logs" >nul 2>&1	

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
echo *1 - Realizar optimizacion recomendada
echo *2 - Puntos de restauracion
echo *3 - Menu de optimizaciones
echo *4 - Optimizaciones extremas
echo *5 - Opciones de Defender
echo *6 - Opciones adicionales
echo *7 - Herramientas
echo.

:: Comprobando si el sistema es Windows XP o anterior
ver | findstr /i "5\.1\." >nul
if %errorlevel%==0 (
    call :OldOSWarning
) else (
    call :ContinueStart
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
set /p op=Opcion: 
if "%op%"=="" goto :Start
if "%op%"=="1" goto :DefaultOpti
if "%op%"=="2" goto :Respoint
if "%op%"=="3" goto :OptiMenu
if "%op%"=="4" goto :Xtreme
if "%op%"=="5" goto :DefOpt
if "%op%"=="6" goto :Extra
if "%op%"=="7" goto :Tools
if "%op%"=="reset" goto :ResetScript
if "%op%"=="Devmode--Yes" goto :ConfirmDev
if "%op%"=="Secrets--Konami" goto :Music
if "%op%"=="Secrets--AlphaMode" goto :AlphaEasterEgg
if "%op%"=="Secrets--RobLauncher" goto :RobLaunchDown2
goto :Start

::Coloca el grupo y limpia la pantalla
:DefaultOpti
:DefaultOpti
cls
echo Pulsa una tecla para continuar con la optimizacion...
pause>nul
echo.
set /p option="Deseas crear un punto de restauracion antes de iniciar? (Y/N)? "

if /I "%option%"=="" goto :DefaultOpti
if /I "%option%"=="Y" goto :BeforeOptiRespoint
if /I "%option%"=="YES" goto :BeforeOptiRespoint
if /I "%option%"=="N" goto :DefaultOpti2
if /I "%option%"=="NO" goto :DefaultOpti2
goto :DefaultOpti

:BeforeOptiRespoint
:BeforeOptiRespoint
echo - Creando punto de restauracion...
echo.
timeout /t 1 /nobreak >nul

:: Intentar crear el punto de restauracion y manejar errores
"powershell.exe" Enable-ComputerRestore -Drive "%SystemDrive%"
"powershell.exe" -Command "try { Checkpoint-Computer -Description 'Antes Optimizacion' -ErrorAction Stop } catch { Write-Host 'Error al crear el punto de restauracion: $_' }"

timeout /t 2 /nobreak>nul
goto :DefaultOpti2


:DefaultOpti2
:DefaultOpti2
set /p option="Deseas configurar correctamente Windows junto con la optimizacion? (Y/N)? "

if /I "%option%"=="" goto :DefaultOpti2
if /I "%option%"=="Y" goto :DefaultOptiConfig
if /I "%option%"=="YES" goto :DefaultOptiConfig
if /I "%option%"=="N" goto :DefaultOpti3
if /I "%option%"=="NO" goto :DefaultOpti3
goto :DefaultOpti2

:DefaultOptiConfig
:DefaultOptiConfig
cls
echo - Colocando modo oscuro...
regedit /S "resources\General\Mejorar La Velocidad del Menu.reg"
regedit /S "appearance\Modo Oscuro.reg"
echo Hecho :D

echo.
echo - Configurando menus...
regedit /S "appearance\Deshabilitar Transparencias.reg"
regedit /S "appearance\Deshabilitar Cortana.reg"
echo Hecho :D

echo.
echo - Instalando WinRAR...
:: Instala WinRAR
xcopy "scassets\utilities\winRAR" "%SystemDrive%\Program Files\winRAR" /S /Y
start /min "" "%SystemDrive%\Program Files\winRAR\WinRAR.exe"
echo Hecho :D
echo.

echo - Instalando MemReduct...
:: Instala Mem Reduct
echo - Instalando MemReduct x86...
xcopy "resources\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
echo Hecho!
echo.

echo - Reduciendo procesos svchost...
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set MEM=%%i
set /a RAM=%MEM% + 1024000
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%RAM%" /f
echo Hecho!

echo.
echo - Deshabilitando Wifi Sense...
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowWiFiHotSpotReporting /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowAutoConnectToWiFiSenseHotspots /t REG_DWORD /d 0 /f
echo Hecho!

echo.
echo - Deshabilitando tareas de WinUpd...
schtasks /Change /TN "\Microsoft\Windows\InstallService\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\UpdateAssistant\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\WaaSMedic\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\*" /Disable
schtasks /Change /TN "\Microsoft\WindowsUpdate\*" /Disable																																																																																																											REM ;youtube.com/@OptiProjects
echo Hecho!

echo.
echo - Optimizando el apartado visual...
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v KeyboardDelay /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewShadow /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKCU\Control Panel\Desktop" /v EnableAeroPeek /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
echo Hecho!

echo.
echo - Desactivando Teredo...
netsh interface teredo set state disabled
timeout /t 1 /nobreak>nul
echo Hecho!

echo.
echo - Deshabilitando la telemetria en tareas...
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
echo Hecho!

echo.
echo - Deshabilitando la telemetria en el registro...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
echo Hecho!

echo.
echo - Aplicando optimizaciones bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
powercfg -h off >nul 2>&1
echo Hecho!

echo.
echo - Configurando correctamente el registro...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxThreads" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCollectionCount" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f																																																REM ;youtube.com/@OptiProjects
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d "400" /f
timeout /t 1 /nobreak >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
echo Hecho!
echo.

echo - Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0resources\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo Hecho!

echo.
echo - Colocando servicios en modo "manual"
sc config "AJRouter" start= demand
sc config "ALG" start= demand
sc config "AppIDSvc" start= demand
sc config "AppMgmt" start= demand
sc config "AppReadiness" start= demand
sc config "AppXSvc" start= demand
sc config "Appinfo" start= demand
sc config "AssignedAccessManagerSvc" start= demand
sc config "AxInstSV" start= demand
sc config "BDESVC" start= demand
sc config "BTAGService" start= demand
sc config "BcastDVRUserService_*" start= demand
sc config "BluetoothUserService_*" start= demand
sc config "Browser" start= demand
sc config "CaptureService_*" start= demand
sc config "CertPropSvc" start= demand
sc config "ClipSVC" start= demand
sc config "ConsentUxUserSvc_*" start= demand
sc config "CredentialEnrollmentManagerUserSvc_*" start= demand
sc config "CscService" start= demand
sc config "DcpSvc" start= demand
sc config "DevQueryBroker" start= demand
sc config "DeviceAssociationBrokerSvc_*" start= demand
sc config "DeviceAssociationService" start= demand
sc config "DeviceInstall" start= demand
sc config "DevicePickerUserSvc_*" start= demand
sc config "DevicesFlowUserSvc_*" start= demand
sc config "DisplayEnhancementService" start= demand
sc config "DmEnrollmentSvc" start= demand
sc config "DsSvc" start= demand
sc config "DsmSvc" start= demand
sc config "EFS" start= demand
sc config "EapHost" start= demand
sc config "EntAppSvc" start= demand
sc config "FDResPub" start= demand
sc config "Fax" start= demand
sc config "FrameServer" start= demand
sc config "FrameServerMonitor" start= demand
sc config "GraphicsPerfSvc" start= demand
sc config "HomeGroupListener" start= demand
sc config "HomeGroupProvider" start= demand
sc config "HvHost" start= demand
sc config "IEEtwCollectorService" start= demand
sc config "IKEEXT" start= demand
sc config "InstallService" start= demand
sc config "InventorySvc" start= demand
sc config "IpxlatCfgSvc" start= demand
sc config "KtmRm" start= demand
sc config "LicenseManager" start= demand
sc config "LxpSvc" start= demand
sc config "MSDTC" start= demand
sc config "MSiSCSI" start= demand
sc config "McpManagementService" start= demand
sc config "MessagingService_*" start= demand
sc config "MicrosoftEdgeElevationService" start= demand
sc config "MixedRealityOpenXRSvc" start= demand
sc config "NPSMSvc_*" start= demand
sc config "NaturalAuthentication" start= demand
sc config "NcaSvc" start= demand
sc config "NcbService" start= demand
sc config "NcdAutoSetup" start= demand
sc config "NetSetupSvc" start= demand
sc config "Netman" start= demand
sc config "NgcCtnrSvc" start= demand
sc config "NgcSvc" start= demand
sc config "NlaSvc" start= demand
sc config "P9RdrService_*" start= demand
sc config "PNRPAutoReg" start= demand
sc config "PNRPsvc" start= demand
sc config "PeerDistSvc" start= demand
sc config "PenService_*" start= demand
sc config "PerfHost" start= demand
sc config "PhoneSvc" start= demand
sc config "PimIndexMaintenanceSvc_*" start= demand
sc config "PlugPlay" start= demand
sc config "PolicyAgent" start= demand
sc config "PrintNotify" start= demand
sc config "PrintWorkflowUserSvc_*" start= demand
sc config "PushToInstall" start= demand
sc config "QWAVE" start= demand
sc config "RasAuto" start= demand
sc config "RasMan" start= demand
sc config "RetailDemo" start= demand
sc config "RmSvc" start= demand
sc config "RpcLocator" start= demand
sc config "SCPolicySvc" start= demand
sc config "SCardSvr" start= demand
sc config "SDRSVC" start= demand
sc config "SEMgrSvc" start= demand
sc config "SNMPTRAP" start= demand
sc config "SNMPTrap" start= demand
sc config "SSDPSRV" start= demand
sc config "ScDeviceEnum" start= demand
sc config "SecurityHealthService" start= demand
sc config "Sense" start= demand
sc config "SensorDataService" start= demand
sc config "SensorService" start= demand
sc config "SensrSvc" start= demand
sc config "SessionEnv" start= demand
sc config "SharedAccess" start= demand
sc config "SharedRealitySvc" start= demand
sc config "SmsRouter" start= demand
sc config "SstpSvc" start= demand
sc config "StiSvc" start= demand
sc config "TabletInputService" start= demand
sc config "TapiSrv" start= demand
sc config "TieringEngineService" start= demand
sc config "TimeBroker" start= demand
sc config "TimeBrokerSvc" start= demand
sc config "TokenBroker" start= demand
sc config "TroubleshootingSvc" start= demand
sc config "TrustedInstaller" start= demand
sc config "UI0Detect" start= demand
sc config "UdkUserSvc_*" start= demand
sc config "UmRdpService" start= demand
sc config "UnistoreSvc_*" start= demand
sc config "UserDataSvc_*" start= demand
sc config "VSS" start= demand
sc config "VacSvc" start= demand
sc config "W32Time" start= demand
sc config "WEPHOSTSVC" start= demand
sc config "WFDSConMgrSvc" start= demand
sc config "WMPNetworkSvc" start= demand
sc config "WManSvc" start= demand
sc config "WPDBusEnum" start= demand
sc config "WSService" start= demand
sc config "WaaSMedicSvc" start= demand
sc config "WalletService" start= demand
sc config "WarpJITSvc" start= demand
sc config "WbioSrvc" start= demand
sc config "WcsPlugInService" start= demand
sc config "WdNisSvc" start= demand
sc config "WdiServiceHost" start= demand
sc config "WdiSystemHost" start= demand
sc config "WebClient" start= demand
sc config "Wecsvc" start= demand
sc config "WerSvc" start= demand
sc config "WiaRpc" start= demand
sc config "WinHttpAutoProxySvc" start= demand
sc config "WinRM" start= demand
sc config "WpcMonSvc" start= demand
sc config "XblAuthManager" start= demand
sc config "XblGameSave" start= demand
sc config "XboxGipSvc" start= demand
sc config "XboxNetApiSvc" start= demand
sc config "autotimesvc" start= demand
sc config "bthserv" start= demand
sc config "camsvc" start= demand
sc config "cloudidsvc" start= demand
sc config "dcsvc" start= demand
sc config "defragsvc" start= demand
sc config "diagnosticshub.standardcollector.service" start= demand
sc config "diagsvc" start= demand
sc config "dmwappushservice" start= demand
sc config "dot3svc" start= demand
sc config "edgeupdate" start= demand
sc config "edgeupdatem" start= demand
sc config "embeddedmode" start= demand
sc config "fdPHost" start= demand
sc config "fhsvc" start= demand
sc config "hidserv" start= demand
sc config "icssvc" start= demand
sc config "lfsvc" start= demand
sc config "lltdsvc" start= demand
sc config "lmhosts" start= demand
sc config "msiserver" start= demand
sc config "netprofm" start= demand
sc config "p2pimsvc" start= demand
sc config "p2psvc" start= demand
sc config "perceptionsimulation" start= demand
sc config "pla" start= demand
sc config "seclogon" start= demand
sc config "smphost" start= demand
sc config "spectrum" start= demand
sc config "svsvc" start= demand
sc config "swprv" start= demand
sc config "upnphost" start= demand
sc config "vds" start= demand
sc config "vmicguestinterface" start= demand
sc config "vmicheartbeat" start= demand
sc config "vmickvpexchange" start= demand
sc config "vmicrdv" start= demand
sc config "vmicshutdown" start= demand
sc config "vmictimesync" start= demand
sc config "vmicvmsession" start= demand
sc config "vmicvss" start= demand
sc config "vmvss" start= demand
sc config "wbengine" start= demand
sc config "wcncsvc" start= demand
sc config "webthreatdefsvc" start= demand
sc config "wercplsupport" start= demand
sc config "wisvc" start= demand
sc config "wlidsvc" start= demand
sc config "wlpasvc" start= demand
sc config "wmiApSrv" start= demand
sc config "workfolderssvc" start= demand
sc config "wuauserv" start= demand
sc config "wudfsvc" start= demand
echo Hecho!

echo.
echo - Deshabilitando servicios innecesarios...
sc config "diagnosticshub.standardcollector.service" start= disabled
sc config "DiagTrack" start= disabled
sc config "DPS" start= disabled
sc config "FontCache" start= disabled
sc config "SystemUsageReportSvc_QUEENCREEK" start= disabled
sc config "GpuEnergyDrv" start= disabled
sc config "PcaSvc" start= disabled
sc config "ShellHWDetection" start= disabled
sc config "SgrmAgent" start= disabled
sc config "SgrmBroker" start= disabled
sc config "uhssvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "WSearch" start= disabled
sc config "diagsvc" start= disabled
echo Hecho!


echo.
echo - Aplicando la optimizacion general en Regedit...
regedit /S "resources\General\Optimizacion General.reg"
regedit /S "resources\General\Mejorar La Velocidad del Menu.reg"
echo Hecho!
timeout /t 2 /nobreak>nul
echo.

echo Optimizacion recomendada aplicada correctamente!
pause >nul
goto :Done


:DefaultOpti3
:DefaultOpti3
cls
echo - Reduciendo procesos svchost...
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set MEM=%%i
set /a RAM=%MEM% + 1024000
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%RAM%" /f
echo Hecho!

echo.
echo - Deshabilitando Wifi Sense...
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowWiFiHotSpotReporting /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowAutoConnectToWiFiSenseHotspots /t REG_DWORD /d 0 /f
echo Hecho!

echo.
echo - Deshabilitando tareas de WinUpd...
schtasks /Change /TN "\Microsoft\Windows\InstallService\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\UpdateAssistant\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\WaaSMedic\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\*" /Disable
schtasks /Change /TN "\Microsoft\WindowsUpdate\*" /Disable																																																																																																											REM ;youtube.com/@OptiProjects
echo Hecho!

echo.
echo - Optimizando el apartado visual...
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v KeyboardDelay /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewShadow /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKCU\Control Panel\Desktop" /v EnableAeroPeek /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
echo Hecho!

echo.
echo - Desactivando Teredo...
netsh interface teredo set state disabled
timeout /t 1 /nobreak>nul
echo Hecho!

echo.
echo - Deshabilitando la telemetria en tareas...
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
echo Hecho!

echo.
echo - Deshabilitando la telemetria en el registro...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
echo Hecho!

echo.
echo - Aplicando optimizaciones bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
powercfg -h off >nul 2>&1
echo Hecho!

echo.
echo - Configurando correctamente el registro...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxThreads" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCollectionCount" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f																																																REM ;youtube.com/@OptiProjects
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d "400" /f
timeout /t 1 /nobreak >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
echo Hecho!
echo.

echo - Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0resources\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo Hecho!

echo.
echo - Colocando servicios en modo "manual"
sc config "AJRouter" start= demand
sc config "ALG" start= demand
sc config "AppIDSvc" start= demand
sc config "AppMgmt" start= demand
sc config "AppReadiness" start= demand
sc config "AppXSvc" start= demand
sc config "Appinfo" start= demand
sc config "AssignedAccessManagerSvc" start= demand
sc config "AxInstSV" start= demand
sc config "BDESVC" start= demand
sc config "BTAGService" start= demand
sc config "BcastDVRUserService_*" start= demand
sc config "BluetoothUserService_*" start= demand
sc config "Browser" start= demand
sc config "CaptureService_*" start= demand
sc config "CertPropSvc" start= demand
sc config "ClipSVC" start= demand
sc config "ConsentUxUserSvc_*" start= demand
sc config "CredentialEnrollmentManagerUserSvc_*" start= demand
sc config "CscService" start= demand
sc config "DcpSvc" start= demand
sc config "DevQueryBroker" start= demand
sc config "DeviceAssociationBrokerSvc_*" start= demand
sc config "DeviceAssociationService" start= demand
sc config "DeviceInstall" start= demand
sc config "DevicePickerUserSvc_*" start= demand
sc config "DevicesFlowUserSvc_*" start= demand
sc config "DisplayEnhancementService" start= demand
sc config "DmEnrollmentSvc" start= demand
sc config "DsSvc" start= demand
sc config "DsmSvc" start= demand
sc config "EFS" start= demand
sc config "EapHost" start= demand
sc config "EntAppSvc" start= demand
sc config "FDResPub" start= demand
sc config "Fax" start= demand
sc config "FrameServer" start= demand
sc config "FrameServerMonitor" start= demand
sc config "GraphicsPerfSvc" start= demand
sc config "HomeGroupListener" start= demand
sc config "HomeGroupProvider" start= demand
sc config "HvHost" start= demand
sc config "IEEtwCollectorService" start= demand
sc config "IKEEXT" start= demand
sc config "InstallService" start= demand
sc config "InventorySvc" start= demand
sc config "IpxlatCfgSvc" start= demand
sc config "KtmRm" start= demand
sc config "LicenseManager" start= demand
sc config "LxpSvc" start= demand
sc config "MSDTC" start= demand
sc config "MSiSCSI" start= demand
sc config "McpManagementService" start= demand
sc config "MessagingService_*" start= demand
sc config "MicrosoftEdgeElevationService" start= demand
sc config "MixedRealityOpenXRSvc" start= demand
sc config "NPSMSvc_*" start= demand
sc config "NaturalAuthentication" start= demand
sc config "NcaSvc" start= demand
sc config "NcbService" start= demand
sc config "NcdAutoSetup" start= demand
sc config "NetSetupSvc" start= demand
sc config "Netman" start= demand
sc config "NgcCtnrSvc" start= demand
sc config "NgcSvc" start= demand
sc config "NlaSvc" start= demand
sc config "P9RdrService_*" start= demand
sc config "PNRPAutoReg" start= demand
sc config "PNRPsvc" start= demand
sc config "PeerDistSvc" start= demand
sc config "PenService_*" start= demand
sc config "PerfHost" start= demand
sc config "PhoneSvc" start= demand
sc config "PimIndexMaintenanceSvc_*" start= demand
sc config "PlugPlay" start= demand
sc config "PolicyAgent" start= demand
sc config "PrintNotify" start= demand
sc config "PrintWorkflowUserSvc_*" start= demand
sc config "PushToInstall" start= demand
sc config "QWAVE" start= demand
sc config "RasAuto" start= demand
sc config "RasMan" start= demand
sc config "RetailDemo" start= demand
sc config "RmSvc" start= demand
sc config "RpcLocator" start= demand
sc config "SCPolicySvc" start= demand
sc config "SCardSvr" start= demand
sc config "SDRSVC" start= demand
sc config "SEMgrSvc" start= demand
sc config "SNMPTRAP" start= demand
sc config "SNMPTrap" start= demand
sc config "SSDPSRV" start= demand
sc config "ScDeviceEnum" start= demand
sc config "SecurityHealthService" start= demand
sc config "Sense" start= demand
sc config "SensorDataService" start= demand
sc config "SensorService" start= demand
sc config "SensrSvc" start= demand
sc config "SessionEnv" start= demand
sc config "SharedAccess" start= demand
sc config "SharedRealitySvc" start= demand
sc config "SmsRouter" start= demand
sc config "SstpSvc" start= demand
sc config "StiSvc" start= demand
sc config "TabletInputService" start= demand
sc config "TapiSrv" start= demand
sc config "TieringEngineService" start= demand
sc config "TimeBroker" start= demand
sc config "TimeBrokerSvc" start= demand
sc config "TokenBroker" start= demand
sc config "TroubleshootingSvc" start= demand
sc config "TrustedInstaller" start= demand
sc config "UI0Detect" start= demand
sc config "UdkUserSvc_*" start= demand
sc config "UmRdpService" start= demand
sc config "UnistoreSvc_*" start= demand
sc config "UserDataSvc_*" start= demand
sc config "VSS" start= demand
sc config "VacSvc" start= demand
sc config "W32Time" start= demand
sc config "WEPHOSTSVC" start= demand
sc config "WFDSConMgrSvc" start= demand
sc config "WMPNetworkSvc" start= demand
sc config "WManSvc" start= demand
sc config "WPDBusEnum" start= demand
sc config "WSService" start= demand
sc config "WaaSMedicSvc" start= demand
sc config "WalletService" start= demand
sc config "WarpJITSvc" start= demand
sc config "WbioSrvc" start= demand
sc config "WcsPlugInService" start= demand
sc config "WdNisSvc" start= demand
sc config "WdiServiceHost" start= demand
sc config "WdiSystemHost" start= demand
sc config "WebClient" start= demand
sc config "Wecsvc" start= demand
sc config "WerSvc" start= demand
sc config "WiaRpc" start= demand
sc config "WinHttpAutoProxySvc" start= demand
sc config "WinRM" start= demand
sc config "WpcMonSvc" start= demand
sc config "XblAuthManager" start= demand
sc config "XblGameSave" start= demand
sc config "XboxGipSvc" start= demand
sc config "XboxNetApiSvc" start= demand
sc config "autotimesvc" start= demand
sc config "bthserv" start= demand
sc config "camsvc" start= demand
sc config "cloudidsvc" start= demand
sc config "dcsvc" start= demand
sc config "defragsvc" start= demand
sc config "diagnosticshub.standardcollector.service" start= demand
sc config "diagsvc" start= demand
sc config "dmwappushservice" start= demand
sc config "dot3svc" start= demand
sc config "edgeupdate" start= demand
sc config "edgeupdatem" start= demand
sc config "embeddedmode" start= demand
sc config "fdPHost" start= demand
sc config "fhsvc" start= demand
sc config "hidserv" start= demand
sc config "icssvc" start= demand
sc config "lfsvc" start= demand
sc config "lltdsvc" start= demand
sc config "lmhosts" start= demand
sc config "msiserver" start= demand
sc config "netprofm" start= demand
sc config "p2pimsvc" start= demand
sc config "p2psvc" start= demand
sc config "perceptionsimulation" start= demand
sc config "pla" start= demand
sc config "seclogon" start= demand
sc config "smphost" start= demand
sc config "spectrum" start= demand
sc config "svsvc" start= demand
sc config "swprv" start= demand
sc config "upnphost" start= demand
sc config "vds" start= demand
sc config "vmicguestinterface" start= demand
sc config "vmicheartbeat" start= demand
sc config "vmickvpexchange" start= demand
sc config "vmicrdv" start= demand
sc config "vmicshutdown" start= demand
sc config "vmictimesync" start= demand
sc config "vmicvmsession" start= demand
sc config "vmicvss" start= demand
sc config "vmvss" start= demand
sc config "wbengine" start= demand
sc config "wcncsvc" start= demand
sc config "webthreatdefsvc" start= demand
sc config "wercplsupport" start= demand
sc config "wisvc" start= demand
sc config "wlidsvc" start= demand
sc config "wlpasvc" start= demand
sc config "wmiApSrv" start= demand
sc config "workfolderssvc" start= demand
sc config "wuauserv" start= demand
sc config "wudfsvc" start= demand
echo Hecho!

echo.
echo - Deshabilitando servicios innecesarios...
sc config "diagnosticshub.standardcollector.service" start= disabled
sc config "DiagTrack" start= disabled
sc config "DPS" start= disabled
sc config "FontCache" start= disabled
sc config "SystemUsageReportSvc_QUEENCREEK" start= disabled
sc config "GpuEnergyDrv" start= disabled
sc config "PcaSvc" start= disabled
sc config "ShellHWDetection" start= disabled
sc config "SgrmAgent" start= disabled
sc config "SgrmBroker" start= disabled
sc config "uhssvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "WSearch" start= disabled
sc config "diagsvc" start= disabled
echo Hecho!


echo.
echo - Aplicando la optimizacion general en Regedit...
regedit /S "resources\General\Optimizacion General.reg"
regedit /S "resources\General\Mejorar La Velocidad del Menu.reg"
echo Hecho!
timeout /t 2 /nobreak>nul
echo.

echo Optimizacion recomendada aplicada correctamente!
pause >nul
goto :Done


:: Coloca el grupo y limpia la pantalla xd
:: Menu de optimizaciones, aqui vale madres lo de comprobar si el sistema es Win XP, xd
:: Decoracion horrible por q me crashean los ascii
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
echo *6 - Desfragmentar disco duro - SOLO HDDs
echo *7 - Comprobar estado del disco
echo *8 - Gestionar programas de inicio
echo *9 - Actualizar Drivers
echo *10 - Repararar archivos dañados del sistema
echo *11 - Desactivar notificaciones de Windows
echo *12 - Reiniciar explorador de Windows
echo *13 - Eliminar archivos de volcado de memoria
echo *14 - Desactivar la indexacion de archivos
echo *15 - Reducir la cantidad de puntos de restauracion del sistema
echo *16 - Eliminar archivos de actualizaciones fallidas
echo *17 - Liberar espacio
echo *18 - Desactivar sincronizacion de la cuenta de Microsoft
echo *19 - Establecer los servicios en manual
echo *20 - Desactivar las optimizaciones de Pantalla completa
echo *21 - Deshabilitar telemetria
echo *22 - Desactivar servicios
echo *23 - Desactivar las aplicaciones en segundo plano
echo *24 - Optimizar el apartado visual
echo *25 - Establecer la alta prioridad en Juegos
echo *26 - Reducir procesos svchost
echo *27 - Desactivar GameDVR
echo *28 - Desactivar transparencia de ventanas
echo *29 - Desactivar la aceleracion de hardware
echo *30 - Eliminar puntos de restauracion viejos
echo *31 - Regresar al menu
echo.


:: Comandos para la insercion de opciones
set /p op=Opcion: 
if "%op%"=="" goto :OptiMenu
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
if "%op%"=="19" goto :ManualService
if "%op%"=="20" goto :DisableFullScreenOpti
if "%op%"=="21" goto :DisableTelemetry
if "%op%"=="22" goto :DisableServices
if "%op%"=="23" goto :DisableBackgroundApps
if "%op%"=="24" goto :ReduceVisual
if "%op%"=="25" goto :PriorityGame
if "%op%"=="26" goto :ReduceSvchost
if "%op%"=="27" goto :DisableGameDVR
if "%op%"=="28" goto :DisableTransparencyWindow
if "%op%"=="29" goto :DisableHardwareAceleration
if "%op%"=="30" goto :DeleteOldRespoint
if "%op%"=="31" goto :Start
if "%op%"=="reset" goto :ResetScript
if "%op%"=="Devmode--Yes" goto :ConfirmDev
if "%op%"=="Secrets--Konami" goto :Music
if "%op%"=="Secrets--AlphaMode" goto :AlphaEasterEgg
if "%op%"=="Secrets--RobLauncher" goto :RobLaunchDown2
goto :OptiMenu

:: Desactivar la telemetria
:DisableTelemetry
:DisableTelemetry
cls

echo.
echo - Deshabilitando la telemetria usando el registro...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
echo Hecho!

pause
goto :Done

:: Optimizacion general
:Optimization
:Optimization
cls
echo.

:: Aplica optis Bcdedit
echo - Aplicando Optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo Hecho!
echo.

:: Activa el modo OptiVortex
echo - Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0resources\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo Hecho!
echo.

echo - Borrando Archivos Temporales...
start "" "%~dp0scassets\utilities\FastTempDel.bat"

timeout /t 2 /nobreak >nul
echo Cliente iniciado.
echo.

echo - Aplicando Optimizaciones de Regedit
regedit /S "resources\Servicios\Optimizar Servicios.reg"
regedit /S "resources\Prioridad CPU\Prioridad Juegos.reg"
regedit /S "resources\General\Mejorar La Velocidad del Menu.reg"
regedit /S "resources\Mitigar CPU\Deshabilitar Mitigaciones.reg"
regedit /S "resources\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "graphics\Optimizar INTEL.reg"
regedit /S "appearance\Deshabilitar Animaciones.reg"
regedit /S "appearance\Deshabilitar Cortana.reg"
regedit /S "graphics\Optimizar NVIDIA.reg"
regedit /S "graphics\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
echo Hecho!
echo.

echo - Realizando optimizaciones Bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
powercfg -h off >nul 2>&1
echo Hecho!

echo - Desactivando servicios innecesarios...
sc config "diagnosticshub.standardcollector.service" start= disabled
sc config "DiagTrack" start= disabled
sc config "DPS" start= disabled
sc config "FontCache" start= disabled
sc config "SystemUsageReportSvc_QUEENCREEK" start= disabled
sc config "GpuEnergyDrv" start= disabled
sc config "PcaSvc" start= disabled
sc config "ShellHWDetection" start= disabled
sc config "SgrmAgent" start= disabled
sc config "SgrmBroker" start= disabled
sc config "uhssvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "WSearch" start= disabled
sc config "diagsvc" start= disabled
echo Hecho!
echo.

echo - Estableciendo servicios en modo manual...
sc config "AJRouter" start= demand
sc config "ALG" start= demand
sc config "AppIDSvc" start= demand
sc config "AppMgmt" start= demand
sc config "AppReadiness" start= demand
sc config "AppXSvc" start= demand
sc config "Appinfo" start= demand
sc config "AssignedAccessManagerSvc" start= demand
sc config "AxInstSV" start= demand
sc config "BDESVC" start= demand
sc config "BTAGService" start= demand
sc config "BcastDVRUserService_*" start= demand
sc config "BluetoothUserService_*" start= demand
sc config "Browser" start= demand
sc config "CaptureService_*" start= demand
sc config "CertPropSvc" start= demand
sc config "ClipSVC" start= demand
sc config "ConsentUxUserSvc_*" start= demand
sc config "CredentialEnrollmentManagerUserSvc_*" start= demand
sc config "CscService" start= demand
sc config "DcpSvc" start= demand
sc config "DevQueryBroker" start= demand
sc config "DeviceAssociationBrokerSvc_*" start= demand
sc config "DeviceAssociationService" start= demand
sc config "DeviceInstall" start= demand
sc config "DevicePickerUserSvc_*" start= demand
sc config "DevicesFlowUserSvc_*" start= demand
sc config "DisplayEnhancementService" start= demand
sc config "DmEnrollmentSvc" start= demand
sc config "DsSvc" start= demand
sc config "DsmSvc" start= demand
sc config "EFS" start= demand
sc config "EapHost" start= demand
sc config "EntAppSvc" start= demand
sc config "FDResPub" start= demand
sc config "Fax" start= demand
sc config "FrameServer" start= demand
sc config "FrameServerMonitor" start= demand
sc config "GraphicsPerfSvc" start= demand
sc config "HomeGroupListener" start= demand
sc config "HomeGroupProvider" start= demand
sc config "HvHost" start= demand
sc config "IEEtwCollectorService" start= demand
sc config "IKEEXT" start= demand
sc config "InstallService" start= demand
sc config "InventorySvc" start= demand
sc config "IpxlatCfgSvc" start= demand
sc config "KtmRm" start= demand
sc config "LicenseManager" start= demand
sc config "LxpSvc" start= demand
sc config "MSDTC" start= demand
sc config "MSiSCSI" start= demand
sc config "McpManagementService" start= demand
sc config "MessagingService_*" start= demand
sc config "MicrosoftEdgeElevationService" start= demand
sc config "MixedRealityOpenXRSvc" start= demand
sc config "NPSMSvc_*" start= demand
sc config "NaturalAuthentication" start= demand
sc config "NcaSvc" start= demand
sc config "NcbService" start= demand
sc config "NcdAutoSetup" start= demand
sc config "NetSetupSvc" start= demand
sc config "Netman" start= demand
sc config "NgcCtnrSvc" start= demand
sc config "NgcSvc" start= demand
sc config "NlaSvc" start= demand
sc config "P9RdrService_*" start= demand
sc config "PNRPAutoReg" start= demand
sc config "PNRPsvc" start= demand
sc config "PeerDistSvc" start= demand
sc config "PenService_*" start= demand
sc config "PerfHost" start= demand
sc config "PhoneSvc" start= demand
sc config "PimIndexMaintenanceSvc_*" start= demand
sc config "PlugPlay" start= demand
sc config "PolicyAgent" start= demand
sc config "PrintNotify" start= demand
sc config "PrintWorkflowUserSvc_*" start= demand
sc config "PushToInstall" start= demand
sc config "QWAVE" start= demand
sc config "RasAuto" start= demand
sc config "RasMan" start= demand
sc config "RetailDemo" start= demand
sc config "RmSvc" start= demand
sc config "RpcLocator" start= demand
sc config "SCPolicySvc" start= demand
sc config "SCardSvr" start= demand
sc config "SDRSVC" start= demand
sc config "SEMgrSvc" start= demand
sc config "SNMPTRAP" start= demand
sc config "SNMPTrap" start= demand
sc config "SSDPSRV" start= demand
sc config "ScDeviceEnum" start= demand
sc config "SecurityHealthService" start= demand
sc config "Sense" start= demand
sc config "SensorDataService" start= demand
sc config "SensorService" start= demand
sc config "SensrSvc" start= demand
sc config "SessionEnv" start= demand
sc config "SharedAccess" start= demand
sc config "SharedRealitySvc" start= demand
sc config "SmsRouter" start= demand
sc config "SstpSvc" start= demand
sc config "StiSvc" start= demand
sc config "TabletInputService" start= demand
sc config "TapiSrv" start= demand
sc config "TieringEngineService" start= demand
sc config "TimeBroker" start= demand
sc config "TimeBrokerSvc" start= demand
sc config "TokenBroker" start= demand
sc config "TroubleshootingSvc" start= demand
sc config "TrustedInstaller" start= demand
sc config "UI0Detect" start= demand
sc config "UdkUserSvc_*" start= demand
sc config "UmRdpService" start= demand
sc config "UnistoreSvc_*" start= demand
sc config "UserDataSvc_*" start= demand
sc config "VSS" start= demand
sc config "VacSvc" start= demand
sc config "W32Time" start= demand
sc config "WEPHOSTSVC" start= demand
sc config "WFDSConMgrSvc" start= demand
sc config "WMPNetworkSvc" start= demand
sc config "WManSvc" start= demand
sc config "WPDBusEnum" start= demand
sc config "WSService" start= demand
sc config "WaaSMedicSvc" start= demand
sc config "WalletService" start= demand
sc config "WarpJITSvc" start= demand
sc config "WbioSrvc" start= demand
sc config "WcsPlugInService" start= demand
sc config "WdNisSvc" start= demand
sc config "WdiServiceHost" start= demand
sc config "WdiSystemHost" start= demand
sc config "WebClient" start= demand
sc config "Wecsvc" start= demand
sc config "WerSvc" start= demand
sc config "WiaRpc" start= demand
sc config "WinHttpAutoProxySvc" start= demand
sc config "WinRM" start= demand
sc config "WpcMonSvc" start= demand
sc config "XblAuthManager" start= demand
sc config "XblGameSave" start= demand
sc config "XboxGipSvc" start= demand
sc config "XboxNetApiSvc" start= demand
sc config "autotimesvc" start= demand
sc config "bthserv" start= demand
sc config "camsvc" start= demand
sc config "cloudidsvc" start= demand
sc config "dcsvc" start= demand
sc config "defragsvc" start= demand
sc config "diagnosticshub.standardcollector.service" start= demand
sc config "diagsvc" start= demand
sc config "dmwappushservice" start= demand
sc config "dot3svc" start= demand
sc config "edgeupdate" start= demand
sc config "edgeupdatem" start= demand
sc config "embeddedmode" start= demand
sc config "fdPHost" start= demand
sc config "fhsvc" start= demand
sc config "hidserv" start= demand
sc config "icssvc" start= demand
sc config "lfsvc" start= demand
sc config "lltdsvc" start= demand
sc config "lmhosts" start= demand
sc config "msiserver" start= demand
sc config "netprofm" start= demand
sc config "p2pimsvc" start= demand
sc config "p2psvc" start= demand
sc config "perceptionsimulation" start= demand
sc config "pla" start= demand
sc config "seclogon" start= demand
sc config "smphost" start= demand
sc config "spectrum" start= demand
sc config "svsvc" start= demand
sc config "swprv" start= demand
sc config "upnphost" start= demand
sc config "vds" start= demand
sc config "vmicguestinterface" start= demand
sc config "vmicheartbeat" start= demand
sc config "vmickvpexchange" start= demand
sc config "vmicrdv" start= demand
sc config "vmicshutdown" start= demand
sc config "vmictimesync" start= demand
sc config "vmicvmsession" start= demand
sc config "vmicvss" start= demand
sc config "vmvss" start= demand
sc config "wbengine" start= demand
sc config "wcncsvc" start= demand
sc config "webthreatdefsvc" start= demand
sc config "wercplsupport" start= demand
sc config "wisvc" start= demand
sc config "wlidsvc" start= demand
sc config "wlpasvc" start= demand
sc config "wmiApSrv" start= demand
sc config "workfolderssvc" start= demand
sc config "wuauserv" start= demand
sc config "wudfsvc" start= demand

echo.
echo - Configurando correctamente el registro...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxThreads" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCollectionCount" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f																																																REM ;youtube.com/@OptiProjects
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d "400" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
echo Hecho!
echo.
timeout /t 2 /nobreak>nul
echo Optimizacion realizada con exito!
echo.
pause
goto :Done

:: Desactivar la aceleracion de hardware
:DisableHardwareAceleration
:DisableHardwareAceleration
cls
echo - Desactivando aceleracion de hardware...

reg add "HKCU\Software\Microsoft\Avalon.Graphics" /v "DisableHWAcceleration" /t REG_DWORD /d 1 /f
echo Hecho!
echo.

pause
goto :Done

:: Desactivar la transparencia de ventanas
:DisableTransparencyWindow
:DisableTransparencyWindow
cls
echo - Desactivando transparencia de ventanas...

reg add "HKCU\Software\Microsoft\Windows\DWM" /v "EnableTransparency" /t REG_DWORD /d 0 /f
echo Hecho!
echo.

pause
goto :Done

:: Desactivar GameDVR
:DisableGameDVR
:DisableGameDVR
cls
echo - Desactivar GameDVR...

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f
echo Hecho!
echo.

pause
goto :Done

:: Reducir los procesos svchost
:ReduceSvchost
:ReduceSvchost
cls
echo - Reduciendo procesos svchost...

for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set MEM=%%i
set /a RAM=%MEM% + 1024000
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%RAM%" /f
echo Hecho!
echo.

pause
goto :Done

:: Priorizar los juegos 
:PriorityGame
:PriorityGame
cls
echo - Estableciendo alta prioridad en juegos...

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\csgo.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\cs2.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\gta_3.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\gta_vc.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\gta_sa.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTAIV.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\GTA5.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\java.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\javaw.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\minecraft.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Minecraft.Windows.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MsMpEng.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs32.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\obs64.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\OptiCraft.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PPSSPP.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ShellExperienceHost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f
echo Hecho!
echo.

pause
goto :Done

:: Reduce el apartado visual
:ReduceVisual
:ReduceVisual
cls
echo - Optimizando Apartado Visual...

reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v KeyboardDelay /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewShadow /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKCU\Control Panel\Desktop" /v EnableAeroPeek /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v TaskbarMn /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3" /v TaskbarDa /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f
echo Hecho!
echo.

pause
goto :Done

:: Desactiva las aplicaciones de fondo
:DisableBackgroundApps
:DisableBackgroundApps
cls

echo - Deshabilitando aplicaciones en segundo plano...
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v GlobalUserDisabled /t REG_DWORD /d 1 /f
echo Hecho!
echo.

pause
goto :Done

:: Desactivar Servicios
:DisableServices
:DisableServices
cls

echo.
echo - Deshabilitando servicios...
sc config "DiagTrack" start= disabled
sc config "DPS" start= disabled
sc config "FontCache" start= disabled
sc config "SystemUsageReportSvc_QUEENCREEK" start= disabled
sc config "GpuEnergyDrv" start= disabled
sc config "PcaSvc" start= disabled
sc config "ShellHWDetection" start= disabled
sc config "SgrmAgent" start= disabled
sc config "SgrmBroker" start= disabled
sc config "uhssvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "WSearch" start= disabled
sc config "diagsvc" start= disabled
echo Hecho!
echo.

pause
goto :Done

:: Desactivar optimizaciones en fullscreen
:DisableFullScreenOpti
:DisableFullScreenOpti
cls
echo - Deshabilitando optimizaciones en Fullscreen...

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f
echo Hecho!

pause
goto :Done

:ManualService
:ManualService
cls
echo Pulsa una tecla para continuar con la optimizacion...
pause>nul
echo.

echo - Estableciendo servicios en manual...
sc config "AJRouter" start= demand
sc config "ALG" start= demand
sc config "AppIDSvc" start= demand
sc config "AppMgmt" start= demand
sc config "AppReadiness" start= demand
sc config "AppXSvc" start= demand
sc config "Appinfo" start= demand
sc config "AssignedAccessManagerSvc" start= demand
sc config "AxInstSV" start= demand
sc config "BDESVC" start= demand
sc config "BTAGService" start= demand
sc config "BcastDVRUserService_*" start= demand
sc config "BluetoothUserService_*" start= demand
sc config "Browser" start= demand
sc config "CaptureService_*" start= demand
sc config "CertPropSvc" start= demand
sc config "ClipSVC" start= demand
sc config "ConsentUxUserSvc_*" start= demand
sc config "CredentialEnrollmentManagerUserSvc_*" start= demand
sc config "CscService" start= demand
sc config "DcpSvc" start= demand
sc config "DevQueryBroker" start= demand
sc config "DeviceAssociationBrokerSvc_*" start= demand
sc config "DeviceAssociationService" start= demand
sc config "DeviceInstall" start= demand
sc config "DevicePickerUserSvc_*" start= demand
sc config "DevicesFlowUserSvc_*" start= demand
sc config "DisplayEnhancementService" start= demand
sc config "DmEnrollmentSvc" start= demand
sc config "DsSvc" start= demand
sc config "DsmSvc" start= demand
sc config "EFS" start= demand
sc config "EapHost" start= demand
sc config "EntAppSvc" start= demand
sc config "FDResPub" start= demand
sc config "Fax" start= demand
sc config "FrameServer" start= demand
sc config "FrameServerMonitor" start= demand
sc config "GraphicsPerfSvc" start= demand
sc config "HomeGroupListener" start= demand
sc config "HomeGroupProvider" start= demand
sc config "HvHost" start= demand
sc config "IEEtwCollectorService" start= demand
sc config "IKEEXT" start= demand
sc config "InstallService" start= demand
sc config "InventorySvc" start= demand
sc config "IpxlatCfgSvc" start= demand
sc config "KtmRm" start= demand
sc config "LicenseManager" start= demand
sc config "LxpSvc" start= demand
sc config "MSDTC" start= demand
sc config "MSiSCSI" start= demand
sc config "McpManagementService" start= demand
sc config "MessagingService_*" start= demand
sc config "MicrosoftEdgeElevationService" start= demand
sc config "MixedRealityOpenXRSvc" start= demand
sc config "NPSMSvc_*" start= demand
sc config "NaturalAuthentication" start= demand
sc config "NcaSvc" start= demand
sc config "NcbService" start= demand
sc config "NcdAutoSetup" start= demand
sc config "NetSetupSvc" start= demand
sc config "Netman" start= demand
sc config "NgcCtnrSvc" start= demand
sc config "NgcSvc" start= demand
sc config "NlaSvc" start= demand
sc config "P9RdrService_*" start= demand
sc config "PNRPAutoReg" start= demand
sc config "PNRPsvc" start= demand
sc config "PeerDistSvc" start= demand
sc config "PenService_*" start= demand
sc config "PerfHost" start= demand
sc config "PhoneSvc" start= demand
sc config "PimIndexMaintenanceSvc_*" start= demand
sc config "PlugPlay" start= demand
sc config "PolicyAgent" start= demand
sc config "PrintNotify" start= demand
sc config "PrintWorkflowUserSvc_*" start= demand
sc config "PushToInstall" start= demand
sc config "QWAVE" start= demand
sc config "RasAuto" start= demand
sc config "RasMan" start= demand
sc config "RetailDemo" start= demand
sc config "RmSvc" start= demand
sc config "RpcLocator" start= demand
sc config "SCPolicySvc" start= demand
sc config "SCardSvr" start= demand
sc config "SDRSVC" start= demand
sc config "SEMgrSvc" start= demand
sc config "SNMPTRAP" start= demand
sc config "SNMPTrap" start= demand
sc config "SSDPSRV" start= demand
sc config "ScDeviceEnum" start= demand
sc config "SecurityHealthService" start= demand
sc config "Sense" start= demand
sc config "SensorDataService" start= demand
sc config "SensorService" start= demand
sc config "SensrSvc" start= demand
sc config "SessionEnv" start= demand
sc config "SharedAccess" start= demand
sc config "SharedRealitySvc" start= demand
sc config "SmsRouter" start= demand
sc config "SstpSvc" start= demand
sc config "StiSvc" start= demand
sc config "TabletInputService" start= demand
sc config "TapiSrv" start= demand
sc config "TieringEngineService" start= demand
sc config "TimeBroker" start= demand
sc config "TimeBrokerSvc" start= demand
sc config "TokenBroker" start= demand
sc config "TroubleshootingSvc" start= demand
sc config "TrustedInstaller" start= demand
sc config "UI0Detect" start= demand
sc config "UdkUserSvc_*" start= demand
sc config "UmRdpService" start= demand
sc config "UnistoreSvc_*" start= demand
sc config "UserDataSvc_*" start= demand
sc config "VSS" start= demand
sc config "VacSvc" start= demand
sc config "W32Time" start= demand
sc config "WEPHOSTSVC" start= demand
sc config "WFDSConMgrSvc" start= demand
sc config "WMPNetworkSvc" start= demand
sc config "WManSvc" start= demand
sc config "WPDBusEnum" start= demand
sc config "WSService" start= demand
sc config "WaaSMedicSvc" start= demand
sc config "WalletService" start= demand
sc config "WarpJITSvc" start= demand
sc config "WbioSrvc" start= demand
sc config "WcsPlugInService" start= demand
sc config "WdNisSvc" start= demand
sc config "WdiServiceHost" start= demand
sc config "WdiSystemHost" start= demand
sc config "WebClient" start= demand
sc config "Wecsvc" start= demand
sc config "WerSvc" start= demand
sc config "WiaRpc" start= demand
sc config "WinHttpAutoProxySvc" start= demand
sc config "WinRM" start= demand
sc config "WpcMonSvc" start= demand
sc config "XblAuthManager" start= demand
sc config "XblGameSave" start= demand
sc config "XboxGipSvc" start= demand
sc config "XboxNetApiSvc" start= demand
sc config "autotimesvc" start= demand
sc config "bthserv" start= demand
sc config "camsvc" start= demand
sc config "cloudidsvc" start= demand
sc config "dcsvc" start= demand
sc config "defragsvc" start= demand
sc config "diagnosticshub.standardcollector.service" start= demand
sc config "diagsvc" start= demand
sc config "dmwappushservice" start= demand
sc config "dot3svc" start= demand
sc config "edgeupdate" start= demand
sc config "edgeupdatem" start= demand
sc config "embeddedmode" start= demand
sc config "fdPHost" start= demand
sc config "fhsvc" start= demand
sc config "hidserv" start= demand
sc config "icssvc" start= demand
sc config "lfsvc" start= demand
sc config "lltdsvc" start= demand
sc config "lmhosts" start= demand
sc config "msiserver" start= demand
sc config "netprofm" start= demand
sc config "p2pimsvc" start= demand
sc config "p2psvc" start= demand
sc config "perceptionsimulation" start= demand
sc config "pla" start= demand
sc config "seclogon" start= demand
sc config "smphost" start= demand
sc config "spectrum" start= demand
sc config "svsvc" start= demand
sc config "swprv" start= demand
sc config "upnphost" start= demand
sc config "vds" start= demand
sc config "vmicguestinterface" start= demand
sc config "vmicheartbeat" start= demand
sc config "vmickvpexchange" start= demand
sc config "vmicrdv" start= demand
sc config "vmicshutdown" start= demand
sc config "vmictimesync" start= demand
sc config "vmicvmsession" start= demand
sc config "vmicvss" start= demand
sc config "vmvss" start= demand
sc config "wbengine" start= demand
sc config "wcncsvc" start= demand
sc config "webthreatdefsvc" start= demand
sc config "wercplsupport" start= demand
sc config "wisvc" start= demand
sc config "wlidsvc" start= demand
sc config "wlpasvc" start= demand
sc config "wmiApSrv" start= demand
sc config "workfolderssvc" start= demand
sc config "wuauserv" start= demand
sc config "wudfsvc" start= demand
echo Hecho!

echo.
pause
goto :Done

:DesMSSync
:DesMSSync
cls
echo ==================================================
echo         Desactivar sincronizacion
echo ==================================================
echo.
echo - Desactivando sincronizacion...
timeout /t 1 /nobreak >nul

:: Desactivar la sincronización de la cuenta de Microsoft

:: Desactiva la sincronización de configuraciones de la cuenta Microsoft en el registro
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353388Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AccountSettings" /v "DisableMicrosoftAccountSync" /t REG_DWORD /d "1" /f

:: Mensaje indicando que se desactivó la sincronización
echo Hecho!
pause
goto :Start
 
:CleanMGR
:CleanMGR
cls
echo ==================================================
echo           Borrar archivos temporales
echo ==================================================
echo.
echo - Iniciando la herramienta de limpieza de disco...
timeout /t 1 /nobreak >nul
echo.

:: Comando para iniciar el programa
start "" "%~dp0scassets\utilities\cleanmgr.bat"

echo Hecho!
pause
goto Start

:SFCScan
:SFCScan
cls
echo - Comprobando y reparando archivos del sistema...

sfc /scannow
echo.

echo Hecho!
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
echo Hecho! Se recomienda reiniciar el sistema para comprobar los cambios
pause
goto :Start

:: Revision del disco duro
:ChkDisk
:ChkDisk
cls

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

echo - Comprobando y reparando errores en la unidad %drive%...
echo - Esto puede tardar un tiempo. Por favor, espera.

:: Ejecutar chkdsk con la opcion /f
chkdsk %drive%: /f

if %errorlevel%==0 (
    echo La verificacion se completo sin errores.
) else (
    echo Se encontraron errores en la unidad %drive% y se han corregido.
)

echo.
echo Verificacion completada!
pause
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
echo   ¡ADVERTENCIA! SOLO RECOMENDABLE EN UNIDADES HDDs
echo   YA QUE EN LOS SSDs ACORTA SU VIDA UTIL.
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
    goto cancelarProceso
)

:: Ejecuta el proceso de desfragmentacion con "defrag %drive%: /O /H"
echo *** - Desfragmentando la unidad %drive%... Esto puede tardar un tiempo ***
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

:cancelarProceso
echo Operacion cancelada... saliendo...
timeout /t 2 /nobreak>nul
goto :Start

:: Actualizacion de Drivers

:: Coloca el grupo y limpia la pantalla
:DriversUpd
:DriversUpd
cls
echo ==================================================
echo            Actualizar Drivers
echo ==================================================
echo.
echo 1. Actualizar mediante Web
echo 2. Actualizar mediante Driver Booster
echo 3. Regresar al menu
echo.

set /p option="Opcion: "

if "%option%"=="" goto :DriversUpd
if "%option%"=="1" goto :DriversUpdWeb
if "%option%"=="2" goto :DriverBooster
if "%option%"=="3" goto :Start
if "%op%"=="Devmode--Yes" goto :ConfirmDev
if "%op%"=="Secrets--Konami" goto :Music
if "%op%"=="Secrets--AlphaMode" goto :AlphaEasterEgg
if "%op%"=="Secrets--RobLauncher" goto :RobLaunchDown2
goto :DriversUpd

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

if "%option%"=="" goto :DriversUpdWeb
if "%option%"=="1" (
    echo - Abriendo pagina de AMD...
    start https://goo.su/eU5BaaT
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="2" (
    echo - Abriendo pagina de Intel...
    start https://goo.su/Wdo3
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="3" (
    echo - Abriendo pagina de NVIDIA...
    start https://goo.su/z1V5vv
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="4" (
    echo - Abriendo pagina de HP...
    start https://support.hp.com/us-en/drivers
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="5" (
    echo - Abriendo pagina de TOSHIBA...
    start https://business.toshiba.com/support-drivers
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="6" (
    echo - Abriendo pagina de Lenovo...
    start https://support.lenovo.com/us/en
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="7" (
    echo - Abriendo pagina de Asus...
    start https://www.asus.com/support/download-center/
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="8" (
    echo - Abriendo pagina de Acer...
    start https://www.acer.com/ae-en/predator/support/drivers-manuals/drivers-and-manuals
	timeout /t 2 /nobreak >nul
	goto :Start
) else if "%option%"=="9" (
	goto :Start
) else (
    echo Opcion no valida. Selecciona una del menu :v
	goto :DriversUpdWeb
)

:DriverBooster
:DriverBooster
echo ==================================================
echo                Driver Booster
echo ==================================================
echo.
echo - Iniciando herramienta...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
start "" "%~dp0scassets\utilities\driver-booster\DriverBoosterPortable.exe"

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
echo - Iniciando herramienta...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
start "" "%~dp0scassets\utilities\FastTempDel.bat"

pause
goto :Start

:: Coloca el grupo y limpia la pantalla
:OptiWiFi
:OptiWiFi
cls

echo - Limpiando la cache DNS...
ipconfig /flushdns >nul 2>&1
echo Hecho!
echo.

:: Aplica la DNS de Cloudfare (con ayuda de ChatGPT, BlackBoxAI y mi IA de Python)
echo - Aplicando DNS de Cloudfare...
FOR /F "tokens=* delims=:" %%a IN ('IPCONFIG ^| FIND /I "ETHERNET ADAPTER"') DO (
SET adapterName=%%a >nul 2>&1
SET adapterName=!adapterName:~17! >nul 2>&1
SET adapterName=!adapterName:~0,-1! >nul 2>&1
netsh interface ipv4 set dns name="!adapterName!" static 1.1.1.1 primary >nul 2>&1
netsh interface ipv4 add dns name="!adapterName!" 1.0.0.1 index=2 >nul 2>&1
)
echo Hecho!
echo.

echo - Eliminando el limite QoS...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\QoS" /v LimitReservableBandwidth /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1
echo Hecho!
echo.

echo - Aplicando regedit (TCP)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v GlobalMaxTcpWindowSize /t REG_DWORD /d 0x7FFF /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpNumConnections /t REG_DWORD /d 0xFFFFFF /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCP1323opts /t REG_DWORD /d 1 /f >nul 2>&1
echo Hecho!
echo.
pause
goto :Done

:: Coloca el grupo y limpia la pantalla
:OptiRAM
:OptiRAM
cls

:: Esta optimizacion solo optimiza la ram y aplica un par de optimizaciones
echo - Aplicando Optimizacion Regedit...
regedit /S "resources\Servicios\Optimizar Servicios.reg"
regedit /S "resources\Telemetria\Deshabilitar Telemetria.reg"
regedit /S "graphics\Optimizar INTEL.reg"
regedit /S "graphics\Optimizar NVIDIA.reg"
regedit /S "graphics\Prioridad A Graficos.reg"
regedit /S "RAM\Optimizar RAM.reg"
echo Hecho!
echo.

:: Instala Mem Reduct
echo - Instalando MemReduct x86...
xcopy "resources\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
echo Hecho!
echo.
pause
goto :DoneRAM


:: Coloca el grupo y limpia la pantalla
:CleanCache
:CleanCache
cls

:: Limpiar archivos temporales
echo - Limpiando archivos temporales...
del /q /f "%temp%\*.*" >nul 2>&1
if %errorlevel% neq 0 (
    echo No se pudieron eliminar algunos archivos temporales.
) else (
    rd /s /q "%temp%" >nul 2>&1
    mkdir "%temp%" >nul 2>&1
    echo Archivos temporales eliminados.
)

:: Limpiar cache de Internet Explorer
echo - Limpiando cache de Internet Explorer...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de Internet Explorer.
) else (
    echo Cache de Internet Explorer eliminada.
)

:: Limpiar cache de Windows Store
echo - Limpiando cache de la Tienda de Windows...
start /wait wsreset.exe
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de la Tienda de Windows.
) else (
    echo Cache de la Tienda de Windows limpiada.
)

:: Limpiar cache de DNS
echo - Limpiando cache de DNS...
ipconfig /flushdns >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de DNS.
) else (
    echo Cache de DNS eliminada.
)

:: Limpiar cache de Thumbnails
echo - Limpiando cache de Thumbnails...
del /q /f "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*" >nul 2>&1
if %errorlevel% neq 0 (
    echo Error al limpiar la cache de Thumbnails.
) else (
    echo Cache de Thumbnails eliminada.
)

echo Hecho!
echo.
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
echo 1 - Ejecutar Uninstall Tool
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 1 /nobreak >nul
    start "" "%~dp0scassets\utilities\desinstalar-tool\UninstallToolPortable.exe"
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

start "" "%~dp0scassets\roblaunch\roblauncher-downloader.bat"

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
if "%op%"=="" goto :Xtreme
if "%op%"=="1" goto :ConfirmLite
if "%op%"=="2" goto :ConfirmXtremeOpti
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
echo - Limpiando el registro de Windows...
echo.

:: Hacer una copia de seguridad del registro antes de modificarlo
echo - Realizando copia de seguridad del registro...
reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU "%USERPROFILE%\Desktop\RunMRU_Backup.reg" /y
reg export "HKCU\Software\Microsoft\Internet Explorer" "%USERPROFILE%\Desktop\InternetExplorer_Backup.reg" /y
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "%USERPROFILE%\Desktop\ShellFolders_Backup.reg" /y

:: Eliminar historial de ejecucion (MRU)
echo - Eliminando historial de ejecuciones recientes...
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f

:: Eliminar entradas de URLs de Internet Explorer
echo - Eliminando entradas de URLs de Internet Explorer...
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /f

:: Eliminar claves de ejecucion de bajo registro de Internet Explorer
echo - Eliminando claves de ejecucion de bajo registro...
reg delete "HKCU\Software\Microsoft\Internet Explorer\LowRegistry\Run" /f

:: Eliminar claves relacionadas con la papelera de reciclaje
echo - Eliminando claves de la papelera de reciclaje...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /f

:: Eliminar claves de programas desinstalados
echo - Eliminando claves de programas no utilizados...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall" /f

:: Limpiar claves de aplicaciones recientes
echo - Eliminando claves de aplicaciones recientes...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f

:: Limpiar claves de historial de busqueda
echo - Eliminando historial de busqueda...
reg delete "HKCU\Software\Microsoft\Search\RecentQueries" /f

:: Limpiar entradas de fuentes de pantalla recientes
echo - Eliminando fuentes de pantalla recientes...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f

:: Limpiar entradas de preferencias del sistema
echo - Limpiando preferencias del sistema...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f

:: Limpiar claves de Windows Update
echo - Limpiando claves de Windows Update...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate" /f

:: Limpiar claves de la barra de tareas
echo - Limpiando configuraciones de la barra de tareas...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f

:: Limpiar el historial de busqueda del explorador
echo - Limpiando historial de busqueda del explorador...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SearchHistory" /f

:: Limpiar el historial de la ventana de ejecutar
echo - Limpiando historial de la ventana de ejecutar...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f

echo Registro limpiado correctamente.
echo.
pause
goto :DoneRegDel

:: Crea un punto de restauracion para restablecer cambios en caso de que las optimizaciones no sean de agrado

:Respoint
:Respoint
cls

:: Optimizaciones extremas
echo ==================================================
echo           Puntos de restauracion
echo ==================================================
echo.
echo *1 - Crear uno nuevo (Recomendado)
echo *2 - Eliminar viejos puntos de restauracion (Todos)
echo *3 - Reducir la cantidad de puntos de restauracion
echo *4 - Regresar al menu
echo.

:: Insercion de opciones
set /p op=Opcion: 
if "%op%"=="1" goto :MakeRespoint
if "%op%"=="2" goto :DeleteOldRespoint
if "%op%"=="3" goto :ReduceRestaurationPoints
if "%op%"=="4" goto :Start
(
    echo Opcion no valida. Elije una opcion del menu :v
    timeout /t 2 /nobreak > nul
    goto :Respoint
) else (
    goto :Respoint
)

:MakeRespoint
:MakeRespoint
cls
echo ==================================================
echo      Crear un punto de restauracion (W7+)
echo ==================================================
echo.
echo Presiona una tecla para continuar con la creacion...
pause>nul
echo - Creando punto de restauracion...
echo.
timeout /t 1 /nobreak >nul

:: Intentar crear el punto de restauracion y manejar errores
"powershell.exe" Enable-ComputerRestore -Drive "%SystemDrive%"
"powershell.exe" -Command "try { Checkpoint-Computer -Description 'Antes Optimizacion' -ErrorAction Stop } catch { Write-Host 'Error al crear el punto de restauracion: $_' }"

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

:: Eliminar punto de restauracion antiguos
:DeleteOldRespoint
:DeleteOldRespoint
cls
echo - Eliminando punto de restauracion antiguos...

vssadmin delete shadows /all /quiet
echo Hecho!
echo.

pause
goto :DoneDeletedRespoint

:: Optimizacion extrema
:XtremeOpti
:XtremeOpti
cls
echo - Aplicando optimizacion riesgosa...
timeout /t 2 /nobreak>nul
pause
echo.
echo - Colocando modo oscuro...
regedit /S "resources\General\Mejorar La Velocidad del Menu.reg"
regedit /S "appearance\Modo Oscuro.reg"
echo Hecho :D

echo.
echo - Configurando menus...
regedit /S "appearance\Deshabilitar Transparencias.reg"
regedit /S "appearance\Deshabilitar Cortana.reg"
echo Hecho :D

echo.
echo - Instalando WinRAR...
:: Instala WinRAR
xcopy "scassets\utilities\winRAR" "%SystemDrive%\Program Files\winRAR" /S /Y
start /min "" "%SystemDrive%\Program Files\winRAR\WinRAR.exe"
echo Hecho :D
echo.

echo - Instalando MemReduct...
:: Instala Mem Reduct
echo - Instalando MemReduct x86...
xcopy "resources\Reducir RAM" "%SystemDrive%\Program Files (x86)" /S /Y
start /min "" "%SystemDrive%\Program Files (x86)\Mem Reduct\memreduct.exe"
echo Hecho!
echo.

echo - Eliminando punto de restauracion antiguos...

vssadmin delete shadows /all /quiet
echo Hecho!
echo.

echo - Recortando Windows...
regedit /S "appearance\Deshabilitar Animaciones.reg"
regedit /S "appearance\Deshabilitar Cortana.reg"
regedit /S "appearance\Deshabilitar Transparencias.reg"
regedit /S "appearance\Deshabilitar Centro Acciones.reg"

takeown /F "%WINDIR%\WinSxS" /R /A
icacls "%WINDIR%\WinSxS" /grant *S-1-3-4:F /t /c /l /q
takeown /F "%WINDIR%\System32\Recovery" /R /A
icacls "%WINDIR%\System32\Recovery" /grant *S-1-3-4:F /t /c /l /q

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

del /S /F /Q "%WINDIR%\System32\Recovery"
echo.
del /S /F /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender\Definition Updates"

powershell Get-AppxPackage -AllUsers | Where-Object { $_.Name -notlike "*store*" } | Remove-AppxPackage

start "" "%~dp0scassets\utilities\screen.bat"

start "" "%~dp0scassets\utilities\FastTempDel.bat"

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353388Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AccountSettings" /v "DisableMicrosoftAccountSync" /t REG_DWORD /d "1" /f

echo - Eliminar el registro...
:: Eliminar historial de ejecucion (MRU)
echo - Eliminando historial de ejecuciones recientes...
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f

:: Eliminar entradas de URLs de Internet Explorer
echo - Eliminando entradas de URLs de Internet Explorer...
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /f

:: Eliminar claves de ejecucion de bajo registro de Internet Explorer
echo - Eliminando claves de ejecucion de bajo registro...
reg delete "HKCU\Software\Microsoft\Internet Explorer\LowRegistry\Run" /f

:: Eliminar claves relacionadas con la papelera de reciclaje
echo - Eliminando claves de la papelera de reciclaje...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /f

:: Eliminar claves de programas desinstalados
echo - Eliminando claves de programas no utilizados...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall" /f

:: Limpiar claves de aplicaciones recientes
echo - Eliminando claves de aplicaciones recientes...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f

:: Limpiar claves de historial de busqueda
echo - Eliminando historial de busqueda...
reg delete "HKCU\Software\Microsoft\Search\RecentQueries" /f

:: Limpiar entradas de fuentes de pantalla recientes
echo - Eliminando fuentes de pantalla recientes...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f

:: Limpiar entradas de preferencias del sistema
echo - Limpiando preferencias del sistema...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f

:: Limpiar claves de Windows Update
echo - Limpiando claves de Windows Update...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate" /f

:: Limpiar claves de la barra de tareas
echo - Limpiando configuraciones de la barra de tareas...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f

:: Limpiar el historial de busqueda del explorador
echo - Limpiando historial de busqueda del explorador...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SearchHistory" /f

:: Limpiar el historial de la ventana de ejecutar
echo - Limpiando historial de la ventana de ejecutar...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f

echo - Reduciendo procesos svchost...
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /format:value') do set MEM=%%i
set /a RAM=%MEM% + 1024000
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%RAM%" /f
echo Hecho!

echo.
echo - Deshabilitando Wifi Sense...
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowWiFiHotSpotReporting /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowAutoConnectToWiFiSenseHotspots /t REG_DWORD /d 0 /f
echo Hecho!

echo.
echo - Deshabilitando tareas de WinUpd...
schtasks /Change /TN "\Microsoft\Windows\InstallService\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\UpdateOrchestrator\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\UpdateAssistant\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\WaaSMedic\*" /Disable
schtasks /Change /TN "\Microsoft\Windows\WindowsUpdate\*" /Disable
schtasks /Change /TN "\Microsoft\WindowsUpdate\*" /Disable																																																																																																											REM ;youtube.com/@OptiProjects
echo Hecho!

echo.
echo - Optimizando el apartado visual...
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v KeyboardDelay /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v ListviewShadow /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v TaskbarAnimations /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f
reg add "HKCU\Control Panel\Desktop" /v EnableAeroPeek /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "0" /f
echo Hecho!

echo.
echo - Desactivando Teredo...
netsh interface teredo set state disabled
timeout /t 1 /nobreak>nul
echo Hecho!

echo.
echo - Deshabilitando la telemetria en tareas...
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\MareBackup" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Application Experience\PcaPatchDbTask" /Disable
schtasks /Change /TN "Microsoft\Windows\Maps\MapsUpdateTask" /Disable
echo Hecho!

echo.
echo - Deshabilitando la telemetria en el registro...
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
echo Hecho!

echo.
echo - Aplicando optimizaciones bcdedit...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
powercfg -h off >nul 2>&1
echo Hecho!

echo.
echo - Configurando correctamente el registro...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Affinity" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Background Only" /t REG_SZ /d "False" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Clock Rate" /t REG_DWORD /d 10000 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCmds" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxThreads" /t REG_DWORD /d 100 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v "MaxCollectionCount" /t REG_DWORD /d 32 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f																																																REM ;youtube.com/@OptiProjects
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v Start /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d "400" /f
timeout /t 1 /nobreak >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v IRPStackSize /t REG_DWORD /d 30 /f
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v HideSCAMeetNow /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d "2" /f
echo Hecho!
echo.

echo - Activando OptiVortex...
powercfg -h off >nul 2>&1
powercfg -import "%~dp0resources\Plan de Energia CPU\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
echo Hecho!

echo.
echo - Colocando servicios en modo "manual"
sc config "AJRouter" start= demand
sc config "ALG" start= demand
sc config "AppIDSvc" start= demand
sc config "AppMgmt" start= demand
sc config "AppReadiness" start= demand
sc config "AppXSvc" start= demand
sc config "Appinfo" start= demand
sc config "AssignedAccessManagerSvc" start= demand
sc config "AxInstSV" start= demand
sc config "BDESVC" start= demand
sc config "BTAGService" start= demand
sc config "BcastDVRUserService_*" start= demand
sc config "BluetoothUserService_*" start= demand
sc config "Browser" start= demand
sc config "CaptureService_*" start= demand
sc config "CertPropSvc" start= demand
sc config "ClipSVC" start= demand
sc config "ConsentUxUserSvc_*" start= demand
sc config "CredentialEnrollmentManagerUserSvc_*" start= demand
sc config "CscService" start= demand
sc config "DcpSvc" start= demand
sc config "DevQueryBroker" start= demand
sc config "DeviceAssociationBrokerSvc_*" start= demand
sc config "DeviceAssociationService" start= demand
sc config "DeviceInstall" start= demand
sc config "DevicePickerUserSvc_*" start= demand
sc config "DevicesFlowUserSvc_*" start= demand
sc config "DisplayEnhancementService" start= demand
sc config "DmEnrollmentSvc" start= demand
sc config "DsSvc" start= demand
sc config "DsmSvc" start= demand
sc config "EFS" start= demand
sc config "EapHost" start= demand
sc config "EntAppSvc" start= demand
sc config "FDResPub" start= demand
sc config "Fax" start= demand
sc config "FrameServer" start= demand
sc config "FrameServerMonitor" start= demand
sc config "GraphicsPerfSvc" start= demand
sc config "HomeGroupListener" start= demand
sc config "HomeGroupProvider" start= demand
sc config "HvHost" start= demand
sc config "IEEtwCollectorService" start= demand
sc config "IKEEXT" start= demand
sc config "InstallService" start= demand
sc config "InventorySvc" start= demand
sc config "IpxlatCfgSvc" start= demand
sc config "KtmRm" start= demand
sc config "LicenseManager" start= demand
sc config "LxpSvc" start= demand
sc config "MSDTC" start= demand
sc config "MSiSCSI" start= demand
sc config "McpManagementService" start= demand
sc config "MessagingService_*" start= demand
sc config "MicrosoftEdgeElevationService" start= demand
sc config "MixedRealityOpenXRSvc" start= demand
sc config "NPSMSvc_*" start= demand
sc config "NaturalAuthentication" start= demand
sc config "NcaSvc" start= demand
sc config "NcbService" start= demand
sc config "NcdAutoSetup" start= demand
sc config "NetSetupSvc" start= demand
sc config "Netman" start= demand
sc config "NgcCtnrSvc" start= demand
sc config "NgcSvc" start= demand
sc config "NlaSvc" start= demand
sc config "P9RdrService_*" start= demand
sc config "PNRPAutoReg" start= demand
sc config "PNRPsvc" start= demand
sc config "PeerDistSvc" start= demand
sc config "PenService_*" start= demand
sc config "PerfHost" start= demand
sc config "PhoneSvc" start= demand
sc config "PimIndexMaintenanceSvc_*" start= demand
sc config "PlugPlay" start= demand
sc config "PolicyAgent" start= demand
sc config "PrintNotify" start= demand
sc config "PrintWorkflowUserSvc_*" start= demand
sc config "PushToInstall" start= demand
sc config "QWAVE" start= demand
sc config "RasAuto" start= demand
sc config "RasMan" start= demand
sc config "RetailDemo" start= demand
sc config "RmSvc" start= demand
sc config "RpcLocator" start= demand
sc config "SCPolicySvc" start= demand
sc config "SCardSvr" start= demand
sc config "SDRSVC" start= demand
sc config "SEMgrSvc" start= demand
sc config "SNMPTRAP" start= demand
sc config "SNMPTrap" start= demand
sc config "SSDPSRV" start= demand
sc config "ScDeviceEnum" start= demand
sc config "SecurityHealthService" start= demand
sc config "Sense" start= demand
sc config "SensorDataService" start= demand
sc config "SensorService" start= demand
sc config "SensrSvc" start= demand
sc config "SessionEnv" start= demand
sc config "SharedAccess" start= demand
sc config "SharedRealitySvc" start= demand
sc config "SmsRouter" start= demand
sc config "SstpSvc" start= demand
sc config "StiSvc" start= demand
sc config "TabletInputService" start= demand
sc config "TapiSrv" start= demand
sc config "TieringEngineService" start= demand
sc config "TimeBroker" start= demand
sc config "TimeBrokerSvc" start= demand
sc config "TokenBroker" start= demand
sc config "TroubleshootingSvc" start= demand
sc config "TrustedInstaller" start= demand
sc config "UI0Detect" start= demand
sc config "UdkUserSvc_*" start= demand
sc config "UmRdpService" start= demand
sc config "UnistoreSvc_*" start= demand
sc config "UserDataSvc_*" start= demand
sc config "VSS" start= demand
sc config "VacSvc" start= demand
sc config "W32Time" start= demand
sc config "WEPHOSTSVC" start= demand
sc config "WFDSConMgrSvc" start= demand
sc config "WMPNetworkSvc" start= demand
sc config "WManSvc" start= demand
sc config "WPDBusEnum" start= demand
sc config "WSService" start= demand
sc config "WaaSMedicSvc" start= demand
sc config "WalletService" start= demand
sc config "WarpJITSvc" start= demand
sc config "WbioSrvc" start= demand
sc config "WcsPlugInService" start= demand
sc config "WdNisSvc" start= demand
sc config "WdiServiceHost" start= demand
sc config "WdiSystemHost" start= demand
sc config "WebClient" start= demand
sc config "Wecsvc" start= demand
sc config "WerSvc" start= demand
sc config "WiaRpc" start= demand
sc config "WinHttpAutoProxySvc" start= demand
sc config "WinRM" start= demand
sc config "WpcMonSvc" start= demand
sc config "XblAuthManager" start= demand
sc config "XblGameSave" start= demand
sc config "XboxGipSvc" start= demand
sc config "XboxNetApiSvc" start= demand
sc config "autotimesvc" start= demand
sc config "bthserv" start= demand
sc config "camsvc" start= demand
sc config "cloudidsvc" start= demand
sc config "dcsvc" start= demand
sc config "defragsvc" start= demand
sc config "diagnosticshub.standardcollector.service" start= demand
sc config "diagsvc" start= demand
sc config "dmwappushservice" start= demand
sc config "dot3svc" start= demand
sc config "edgeupdate" start= demand
sc config "edgeupdatem" start= demand
sc config "embeddedmode" start= demand
sc config "fdPHost" start= demand
sc config "fhsvc" start= demand
sc config "hidserv" start= demand
sc config "icssvc" start= demand
sc config "lfsvc" start= demand
sc config "lltdsvc" start= demand
sc config "lmhosts" start= demand
sc config "msiserver" start= demand
sc config "netprofm" start= demand
sc config "p2pimsvc" start= demand
sc config "p2psvc" start= demand
sc config "perceptionsimulation" start= demand
sc config "pla" start= demand
sc config "seclogon" start= demand
sc config "smphost" start= demand
sc config "spectrum" start= demand
sc config "svsvc" start= demand
sc config "swprv" start= demand
sc config "upnphost" start= demand
sc config "vds" start= demand
sc config "vmicguestinterface" start= demand
sc config "vmicheartbeat" start= demand
sc config "vmickvpexchange" start= demand
sc config "vmicrdv" start= demand
sc config "vmicshutdown" start= demand
sc config "vmictimesync" start= demand
sc config "vmicvmsession" start= demand
sc config "vmicvss" start= demand
sc config "vmvss" start= demand
sc config "wbengine" start= demand
sc config "wcncsvc" start= demand
sc config "webthreatdefsvc" start= demand
sc config "wercplsupport" start= demand
sc config "wisvc" start= demand
sc config "wlidsvc" start= demand
sc config "wlpasvc" start= demand
sc config "wmiApSrv" start= demand
sc config "workfolderssvc" start= demand
sc config "wuauserv" start= demand
sc config "wudfsvc" start= demand
echo Hecho!

echo.
echo - Deshabilitando servicios innecesarios...
sc config "diagnosticshub.standardcollector.service" start= disabled
sc config "DiagTrack" start= disabled
sc config "DPS" start= disabled
sc config "FontCache" start= disabled
sc config "SystemUsageReportSvc_QUEENCREEK" start= disabled
sc config "GpuEnergyDrv" start= disabled
sc config "PcaSvc" start= disabled
sc config "ShellHWDetection" start= disabled
sc config "SgrmAgent" start= disabled
sc config "SgrmBroker" start= disabled
sc config "uhssvc" start= disabled
sc config "WdiServiceHost" start= disabled
sc config "WdiSystemHost" start= disabled
sc config "WSearch" start= disabled
sc config "diagsvc" start= disabled
echo Hecho!


echo.
echo - Aplicando la optimizacion general en Regedit...
regedit /S "resources\General\Optimizacion General.reg"
regedit /S "resources\General\Mejorar La Velocidad del Menu.reg"
echo Hecho!
timeout /t 2 /nobreak>nul

pause
timeout /t 3 /nobreak >nul
goto :DoneXtreme

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
echo *3 - Regresar al menu
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
if "%defop%"=="3" goto :Start
if "%defop%"=="Devmode--Yes" goto :ConfirmDev
if "%defop%"=="Secrets--AlphaMode" goto :AlphaEasterEgg
if "%defop%"=="Secrets--Konami" goto :CheckDefStatus
goto :Start

:AlphaEasterEgg
:AlphaEasterEgg
cls
echo - Activando...
timeout /t 2 /nobreak >nul
start "" "%~dp0scassets\oldage\main.bat"
exit

:ConfirmXtremeOpti2
:ConfirmXtremeOpti2
cls
echo This can damage your Windows! Esto puede dañar tu Windows!
set /p option="SURE?! (Y/N) "

if /I "%option%"=="Y" goto XtremeOpti
if /I "%option%"=="YES" goto XtremeOpti
if /I "%option%"=="N" goto Xtreme
if /I "%option%"=="NO" goto Xtreme

:: Este codigo originalmente fue removido en la 3.5/3.6, pero regreso como un Easter Egg
:CheckDefStatus
:CheckDefStatus
cls
echo ==================================================
echo            Estado de Win Defender
echo ==================================================
echo.
echo Comprobando el estado de Windows Defender...
echo.
echo.
powershell -Command "if ((Get-MpComputerStatus).RealTimeProtectionEnabled) { exit 0 } else { exit 1 }"
if %errorlevel%==0 (
    cls
    echo ==================================================
    echo                 Defender
    echo ==================================================
    echo.
    echo Windows Defender esta ACTIVADO! :)
    echo.
    echo NOTA: Este script no funciona bien, puede dar falsos
    echo datos, proximamente encontrare el error :)
	echo.
	pause
	goto :Start
) else (
    cls
    echo ==================================================
    echo                 Defender
    echo ==================================================
    echo.
    echo Windows Defender esta DESACTIVADO :(
    echo.
    echo NOTA: Este script no funciona bien, puede dar falsos
    echo datos, proximamente encontrare el error :)
	echo.
	pause
	goto :Start
)

:DefOff
:DefOff
cls
echo ==================================================
echo             Desactivar Defender
echo ==================================================
echo.
echo - Deshabilitando Windows Defender...

regedit /S "resources\Windows Defender\Deshabilitar Defender.reg"

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
echo Hecho :D
timeout /t 3 /nobreak
goto :Start

:DefOn
:DefOn
cls
echo ==================================================
echo            Activar Defender
echo ==================================================
echo.
echo - Habilitando Windows Defender...

regedit /S "resources\Windows Defender\Revertir Cambios.reg"

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
echo Hecho :D
timeout /t 3 /nobreak
goto :Start

:ReduceRestaurationPoints
:ReduceRestaurationPoints
cls
echo - Reduciendo la cantidad de puntos de restauracion del sistema...
pause

:: Establecer el tamano maximo para los puntos de restauracion (en GB)
:: El valor predeterminado es 5GB, puedes ajustarlo segun sea necesario (por ejemplo, 2GB para menos espacio)
set pointsize=3

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
echo - Deshabilitando la indexacion de archivos...
pause

:: Detener el servicio de busqueda de Windows (Windows Search)
net stop "Windows Search"

:: Deshabilitar el servicio para que no se inicie con Windows
sc config "WSearch" start= disabled

echo Hecho!
echo.
pause
goto :Start

:ResetMemoryDump
:ResetMemoryDump
cls
echo Presione una tecla para continuar con la optimizacion...
pause>nul
echo.
echo - Eliminando archivos de volcado de memoria...
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
pause>nul
echo.
echo - Eliminando archivos de actualizaciones fallidas de Windows...
pause

:: Detener el servicio de Windows Update
net stop wuauserv
net stop wuaserv

:: Eliminar el contenido de las carpetas de actualización
del /f /s /q C:\Windows\SoftwareDistribution\Download\*
del /f /s /q C:\Windows\SoftwareDistribution\DataStore\*

:: Reiniciar el servicio de Windows Update
net start wuauserv

echo Hecho!
pause
goto :Start


:ResetExplorer
:ResetExplorer
cls
echo Presiona cualquier tecla para continuar con la optimizacion...
echo.
echo - Reiniciando Windows Explorer...

:: Esperar un momento para apagar
timeout /t 2 /nobreak>nul

:: Detener el proceso de Windows Explorer
taskkill /f /im explorer.exe

:: Esperar un momento antes de reiniciar
timeout /t 2 /nobreak >nul

:: Reiniciar Windows Explorer
start explorer.exe

echo Hecho!
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
echo *6 - Wu10Man
echo *7 - Eliminar logs generadas por el Script
echo *8 - ADB AppControl
echo *9 - WinRAR
echo *10 - SuperF4
echo *11 - Regresar al menu
echo.

set /p toolop=Opcion: 
if "%toolop%"=="" goto :Tools
if "%toolop%"=="1" goto :UpdOptiTool
if "%toolop%"=="2" goto :AutoKeyboard
if "%toolop%"=="3" goto :AutoClicker
if "%toolop%"=="4" goto :UninsTool
if "%toolop%"=="5" goto :DriverBooster
if "%toolop%"=="6" goto :Wu10Man
if "%toolop%"=="7" goto :DeleteLogs
if "%toolop%"=="8" goto :ADBAppControl
if "%toolop%"=="9" goto :WinRAR
if "%toolop%"=="10" goto :SuperF4
if "%toolop%"=="11" goto :Start
if "%toolop%"=="Secrets--Roblauncher" goto RobLauncherDown
if "%toolop%"=="Devmode--Yes" goto :ConfirmDev
if "%toolop%"=="reset" goto :ResetScript
goto :Tools

:SuperF4
:SuperF4
cls
echo ==================================================
echo                  SuperF4
echo ==================================================
echo.
:: Insercion de opciones
echo 1 - Ejecutar SuperF4
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0scassets\utilities\superF4\SuperF4.exe"
	goto :Start
) else if "%option%"=="2" (
    goto :Tools
) else (
    echo Opcion no valida. Intente nuevamente.
    goto :SuperF4
)

goto :SuperF4

:WinRAR
:WinRAR
cls
echo ==================================================
echo                  WinRAR
echo ==================================================
echo.
:: Insercion de opciones
echo 1 - Ejecutar WinRAR
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0scassets\utilities\winRAR\WinRAR.exe"
	goto :Start
) else if "%option%"=="2" (
    goto :Tools
) else (
    echo Opcion no valida. Intente nuevamente.
    goto :Tools
)

goto :Tools

:ADBAppControl
:ADBAppControl
cls
echo ==================================================
echo               ADB AppControl
echo ==================================================
echo.
:: Insercion de opciones
echo 1 - Ejecutar ADB AppControl
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0scassets\utilities\appcontrol\ADBAppControl.exe"
	goto :Start
) else if "%option%"=="2" (
    goto :Tools
) else (
    echo Opcion no valida. Intente nuevamente.
    goto ADBAppControl
)

goto ADBAppControl

:Wu10Man
:Wu10Man
cls
echo ==================================================
echo                  Wu10Man
echo ==================================================
echo.
:: Insercion de opciones
echo 1 - Ejecutar Wu10Man
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0scassets\utilities\wu10man\Wu10Man.exe"
	goto :Start
) else if "%option%"=="2" (
    goto Start
) else (
    echo Opcion no valida. Intente nuevamente.
    goto Wu10Man
)

goto Start

:DeleteLogs
:DeleteLogs
cls
echo Presiona cualquier tecla para continuar...
pause>nul
echo - Borrando los archivos .log y .txt

REM Cambiar la ruta de la carpeta según tu necesidad
set "logFolder=%~dp0scassets\logs"

REM Verificar si la carpeta existe
if exist "%logFolder%" (
    REM Borrar todos los archivos en la carpeta logs
    del /q "%logFolder%\*.*"
    echo Hecho! Regresando al menu...
	timeout /t 3 /nobreak>nul
	goto :Start
) else (
    echo La carpeta Logs no existe, creando...
	:: Crea la carpeta de logs, para los .log xd
    mkdir "Assets\logs" >nul 2>&1	
	timeout /t 2 /nobreak>nul
	goto :Start
)

goto :Start

:DeleteSCache
:DeleteSCache
cls
echo Presiona cualquier tecla para continuar...
pause>nul
echo - Borrando la cache generada por el script...

net stop wuauserv
del /q /f /s C:\Windows\SoftwareDistribution\Download\* >nul
net start wuauserv

wsreset.exe

set "logFolder=%~dp0scassets\logs"
if exist "%logFolder%" (
    REM Borrar todos los archivos en la carpeta logs
    del /q "%logFolder%\*.*"
    echo Hecho! Regresando al menu...
	timeout /t 3 /nobreak>nul
	goto :Start
) else (
    echo La carpeta Logs no existe, creando...
	:: Crea la carpeta de logs, para los .log xd
    mkdir "Assets\logs" >nul 2>&1	
	timeout /t 2 /nobreak>nul
	goto :Start
)

echo Hecho!
pause

:AutoClicker
:AutoClicker
cls
echo ==================================================
echo                Auto Clicker
echo ==================================================
echo.
:: Insercion de opciones
echo 1 - Ejecutar Auto-Clicker
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0scassets\utilities\auto-clicker\AutoClicker.exe"
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
echo *3 - Musica
echo *4 - Regresar al menu
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
if "%extraop%"=="3" goto :Music
if "%extraop%"=="4" goto :Start
if "%extraop%"=="Konami" goto :Music
if "%extraop%"=="roblaunch" goto RobLauncherDown
if "%extraop%"=="devmode" goto ConfirmDev
goto :Extra

:AutoKeyboard
:AutoKeyboard
cls

:: Muestra el titulo
echo ==================================================
echo                Auto Keyboard
echo ==================================================
echo.
:: Insercion de opciones
echo 1 - Ejecutar Auto-Keyboard
echo 2 - Regresar al menu
echo.

:: Comando para insercion de opciones
set /p option=Opcion: 

if "%option%"=="1" (
    echo - Iniciando cliente...
	timeout /t 2 /nobreak >nul
    start "" "%~dp0scassets\utilities\auto-teclado\AutoKeyboard.exe"
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
echo - Desactivando las notificaciones de Windows...
powershell -Command "Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Value 0"
echo Notificaciones desactivadas.
pause
goto Start

:: Seccion de confirmaciones

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
if /I "%option%"=="4" start notepad "%~dp0main.bat"
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
goto DevOpt

:: Redirecciona al goto que escribas
:DGoto
:DGoto
cls
echo Direct Goto
echo Type "Escape" to exit
echo.
set /p option="Enter goto: "

:: Verificar si el usuario ha ingresado "exit" para salir
if /I "%option%"=="Escape" goto DevOpt

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
echo - Mostrando informacion detallada del sistema...
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
echo AVISO: Este codigo posee errores, por eso aun esta en Opciones de Desarrollador
echo Si quieres continuar, presiona cualquier tecla.
pause>nul
echo - Generando informe...

REM Obtiene la fecha actual en formato yyyy-mm-dd
for /f "tokens=2 delims==" %%I in ('"wmic OS Get localdatetime /value"') do set datetime=%%I
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%

REM Crea la variable 'todaydate' con la fecha en el formato deseado
set todaydate=%year%-%month%-%day%

REM Define la ruta del archivo con la fecha actual
set "reportFile=%~dp0scassets\logs\CheckReport-%todaydate%.txt"

echo OptiTool Checkup Report > "%reportFile%"
echo ================== >> "%reportFile%"
echo. >> "%reportFile%"

REM Agregar la fecha de hoy dentro del reporte
echo %todaydate% >> "%reportFile%"
echo. >> "%reportFile%"

echo Files in actual directory: >> "%reportFile%"
dir /b >> "%reportFile%"

REM Contar los archivos
set /a totalFiles=0
for /f %%A in ('dir /b ^| find /c /v ""') do set totalFiles=%%A

echo. >> "%reportFile%"
echo Summary: >> "%reportFile%"
echo Total files: %totalFiles% >> "%reportFile%"

echo Report saved as %reportFile%.
pause
goto :DevOpt


:RunTests
:RunTests
cls
echo Ejecutando pruebas...
set "testResults=%~dp0scassets\inf\test_results.txt"

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
echo Desactivated code - Under manteinance.
pause
goto :DevOpt




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


:: CON EL LADO POR UN LADO TOMANDO UN JARABE EXTRAÑO Y NUNCA JAMAS LE HABIA DADO Y AHORA NO QUIERO BAJAR :V

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
echo - Iniciando cliente...
timeout /t 1 /nobreak >nul

start "" "%~dp0update.bat"

timeout /t 2 /nobreak >nul
goto Start

:Music
:Music
:: Solo por esta version, musica en OptiTool 
cls
echo ==================================================
echo                 Musica
echo ==================================================
echo.
echo *1 - Corridos Tumbados
echo *2 - Hip - Hop
echo *3 - Canserbero
echo *4 - Regresar al menu
echo.

set /p extraop=Opcion: 
if "%extraop%"=="1" goto :CTMusic
if "%extraop%"=="2" goto :HipHopMC
if "%extraop%"=="3" goto :Canserbero
if "%extraop%"=="4" goto :Start
if "%extraop%"=="Secrets--RobLauncher" goto RobLauncherDown
if "%extraop%"=="devmode" goto ConfirmDev
if "%extraop%"=="reset" goto :ResetScript
if "%extraop%"=="Secrets--Option" start "" "%~dp0scassets\music\EasterEgg\FROMTHESTART.mp3"
if "%extraop%"=="Secrets--Konami" goto :MusicEasterEgg
if "%extraop%"=="Secrets--AlphaMode" goto :AlphaEasterEgg
goto :Music

:MusicEasterEgg
:MusicEasterEgg
cls
echo *1 - El vio-
echo *2 - Me hiciste daño me duele el a-
echo *3 - YO ME LA PASO PENSANDO EN CHAMBA
echo *4 - BENDECIDOS
echo *5 - From The Start
echo *6 - BZRP ft ACZINO
echo *7 - ???
echo *8 - My Compass is Curiosity
echo *9 - Girl A
echo *10 - Caramelldansen
echo *11 - Butcher Vanity
echo *12 - Regresar al menu
echo.

set /p extraop=Opcion: 
if "%extraop%"=="1" start "" "%~dp0scassets\music\EasterEgg\ELVIO.mp3"
if "%extraop%"=="2" start "" "%~dp0scassets\music\EasterEgg\MEHICISTEDANO.mp3"
if "%extraop%"=="3" start "" "%~dp0scassets\music\EasterEgg\YOMELAPASO.mp3"
if "%extraop%"=="4" start "" "%~dp0scassets\music\EasterEgg\BENDECIDOS.mp3"
if "%extraop%"=="5" start "" "%~dp0scassets\music\EasterEgg\FROMTHESTART.mp3"
if "%extraop%"=="6" start "" "%~dp0scassets\music\EasterEgg\ACZINO.mp3"
if "%extraop%"=="7" start "" "%~dp0scassets\music\EasterEgg\BADAPPLE.mp4"
if "%extraop%"=="8" start "" "%~dp0scassets\music\EasterEgg\GASHARPOON.mp3"
if "%extraop%"=="9" start "" "%~dp0scassets\music\EasterEgg\GIRLA.mp3"
if "%extraop%"=="10" start "" "%~dp0scassets\music\EasterEgg\CARAMELLDANSEN.mp3"
if "%extraop%"=="11" start "" "%~dp0scassets\music\EasterEgg\VANITY.mp3"
if "%extraop%"=="12" goto :Music
if "%extraop%"=="Secrets--Roblauncher" goto RobLauncherDown
if "%extraop%"=="Devmode--Yes" goto ConfirmDev
goto :Music

:Canserbero
:Canserbero
cls
echo ==================================================
echo                    Musica
echo ==================================================
echo.
echo *1 - Es Epico
echo *2 - Querer Querernos
echo *3 - Stupid Love Story
echo *4 - Visiones
echo *5 - Y la Felicidad que?
echo *6 - Maquiavelico
echo *7 - Llovia
echo *8 - Cest La Mort
echo *9 - Mundo de Piedra
echo *10 - Regresar al menu
echo.

set /p extraop=Opcion: 
if "%extraop%"=="" goto :Canserbero
if "%extraop%"=="1" goto :EsEpicoMP3
if "%extraop%"=="2" goto :QuererQuerernosMP3
if "%extraop%"=="3" goto :StupidLoveStoryMP3
if "%extraop%"=="4" goto :VisionesMP3
if "%extraop%"=="5" goto :YLaFelicidadMP3
if "%extraop%"=="6" goto :MaquiavelicoMP3
if "%extraop%"=="7" goto :LloviaMP3
if "%extraop%"=="8" goto :CestLaMortMP3
if "%extraop%"=="9" goto :MundoPiedraMP3
if "%extraop%"=="10" goto :Music
if "%extraop%"=="roblaunch" goto RobLauncherDown
if "%extraop%"=="devmode" goto ConfirmDev
if "%extraop%"=="Secrets--Konami" goto :MusicEasterEgg
goto :Canserbero

:MundoPiedraMP3
:MundoPiedraMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\MundoDePiedra.mp3"

timeout /t 2 /nobreak nul
goto Start

:CestLaMortMP3
:CestLaMortMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\CestLaMort.mp3"

timeout /t 2 /nobreak nul
goto Start

:LloviaMP3
:LloviaMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\Llovia.mp3"

timeout /t 2 /nobreak nul
goto Start

:MaquiavelicoMP3
:MaquiavelicoMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\Maquiavelico.mp3"

timeout /t 2 /nobreak nul
goto Start

:YLaFelicidadMP3
:YLaFelicidadMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\YLaFelicidad.mp3"

timeout /t 2 /nobreak nul
goto Start

:VisionesMP3
:VisionesMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\Visiones.mp3"

timeout /t 2 /nobreak nul
goto Start

:StupidLoveStoryMP3
:StupidLoveStoryMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\SLS.mp3"

timeout /t 2 /nobreak nul
goto Start

:EsEpicoMP3
:EsEpicoMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\EsEpico.mp3"

timeout /t 2 /nobreak nul
goto Start

:QuererQuerernosMP3
:QuererQuerernosMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\Canserbero\QuererQuerernos.mp3"

timeout /t 2 /nobreak nul
goto Start

:HipHopMC
:HipHopMC
cls
echo ==================================================
echo                    Musica
echo ==================================================
echo.
echo *1 - Mi Tio, "Snoop" - Aleman ft. Snoop Dogg
echo *2 - Rucon - Aleman
echo *3 - The Real Slim Shady - Eminem
echo *4 - Without Me - Eminem
echo *5 - Regresar al menu
echo.

set /p extraop=Opcion: 
if "%extraop%"=="1" goto :MiTioSnoopMP3
if "%extraop%"=="2" goto :RuConMP3
if "%extraop%"=="3" goto :TheRealSlimShadyMP3
if "%extraop%"=="4" goto :WithoutMeMP3
if "%extraop%"=="5" goto :Start
if "%extraop%"=="roblaunch" goto RobLauncherDown
if "%extraop%"=="devmode" goto ConfirmDev
if "%extraop%"=="Secrets--Konami" goto :MusicEasterEgg
goto :HipHopMC

:WithoutMeMP3
:WithoutMeMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\HipHop\WithoutMe.mp3"

timeout /t 2 /nobreak nul
goto Start

:TheRealSlimShadyMP3
:TheRealSlimShady
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\HipHop\TheRealSlimShady.mp3"

timeout /t 2 /nobreak nul
goto Start


:MiTioSnoopMP3
:MiTioSnoopMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\HipHop\MiTioSnoop.mp3"

timeout /t 2 /nobreak >nul
goto Start

:RuConMP3
:RuConMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\HipHop\RuCon.mp3"

timeout /t 2 /nobreak >nul
goto Start

:CTMusic
:CTMusic
cls
echo ==================================================
echo      Corridos tumbados/Regional mexicano
echo ==================================================
echo.
echo *1 - O Me Voy O Te Vas - Natanael Cano
echo *2 - El Drip - Natanael Cano
echo *3 - El Lokeron - Tito Double P
echo *4 - Loco - Neton Vega
echo *5 - PRESIDENTE - Gabito Ballesteros, Neton Vega, etc.
echo *6 - ROSONES - Tito Double P 
echo *7 - PRIMO - Natanael Cano, Tito Double P 
echo *8 - LA PATRULLA - Peso Pluma, Neton Vega
echo *9 - LINDA - Tito Double P, Neton Vega
echo *10 - Tu Boda - Oscar Maydon, Fuerza Regida
echo *11 - Que Onda - Fuerza Regida, Calle 24, Chino Pacas
echo *12 - Regresar al menu

set /p extraop=Opcion: 
if "%extraop%"=="1" goto :OMeVoyMP3
if "%extraop%"=="2" goto :ElCreepMP3
if "%extraop%"=="3" goto :ELLOKERONMP3
if "%extraop%"=="4" goto :LocoMP3
if "%extraop%"=="5" goto :PRESIDENTEMP3
if "%extraop%"=="6" goto :ROSONESMP3
if "%extraop%"=="7" goto :PRIMOMP3
if "%extraop%"=="8" goto :LAPATRULLAMP3
if "%extraop%"=="9" goto :AYLINDAMP3
if "%extraop%"=="10" goto :TUBODAMP3
if "%extraop%"=="11" goto :QUEONDAMP3
if "%extraop%"=="12" goto :Music
if "%extraop%"=="roblaunch" goto RobLauncherDown
if "%extraop%"=="devmode" goto ConfirmDev
if "%extraop%"=="UpUpDownDownLeftRightLeftRightBAStart" goto :MusicEasterEgg
goto :CTMusic

:QUEONDAMP3
:QUEONDAMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\QueOnda.mp3"

timeout /t 2 /nobreak nul
goto Start

:TUBODAMP3
:TUBODAMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\TUBODA.mp3"

timeout /t 2 /nobreak nul
goto Start

:AYLINDAMP3
:AYLINDAMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\LINDA.mp3"

timeout /t 2 /nobreak nul
goto Start

:LAPATRULLAMP3
:LAPATRULLAMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\LAPATRULLA.mp3"

timeout /t 2 /nobreak nul
goto Start

:PRIMOMP3
:PRIMOMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\PRIMO.mp3"

timeout /t 2 /nobreak nul
goto Start

:PRESIDENTEMP3
:PRESIDENTEMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\PRESIDENTE.mp3"

timeout /t 2 /nobreak nul
goto Start

:LocoMP3
:LocoMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\Loco.mp3"

timeout /t 2 /nobreak nul
goto Start

:ROSONESMP3
:ROSONESMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\ROSONES.mp3"

timeout /t 2 /nobreak >nul
goto Start

:ELLOKERONMP3
:ELLOKERONMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\ELLOKERON.mp3"

timeout /t 2 /nobreak >nul
goto Start

:OMeVoyMP3
:OMeVoyMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\OMeVoyOTeVas.mp3"

timeout /t 2 /nobreak >nul
goto Start

:ElCreepMP3
:ElCreepMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\ElDrip.mp3"

timeout /t 2 /nobreak >nul
goto Start

:AmorTumbadoMP3
:AmorTumbadoMP3
cls
echo - Iniciando...
timeout /t 1 /nobreak >nul

start "" "%~dp0scassets\music\CT\AmorTumbado.mp3"

timeout /t 2 /nobreak >nul
goto Start


:: Esta version de :lite, directamente quita el pause, haciendo que la optimizacion sea continua
:LiteCustom
:LiteCustom
cls
regedit /S "appearance\Deshabilitar Animaciones.reg"
regedit /S "appearance\Deshabilitar Cortana.reg"
regedit /S "appearance\Deshabilitar Transparencias.reg"
regedit /S "appearance\Deshabilitar Centro Acciones.reg"

takeown /F "%WINDIR%\WinSxS" /R /A
icacls "%WINDIR%\WinSxS" /grant *S-1-3-4:F /t /c /l /q
takeown /F "%WINDIR%\System32\Recovery" /R /A
icacls "%WINDIR%\System32\Recovery" /grant *S-1-3-4:F /t /c /l /q

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

del /S /F /Q "%WINDIR%\System32\Recovery"
echo.
del /S /F /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender\Definition Updates"

powershell Get-AppxPackage -AllUsers | Where-Object { $_.Name -notlike "*store*" } | Remove-AppxPackage

start "" "%~dp0scassets\utilities\screen.bat"

start "" "%~dp0scassets\utilities\FastTempDel.bat"

goto :DoneXtreme

:: Recorta el sistema
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
echo  En pocas palabras, tu sistema operativo se recortara
echo  lo que puede generar fallos
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
regedit /S "appearance\Deshabilitar Animaciones.reg"
regedit /S "appearance\Deshabilitar Cortana.reg"
regedit /S "appearance\Deshabilitar Transparencias.reg"
regedit /S "appearance\Deshabilitar Centro Acciones.reg"
echo.
echo - Consiguiendo acceso a WinSxS...
echo.
takeown /F "%WINDIR%\WinSxS" /R /A
icacls "%WINDIR%\WinSxS" /grant *S-1-3-4:F /t /c /l /q
takeown /F "%WINDIR%\System32\Recovery" /R /A
icacls "%WINDIR%\System32\Recovery" /grant *S-1-3-4:F /t /c /l /q
echo - Borrando Componentes WinSxS...
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
echo - Borrando Sys Recovery...
del /S /F /Q "%WINDIR%\System32\Recovery"
echo.
echo - Borrando Defender...
del /S /F /Q "%SystemDrive%\ProgramData\Microsoft\Windows Defender\Definition Updates"
echo.
echo - Borrando Apps UWP...
echo.
powershell Get-AppxPackage -AllUsers | Where-Object { $_.Name -notlike "*store*" } | Remove-AppxPackage

start "" "%~dp0scassets\utilities\screen.bat"

start "" "%~dp0scassets\utilities\FastTempDel.bat"

goto :DoneLite


:Creds
:Creds
cls
echo - Iniciando herramienta de creditos...
echo.
start "" "%~dp0scassets\utilities\creds.bat"

timeout /t 2 /nobreak >nul
goto :Start

:Sysinfo
:Sysinfo
cls
echo - Iniciando SystemInfo...
echo.
start "" "%~dp0scassets\utilities\sysinfo.bat"

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
echo CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo ==================================================
timeout /t 10 /nobreak>nul
start "" "%~dp0scassets\msg\message_lite.vbs"
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
echo CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo By OptiStudio
echo.
echo ==================================================
pause
start "" "%~dp0scassets\msg\message_lite.vbs"
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
echo CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo By OptiStudio
echo.
echo ==================================================
pause
start "" "%~dp0scassets\msg\message_lite.vbs"
goto Ext1

:DoneDeletedRespoint
:DoneDeletedRespoint
cls
echo ==================================================
echo  Puntos de restauracion eliminados correctamente
echo ==================================================
echo.
echo Todos sus puntos de restauracion han sido eliminados
echo Recomiendo crear otro despues de esto ya que se elimino
echo hasta el primer punto de restauracion creado despues de la
echo instalacion de Windows.
echo.
echo CUALQUIER FALLO NO ME HAGO RESPONSABLE ! ! !
echo.
echo By OptiStudio
echo.
echo ==================================================
pause
start "" "%~dp0scassets\msg\message_lite.vbs"
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
echo Presione una tecla para salir del script...
pause >nul
exit

:ForceExt
:ForceExt
exit

:: Este programa es de uso abierto y puede ser modificado por todos. Solo no olvides darle creditos a su creador, OptiStudio.
:: Gracias a OptiJuegos.

rem If you downloaded this program outside of the official GitHub, check your computer because, it may be a virus.

rem -By OptiStudio

rem - - - - - - - - - - - - - - - - - - - - - - - -

rem MIT License

rem Copyright (c) 2025 OptiStudioXD

rem Permission is hereby granted, free of charge, to any person obtaining a copy
rem of this software and associated documentation files (the "Software"), to deal
rem in the Software without restriction, including without limitation the rights
rem to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
rem copies of the Software, and to permit persons to whom the Software is
rem furnished to do so, subject to the following conditions:

rem The above copyright notice and this permission notice shall be included in all
rem copies or substantial portions of the Software.

rem THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
rem IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
rem FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
rem AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
rem LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
rem OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
rem SOFTWARE.

rem - - - - - - - - - - - - - - - - - - - - - - - -	 

rem Project: OptiTool - OptiStudio - Creator of OptiTool
rem                     Luisreach17 - Creator of OptiStudio
rem O                   Chris Titus - Code in OptiTool (20%) (No official helper)
rem P                   OptiJuegos (Optimizar PC) - Original Idea
rem T
rem I          - OptiStudio
rem T
rem O
rem O
rem L
rem


:: https://github.com/OptiStudioXD/OptiTool
:: https://github.com/OptiStudioXD

:: https://github.com/OptiJuegos
:: https://optijuegos.github.io
:: https://youtube.com/@OptiJuegos

REM FUTUROS PROYECTOS:

:: Nexus Launcher = Combinacion entre OptiTool y un script batch de herramientas, basado en Roblauncher
:: Project: Anima = "Juego de ritmo", combinacion de Friday Night Funkin y osu! (Inicia en 2026)
:: Litebatch = Cliente de herramientas diseñadas para un script batch, combinacion entre 7z.exe, wget.exe, ffplay.exe, blat.exe, etc.
:: Y2Media = Cliente batch/ejecutable para descargar videos de YouTube, Facebook, etc. Basado en y2mate.nu
:: OnePlayer = Herramienta para Windows, Linux y Android, diseñada para reproducir audio y video, soportando formatos unicos.
:: OptiTool = Convertir OptiTool en algo oficial, en vez de un simple proyecto, mudando de un script batch a un .jar o .exe

:: Palabras anti-copyright:
rem femboy
rem nosexd
rem optijuegos me protege (no)
rem optistudio me bendice
rem luisreach17 vigila
rem perro anticopyright
rem gato anticopyright
