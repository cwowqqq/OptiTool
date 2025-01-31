@echo off

:DesMSSync
:DesMSSync
cls
echo ==================================================
echo         Desactivar sincronizacion
echo ==================================================
echo.
echo Iniciando la herramienta de limpieza de disco...
timeout /t 1 /nobreak >nul

:: Desactivar la sincronización de la cuenta de Microsoft

:: Desactiva la sincronización de configuraciones de la cuenta Microsoft en el registro
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353388Enabled" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AccountSettings" /v "DisableMicrosoftAccountSync" /t REG_DWORD /d "1" /f

:: Mensaje indicando que se desactivó la sincronización
echo La sincronización de la cuenta de Microsoft ha sido desactivada.
pause
exit
