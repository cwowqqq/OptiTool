@echo off
title script
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
	
    :: Cambiar el fondo de pantalla a una imagen negra para ahorrar bateria
    set "imagePath=%~dp0screen\black.png"
    if not exist "%imagePath%" (
        echo Error: No se encuentra la imagen en "%imagePath%".
        echo Asegurate de que el archivo "black.png" este en la carpeta "screen".
        exit /B
    )

    :: Cambiar fondo de pantalla
    echo Cambiando el fondo de pantalla a una imagen negra...
    reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%imagePath%" /f
    rundll32.exe user32.dll,UpdatePerUserSystemParameters

    :: Espera antes de salir
    timeout /t 5 /nobreak >nul
    exit