@echo off
title script
color 0A

if not exist "%log_dir%" (
    mkdir "%log_dir%"
)

:: Muestra el menu principal
:menu
cls
echo ================================
echo          Creditos 
echo ================================
echo 1. Mostrar Creditos
echo 2. Salir
echo.

:: Insercion de opciones
set /p choice="Opcion: "


:: Para los comandos
if "%choice%"=="1" goto credits
if "%choice%"=="2" goto exit
if "%choice%"=="3" goto exit
echo Opcion no valida. Intenta de nuevo.
pause
goto menu

:: Creditos
:credits
cls
echo ================================
echo           Creditos
echo ================================
echo.
echo Creditos:
echo.
echo Creador: OptiStudio
echo Version del script: 4.0 "XMAS!" 
echo Gmail: optistudio.xd@hotmail.com
echo.
echo OptiStudio YouTube: https://www.youtube.com/channel/UCwPlfaBfRgrAqPe8rZZmQew
echo.
echo ================================
echo.
pause
goto menu


:: Para salir del script
:exit
cls
echo Saliendo del script...
timeout /t 2 > nul
exit
