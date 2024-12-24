@echo off
title script

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

:: Eliminar archivos temporales del usuario y del sistema
del /S /F /Q "%temp%"
del /S /F /Q "%WINDIR%\Temp\*.*"
del /S /F /Q "%WINDIR%\Prefetch\*.*"
del /S /F /Q "%WINDIR%\Logs\*.log"
del /S /F /Q "%WINDIR%\SoftwareDistribution\Download\*.*"
del /S /F /Q "%WINDIR%\SoftwareDistribution\DataStore\*.*"
del /S /F /Q "%WINDIR%\SoftwareDistribution\*.bak"
del /S /F /Q "%WINDIR%\Microsoft.NET\*.*"
del /S /F /Q "%WINDIR%\Panther\*.*"
del /S /F /Q "%WINDIR%\Logs\MoSetup\*.*"
del /S /F /Q "%WINDIR%\inf\*.log"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Temp\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\SettingSync\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Terminal Server Client\Cache\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Search\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Packages\Microsoft.Windows.Cortana_*\LocalState\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\History\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Recent\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*"
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\Cache\*.*"
:: Elimina la cache y datos de Updates (puede interrumpir logs)
del /S /F /Q "%WINDIR%\SoftwareDistribution\Download\*.*"
del /S /F /Q "%WINDIR%\SoftwareDistribution\DataStore\*.*"
del /S /F /Q "%WINDIR%\SoftwareDistribution\*.bak"

:: Eliminar archivos de las aplicaciones de la Tienda Windows
del /S /F /Q "%SystemDrive%\Users\%USERNAME%\AppData\Local\Packages\Microsoft.WindowsStore_*\LocalState\*.*"

:: Limpiar registros de eventos (opcional)
wevtutil cl Application
wevtutil cl Security
wevtutil cl System

:: Eliminar archivos temporales del sistema de seguridad
del /S /F /Q "%ProgramData%\Microsoft\Windows Defender\Scans\Temp\*.*"
del /S /F /Q "%ProgramData%\Microsoft\Windows Defender\LocalCopy\*.*"

:: Asegurarse de que todo haya sido eliminado correctamente
timeout /t 5 /nobreak
echo Proceso completado.
exit

:: xd