@echo off
title RobLauncher Downloader
color 0A
setlocal

:: Definir el enlace y la ubicación de descarga
set WGET=wget
set URL=https://github.com/OptiJuegos/RobLauncher/releases/download/1.91/RobLauncher.Release.V1.91.zip
set OUTPUT_DIR=%~dp0Downloaded

:: Crear la carpeta Downloaded si no existe
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

:menu
cls
echo ================================
echo       Menu Principal
echo ================================
echo 1. Descargar RobLauncher
echo 2. Salir
echo.
set /p choice="Selecciona una opcion (1-2): "

if "%choice%"=="1" goto download
if "%choice%"=="2" exit

echo Opcion no valida. Intenta de nuevo.
pause
goto menu

:download
cls
echo ================================
echo     Descargando RobLauncher
echo ================================
echo.

%WGET% -q --no-check-certificate --show-progress --connect-timeout=15 --tries=3 -P "%OUTPUT_DIR%" "%URL%"

echo.
echo Presiona cualquier tecla para volver al menu...
pause >nul
goto menu
