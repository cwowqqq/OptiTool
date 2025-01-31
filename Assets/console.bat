@echo off
title OptiTool CMD

:: Establecer rutas
cd /d "%~dp0"
set C_DIR=%CD%

:MENU
cls
echo OptiStudio/OptiTool [Build 4.00001.20]
echo Copyright (c) 2025 OptiStudioXD
echo.
set /p COMMAND="$bios\%C_DIR%>

if "%COMMAND%"=="version" call :version
if "%COMMAND%"=="update" call :update

:update
echo Starting...
timeout /t 1 /nobreak >nul
start "" "%~dp0update.bat"
timeout /t 3 /nobreak >nul
goto :MENU

:version
cls
echo Downloaded version: 4.0
echo.
echo OptiCore Info:
echo OptiBuild: nan
echo OptiCore Version: nan
echo OptiKernel Version: nan
echo.
echo Build Info: 
echo Build 4.00000010.1011
echo Version: 4.0 Rev A
echo Kernel: nan
echo.
echo Linux Info:
echo Linux Compatibility: no
echo Linux Build: no
pause>nul
goto menu



