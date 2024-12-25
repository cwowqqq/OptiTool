${SegmentFile}

!define CUSTOM_APPDIR '$AppDirectory\DriverBooster'

Var CUSTOM_LOGGEDINUSER
Var CUSTOM_BOL_HWINFO
Var CUSTOM_HWINFOFILE

!include x64.nsh


${SegmentPre}
	StrCpy $0 LOCALLOWAPPDATA
	ReadRegStr $1 HKCU 'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders' {A520A1A4-1780-4FF6-BD18-167343C5AF16}
	${DebugMsg} "Setting environment variable $0 to $1"
	System::Call Kernel32::SetEnvironmentVariable(tr0,tr1)
!macroend

${SegmentPrePrimary}
	${If} ${RegistryKeyExists} 'HKLM\SYSTEM\CurrentControlSet\services\HWiNFO32'
		StrCpy $CUSTOM_BOL_HWINFO '1' ; we'll use local service
	${Else}
		StrCpy $CUSTOM_BOL_HWINFO '0'
		nsExec::ExecToStack	'"${CUSTOM_APPDIR}\HWiNFO\HWiNFO.exe" /brandname'
	${EndIf}
	
     ; "changing backup and download folders To prevent moving them to programData Always if did not change by User befor"
	
     ReadINIStr $0 "$DataDirectory\DriverBooster\Config.ini" Drivers DownPath ;download driver path
     ${IfNotThen} ${FileExists} "$0" ${|} WriteINIStr "$DataDirectory\DriverBooster\Config.ini" Drivers DownPath "$EXEDIR\Drivers\Download\" ${|} 

     ReadINIStr $0 "$DataDirectory\DriverBooster\Config.ini" Drivers BackPath ;bakup driver path
     ${IfNotThen} ${FileExists} "$0" ${|}  WriteINIStr "$DataDirectory\DriverBooster\Config.ini" Drivers BackPath "$EXEDIR\Drivers\Backups\" ${|} 
	
!macroend

${SegmentPreSecondary}
     ReadINIStr $0 "$EXEDIR\App\AppInfo\Launcher\${AppID}.ini" Launch SingleAppInstance
     ${If} $0 != false
         MessageBox MB_ICONSTOP|MB_SETFOREGROUND $(LauncherAlreadyRunning)
	 Abort
     ${EndIf}
!macroend
${SegmentPostPrimary}

	System::Call "advapi32::GetUserName(t .r0, *i ${NSIS_MAX_STRLEN} r1) i.r2"
	StrCpy $CUSTOM_LOGGEDINUSER $0

	${IfThen} ${RunningX64} ${|} ${DisableX64FSRedirection} ${|}
	
		${If} ${FileExists} '$SYSDIR\Tasks\Driver Booster SkipUAC ($CUSTOM_LOGGEDINUSER)'
			nsExec::ExecToStack '$SYSDIR\SCHTASKS.EXE /Delete /TN "Driver Booster SkipUAC ($CUSTOM_LOGGEDINUSER)" /F'
		${EndIf}

		${If} ${FileExists} '$SYSDIR\Tasks\Driver Booster Scheduler'
			nsExec::ExecToStack '$SYSDIR\SCHTASKS.EXE /Delete /TN "Driver Booster Scheduler" /F'
		${EndIf}

	${IfThen} ${RunningX64} ${|} ${EnableX64FSRedirection} ${|}
	

	${If} $CUSTOM_BOL_HWINFO != '1'
		
		ReadRegStr $0 HKLM 'SYSTEM\CurrentControlSet\services\HWiNFO32' ImagePath
		StrCpy $1 $0 4
		${If} $1 == "\??\"
			StrCpy $CUSTOM_HWINFOFILE $0 "" 4 ;fix path of eg. "\??\C:\Windows\system32\drivers\HWiNFO32.SYS"
		${Else}
			StrCpy $CUSTOM_HWINFOFILE $0
		${EndIf}
		
		nsExec::ExecToStack '"$SYSDIR\SC.EXE" STOP HWiNFO32'
		nsExec::ExecToStack '"$SYSDIR\SC.EXE" DELETE HWiNFO32'
		
		DeleteRegKey HKLM 'SYSTEM\ControlSet001\services\HWiNFO32'
		DeleteRegKey HKLM 'SYSTEM\CurrentControlSet\services\HWiNFO32'
		
		Delete '$CUSTOM_HWINFOFILE'
	${EndIf}
!macroend
	 