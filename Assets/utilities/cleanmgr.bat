@echo off
title cleanmgr

:CleanMGR
:CleanMGR
cls
echo ==================================================
echo              Limpiar disco duro
echo ==================================================
echo.
echo Iniciando la herramienta de limpieza de disco...
timeout /t 1 /nobreak >nul

:: Comando para iniciar el programa
cleanmgr /sagerun:1

pause
exit