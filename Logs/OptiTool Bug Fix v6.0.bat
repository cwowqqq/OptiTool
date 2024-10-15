@echo off
title OptiTool Bug Fix
color 0A

:menu
cls
echo ================================
echo       OptiTool Bug Fix
echo ================================
echo 1. Soluciones
echo 2. Creditos
echo 3. Ayuda
echo 4. Niveles de errores
echo 5. Salir
echo ================================
set /p option=Seleccione una opcion [1-4]: 

if "%option%"=="1" goto solutions
if "%option%"=="2" goto creds
if "%option%"=="3" goto help
if "%option%"=="4" goto scale
if "%option%"=="5" exit

echo Opcion no valida. Intente de nuevo.
pause
goto menu

:scale
cls
echo ================================
echo   Escala de nivel de errores
echo ================================
echo.
echo (0x*) Errores de nivel 1 (Bajos)
echo (1x*) Errores de nivel 2 (Medios)
echo (2x*) Errores de nivel 3 (Medios-altos)
echo (3x*) Errores de nivel 4 (Altos)
echo (4x*) Errores de nivel 5 (Altos-criticos)
echo (5x*) Errores de nivel 6 (Criticos)
echo (6x*) Errores de nivel 7 (Criticos-irreparables)
echo (7x*) Errores de nivel 8 (Irreparables)
echo.
echo Errores extra:
echo (0k*) Errores de nivel Anonymous (Se desconoce su causa)
echo (0c*) Errores de nivel Hardware (Tu PC no acepta las optis)
echo (0p*) Errores de nivel Software (Tu version de Windows no acepta los comandos)
echo (0shell*) Errores de nivel PowerShell (Tu version de PowerShell no acepta los comandos)

pause
goto menu

:solutions
cls
echo ================================
echo         Soluciones
echo ================================
echo 1. Error: No inicia (1x1) - Solucion: Ejecute el script como administrador.
echo 2. Error: El script no abre (1x2) - Solucion: Reinstale el script.
echo 3. Error: Inicia pero sin contenido (3x1) - Solucion: Descargue una version anterior o espere al parche
echo 4. Error: No aplica las optis (5x1) - Solucion: Descargue una version anterior y reportelo mediante el canal de Youtube
echo.
pause
goto menu

:creds
cls
echo ================================
echo.
echo Creditos:
echo Creador: OptiStudio
echo Version de BugFixer: 6.3
echo Version del script: 3.0
echo.
echo ================================
pause
goto menu

:help
cls
echo ================================
echo             Ayuda
echo ================================
echo Este script ofrece soluciones a errores comunes.
echo Para cualquier duda, contacte a "[GMAIL CAIDO]"
echo ================================
pause
goto menu
