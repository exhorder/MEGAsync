; Script generated by the HM NIS Edit Script Wizard.

RequestExecutionLevel user

#!define BUILD_UNINSTALLER
#!define BUILD_X64_VERSION

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "MEGAsync"
!define PRODUCT_VERSION "1.0.34"
!define PRODUCT_PUBLISHER "Mega Limited"
!define PRODUCT_WEB_SITE "http://www.mega.co.nz"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\MEGAsync.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"
!define CSIDL_STARTUP '0x7' ;Startup path
!define CSIDL_LOCALAPPDATA '0x1C' ;Local Application Data path
!define CSIDL_COMMON_APPDATA '0x23'

!ifdef BUILD_X64_VERSION
!define SRCDIR_MEGASYNC "Release_x64\MEGAsync\release"
!else
!define SRCDIR_MEGASYNC "Release_x32\MEGAsync\release"
!endif

!define SRCDIR_MEGASHELLEXT_X32 "Release_x32\MEGAShellExt\release"
!define SRCDIR_MEGASHELLEXT_X64 "Release_x64\MEGAShellExt\release"
!define MULTIUSER_MUI
!define MULTIUSER_EXECUTIONLEVEL Standard
!define MULTIUSER_EXECUTIONLEVEL_ALLUSERS

!define MEGA_DATA "mega.ini"
!define UNINSTALLER_NAME "uninst.exe"

!include "MUI2.nsh"
!include "Library.nsh"
!include "UAC.nsh"
!include "MultiUser.nsh"
!include "x64.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "installer\app_ico.ico"
!define MUI_UNICON "installer\uninstall_ico.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Settings
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "MEGAsync"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!define MUI_FINISHPAGE_RUN ;"$INSTDIR\MEGASync.exe"
!define MUI_FINISHPAGE_RUN_FUNCTION RunFunction

!define MUI_WELCOMEFINISHPAGE_BITMAP "installer\left_banner.bmp"
;!define MUI_FINISHPAGE_NOAUTOCLOSE

var APP_NAME
var ICONS_GROUP
;var INSTALLDAY
;var EXPIRATIONDAY
var USERNAME
var CURRENT_USER_INSTDIR
var ALL_USERS_INSTDIR

; Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "installer\terms.txt"
!insertmacro MULTIUSER_PAGE_INSTALLMODE
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "Afrikaans"
!insertmacro MUI_LANGUAGE "Albanian"
!insertmacro MUI_LANGUAGE "Arabic"
!insertmacro MUI_LANGUAGE "Armenian"
!insertmacro MUI_LANGUAGE "Basque"
!insertmacro MUI_LANGUAGE "Belarusian"
!insertmacro MUI_LANGUAGE "Bosnian"
!insertmacro MUI_LANGUAGE "Breton"
!insertmacro MUI_LANGUAGE "Bulgarian"
!insertmacro MUI_LANGUAGE "Catalan"
!insertmacro MUI_LANGUAGE "Cibemba"
!insertmacro MUI_LANGUAGE "Croatian"
!insertmacro MUI_LANGUAGE "Czech"
!insertmacro MUI_LANGUAGE "Danish"
!insertmacro MUI_LANGUAGE "Dutch"
!insertmacro MUI_LANGUAGE "Efik"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Esperanto"
!insertmacro MUI_LANGUAGE "Estonian"
!insertmacro MUI_LANGUAGE "Farsi"
!insertmacro MUI_LANGUAGE "Finnish"
!insertmacro MUI_LANGUAGE "French"
!insertmacro MUI_LANGUAGE "Galician"
!insertmacro MUI_LANGUAGE "Georgian"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "Greek"
!insertmacro MUI_LANGUAGE "Hebrew"
!insertmacro MUI_LANGUAGE "Hindi"
!insertmacro MUI_LANGUAGE "Hungarian"
!insertmacro MUI_LANGUAGE "Icelandic"
!insertmacro MUI_LANGUAGE "Igbo"
!insertmacro MUI_LANGUAGE "Indonesian"
!insertmacro MUI_LANGUAGE "Irish"
!insertmacro MUI_LANGUAGE "Italian"
!insertmacro MUI_LANGUAGE "Japanese"
!insertmacro MUI_LANGUAGE "Khmer"
!insertmacro MUI_LANGUAGE "Korean"
!insertmacro MUI_LANGUAGE "Kurdish"
!insertmacro MUI_LANGUAGE "Latvian"
!insertmacro MUI_LANGUAGE "Lithuanian"
!insertmacro MUI_LANGUAGE "Luxembourgish"
!insertmacro MUI_LANGUAGE "Macedonian"
!insertmacro MUI_LANGUAGE "Malagasy"
!insertmacro MUI_LANGUAGE "Malay"
!insertmacro MUI_LANGUAGE "Mongolian"
!insertmacro MUI_LANGUAGE "Norwegian"
!insertmacro MUI_LANGUAGE "NorwegianNynorsk"
!insertmacro MUI_LANGUAGE "Polish"
!insertmacro MUI_LANGUAGE "Portuguese"
!insertmacro MUI_LANGUAGE "PortugueseBR"
!insertmacro MUI_LANGUAGE "Romanian"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_LANGUAGE "Serbian"
!insertmacro MUI_LANGUAGE "SerbianLatin"
!insertmacro MUI_LANGUAGE "Sesotho"
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "Slovak"
!insertmacro MUI_LANGUAGE "Slovenian"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_LANGUAGE "SpanishInternational"
!insertmacro MUI_LANGUAGE "Swahili"
!insertmacro MUI_LANGUAGE "Swedish"
!insertmacro MUI_LANGUAGE "Tamil"
!insertmacro MUI_LANGUAGE "Thai"
!insertmacro MUI_LANGUAGE "TradChinese"
!insertmacro MUI_LANGUAGE "Turkish"
!insertmacro MUI_LANGUAGE "Twi"
!insertmacro MUI_LANGUAGE "Ukrainian"
!insertmacro MUI_LANGUAGE "Uyghur"
!insertmacro MUI_LANGUAGE "Uzbek"
!insertmacro MUI_LANGUAGE "Vietnamese"
!insertmacro MUI_LANGUAGE "Welsh"
!insertmacro MUI_LANGUAGE "Yoruba"
!insertmacro MUI_LANGUAGE "Zulu"

; MUI end ------

Name $APP_NAME
!ifdef BUILD_UNINSTALLER
OutFile "UninstallerGenerator.exe"
!else
OutFile "MEGAsyncSetup.exe"
!endif

InstallDir "$PROGRAMFILES\MEGAsync"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails nevershow
ShowUnInstDetails nevershow

Function RunFunction
  ${UAC.CallFunctionAsUser} RunMegaSync
FunctionEnd

Function RunMegaSync
  Exec "$INSTDIR\MEGAsync.exe"
  Sleep 2000
FunctionEnd

Function RunExplorer
  ExecDos::exec /ASYNC /DETAILED /DISABLEFSR "explorer.exe"
FunctionEnd

Function .onInit
  StrCpy $APP_NAME "${PRODUCT_NAME} ${PRODUCT_VERSION}"
  
  !ifdef BUILD_UNINSTALLER
         WriteUninstaller "$EXEDIR\${UNINSTALLER_NAME}"
         Quit
  !endif

  ;${GetTime} "" "L" $0 $1 $2 $3 $4 $5 $6
  ;strCpy $INSTALLDAY "$2$1$0"
  ;strCpy $EXPIRATIONDAY "20140121"

  ;${if} $INSTALLDAY >= $EXPIRATIONDAY
  ;    MessageBox mb_IconInformation|mb_TopMost|mb_SetForeground "Thank you for testing MEGAsync.$\r$\nThis beta version is no longer current and has expired.$\r$\nPlease follow @MEGAprivacy on Twitter for updates."
  ;    abort
  ;${EndIf}

  UAC::RunElevated
  ${Switch} $0
  ${Case} 0
    ${IfThen} $1 = 1 ${|} Quit ${|} ;User process. The installer has finished. Quit.
    ${IfThen} $3 <> 0 ${|} ${Break} ${|} ;Admin process, continue the installation
    ${If} $1 = 3 ;RunAs completed successfully, but with a non-admin user
      ;MessageBox mb_YesNo|mb_IconExclamation|mb_TopMost|mb_SetForeground "This requires admin privileges, try again" /SD IDNO IDYES uac_tryagain IDNO 0
      Quit
    ${EndIf}
  ${Case} 1223
    ;MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "This requires admin privileges, aborting!"
    Quit
  ${Default}
    MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "This installer requires Administrator privileges. Error $0"
    Quit
  ${EndSwitch}
  
  ;MessageBox mb_IconInformation|mb_TopMost|mb_SetForeground "CAUTION: This is a private BETA version and will expire on Jan 20, 2014, 23:59. If you encounter a bug, malfunction or design flaw, please let us know by sending an e-mail to beta@mega.co.nz.$\r$\n$\r$\nIn this version, the scope of the sync engine is limited. Please bear in mind that:$\r$\n$\r$\n1. Deletions are only executed on the other side if they occur while the sync is live. Do not delete items from synced folders while this app is not running!$\r$\n2. Windows filenames are case insensitive. Do not place items a MEGA folder whose names would clash on the client. Loss of data would occur.$\r$\n3. Local filesystem items must not be exposed to the sync subsystem more than once. Any dupes, whether by nesting syncs or through filesystem links, will lead to unexpected results and loss of data.$\r$\n$\r$\nLimitiations in the current version that will be rectified in the future:$\r$\n$\r$\n1. No locking: Concurrent creation of identically named files and folders on different clients can result in server-side dupes and unexpected results.$\r$\n2. No in-place versioning: Deleted remote files can be found in the MEGA rubbish bin (SyncDebris folder), deleted local files in your computer's recycle bin.$\r$\n3. No delta writes: Changed files are always overwritten as a whole, which means that it is not a good idea to sync e.g. live database files.$\r$\n4. No direct peer-to-peer syncing: Even two machines in the same local subnet will still sync via the remote MEGA infrastructure.$\r$\n$\r$\nThank you for betatesting MEGAsync. We appreciate your pioneering spirit!"
  ;!insertmacro MUI_UNGETLANGUAGE
  !insertmacro MUI_LANGDLL_DISPLAY
FunctionEnd

Function GetPaths
  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i ${CSIDL_COMMON_APPDATA}, i0)i.r0'
  strCpy $ALL_USERS_INSTDIR $1
  
  System::Call "advapi32::GetUserName(t .r0, *i ${NSIS_MAX_STRLEN} r1) i.r2"
  strCpy $USERNAME $0

  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i ${CSIDL_LOCALAPPDATA}, i0)i.r0'
  strCpy $CURRENT_USER_INSTDIR $1
  
  WriteINIStr "$ALL_USERS_INSTDIR\megatmp.ini" section1 "M1" "$CURRENT_USER_INSTDIR"
  WriteINIStr "$ALL_USERS_INSTDIR\megatmp.ini" section1 "M2" "$USERNAME"
FunctionEnd

Section "Principal" SEC01
  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i ${CSIDL_COMMON_APPDATA}, i0)i.r0'
  strCpy $ALL_USERS_INSTDIR $1
  
  ${UAC.CallFunctionAsUser} GetPaths

readpaths:
  ReadINIStr $CURRENT_USER_INSTDIR "$ALL_USERS_INSTDIR\megatmp.ini" section1 "M1"
  ReadINIStr $USERNAME "$ALL_USERS_INSTDIR\megatmp.ini" section1 "M2"
  StrCmp $CURRENT_USER_INSTDIR "" 0 pathsreaded
  Sleep 1000
  goto readpaths

pathsreaded:
  Delete "$ALL_USERS_INSTDIR\megatmp.ini"
  StrCmp "CurrentUser" $MultiUser.InstallMode currentuser
  SetShellVarContext all
  StrCpy $INSTDIR "$ALL_USERS_INSTDIR\MEGAsync"
  goto modeselected
currentuser:
  SetShellVarContext current
  StrCpy $INSTDIR "$CURRENT_USER_INSTDIR\MEGAsync"
modeselected:

  ;SetRebootFlag true
  SetOverwrite try

  ;VC++2010 Redistributable x32
  SetOutPath "$INSTDIR"
  
  ;VC++ 2010 SP1 x86
  ClearErrors
  ReadRegDword $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}" "Version"
  IfErrors 0 VSRedist2010x86Installed
           ${Do}
               Pop $0
               IfErrors cslbl1
           ${Loop}
           cslbl1:
           ClearErrors
           inetc::get /caption "Microsoft Visual C++ 2010 SP1 Redistributable Package (x86)" "http://download.microsoft.com/download/C/6/D/C6D0FD4E-9E53-4897-9B91-836EBA2AACD3/vcredist_x86.exe" "$INSTDIR\vcredist_x86.exe" /end
           pop $0
           StrCmp $0 "OK" dlok1
           MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Incomplete download, aborting!"
           Abort
           dlok1:

           md5dll::GetMD5File "$INSTDIR\vcredist_x86.exe"
           Pop $0
           ;DetailPrint "md5: [$0]"
           StrCmp $0 "cede02d7af62449a2c38c49abecc0cd3" md5x32ok
                  MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Corrupt download, aborting!"
                  Abort
           md5x32ok:
           
           retryvsredistx32:
                ExecDos::exec /DETAILED '"$INSTDIR\vcredist_x86.exe" /NoSetupVersionCheck /passive /showfinalerror /promptrestart'
                Pop $0
                StrCmp $0 "0" vcredist32ok
                       StrCmp $0 "5100" askforretryx32 fatalvcredistx32
                       askforretryx32:
                       MessageBox MB_RETRYCANCEL "Another installation is already in progress. Please, finish it and retry." IDRETRY retryvsredistx32 IDABORT abortx32
                       fatalvcredistx32:
                       MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "There was a problem installing Microsoft VC++ 2010 x32 ($0), aborting!"
                       abortx32:
                       Abort
           vcredist32ok:
           Delete "$INSTDIR\vcredist_x86.exe"
  VSRedist2010x86Installed:
  
  ${If} ${RunningX64}
        ;VC++ 2010 SP1 x64
        SetRegView 64
        ClearErrors
        ReadRegDword $R0 HKLM "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{1D8E6291-B0D5-35EC-8441-6616F567A0F7}" "Version"
        IfErrors 0 VSRedist2010x64Installed
                ${Do}
                    Pop $0
                    IfErrors cslbl2
                ${Loop}
                cslbl2:
                ClearErrors
                inetc::get /caption "Microsoft Visual C++ 2010 SP1 Redistributable Package (x64)" "http://download.microsoft.com/download/A/8/0/A80747C3-41BD-45DF-B505-E9710D2744E0/vcredist_x64.exe" "$INSTDIR\vcredist_x64.exe" /end
                pop $0
                StrCmp $0 "OK" dlok2
                MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Incomplete download, aborting!"
                Abort
                dlok2:
                 
                md5dll::GetMD5File "$INSTDIR\vcredist_x64.exe"
                Pop $0
                ;DetailPrint "md5: [$0]"
                StrCmp $0 "cbe0b05c11d5d523c2af997d737c137b" md5x64ok
                       MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Corrupt download, aborting!"
                       Abort
                md5x64ok:
                 
                retryvsredistx64:
                ExecDos::exec /DETAILED /DISABLEFSR '"$INSTDIR\vcredist_x64.exe" /NoSetupVersionCheck /passive /showfinalerror /promptrestart'
                Pop $0
                StrCmp $0 "0" vcredist64ok
                       StrCmp $0 "5100" askforretryx64 fatalvcredistx64
                       askforretryx64:
                       MessageBox MB_RETRYCANCEL "Another installation is already in progress. Please, finish it and retry." IDRETRY retryvsredistx64 IDABORT abortx64
                       fatalvcredistx64:
                       MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "There was a problem installing Microsoft VC++ 2010 x64 ($0), aborting!"
                       abortx64:
                       Abort
                vcredist64ok:
                Delete "$INSTDIR\vcredist_x64.exe"
        VSRedist2010x64Installed:
        SetRegView 32
  ${EndIf}

  ExecDos::exec /DETAILED /DISABLEFSR "taskkill /f /IM MEGAsync.exe"
  
  ;x86_32 files
  File "${SRCDIR_MEGASYNC}\QtCore4.dll"
  AccessControl::SetFileOwner "$INSTDIR\QtCore4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\QtCore4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  File "${SRCDIR_MEGASYNC}\QtGui4.dll"
  AccessControl::SetFileOwner "$INSTDIR\QtGui4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\QtGui4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  File "${SRCDIR_MEGASYNC}\QtNetwork4.dll"
  AccessControl::SetFileOwner "$INSTDIR\QtNetwork4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\QtNetwork4.dll" "$USERNAME" "GenericRead + GenericWrite"

  File "${SRCDIR_MEGASYNC}\QtXml4.dll"
  AccessControl::SetFileOwner "$INSTDIR\QtXml4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\QtXml4.dll" "$USERNAME" "GenericRead + GenericWrite"

  File "${SRCDIR_MEGASYNC}\QtSvg4.dll"
  AccessControl::SetFileOwner "$INSTDIR\QtSvg4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\QtSvg4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  SetOutPath "$INSTDIR\imageformats"
  File "${SRCDIR_MEGASYNC}\imageformats\qgif4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats" "$USERNAME" "GenericRead + GenericWrite"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qgif4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qgif4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  File "${SRCDIR_MEGASYNC}\imageformats\qico4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qico4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qico4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  File "${SRCDIR_MEGASYNC}\imageformats\qjpeg4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qjpeg4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qjpeg4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  File "${SRCDIR_MEGASYNC}\imageformats\qmng4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qmng4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qmng4.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  File "${SRCDIR_MEGASYNC}\imageformats\qsvg4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qsvg4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qsvg4.dll" "$USERNAME" "GenericRead + GenericWrite"

  File "${SRCDIR_MEGASYNC}\imageformats\qtga4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qtga4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qtga4.dll" "$USERNAME" "GenericRead + GenericWrite"

  File "${SRCDIR_MEGASYNC}\imageformats\qtiff4.dll"
  AccessControl::SetFileOwner "$INSTDIR\imageformats\qtiff4.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\imageformats\qtiff4.dll" "$USERNAME" "GenericRead + GenericWrite"
          
  SetOutPath "$INSTDIR"
  SetOverwrite on
  AllowSkipFiles off
  File "${SRCDIR_MEGASYNC}\MEGAsync.exe"
  AccessControl::SetFileOwner "$INSTDIR\MEGAsync.exe" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\MEGAsync.exe" "$USERNAME" "GenericRead + GenericWrite"
    
  File "${UNINSTALLER_NAME}"
  AccessControl::SetFileOwner "$INSTDIR\${UNINSTALLER_NAME}" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\${UNINSTALLER_NAME}" "$USERNAME" "GenericRead + GenericWrite"
  
  ExecDos::exec /DETAILED /DISABLEFSR "taskkill /f /IM explorer.exe"

  IfFileExists "$INSTDIR\ShellExtX32.dll" 0 new_installation_x32
        GetTempFileName $0
        Delete $0
        Rename "$INSTDIR\ShellExtX32.dll" $0
        Delete /REBOOTOK $0
  new_installation_x32:
  
  ; Register shell extension 1 (x86_32)
  !define LIBRARY_COM
  !define LIBRARY_SHELL_EXTENSION
  !insertmacro InstallLib REGDLL NOTSHARED REBOOT_NOTPROTECTED "${SRCDIR_MEGASHELLEXT_X32}\MEGAShellExt.dll" "$INSTDIR\ShellExtX32.dll" "$INSTDIR"
  !undef LIBRARY_COM
  !undef LIBRARY_SHELL_EXTENSION

  AccessControl::SetFileOwner "$INSTDIR\ShellExtX32.dll" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\ShellExtX32.dll" "$USERNAME" "GenericRead + GenericWrite"
  
  ${If} ${RunningX64}
        IfFileExists "$INSTDIR\ShellExtX64.dll" 0 new_installation_x64
                GetTempFileName $0
                Delete $0
                Rename "$INSTDIR\ShellExtX64.dll" $0
                Delete /REBOOTOK $0
        new_installation_x64:
  
        ; Register shell extension 1 (x86_64)
        !define LIBRARY_X64
        !define LIBRARY_COM
        !define LIBRARY_SHELL_EXTENSION
        !insertmacro InstallLib REGDLL NOTSHARED REBOOT_NOTPROTECTED "${SRCDIR_MEGASHELLEXT_X64}\MEGAShellExt.dll" "$INSTDIR\ShellExtX64.dll" "$INSTDIR"
        !undef LIBRARY_X64
        !undef LIBRARY_COM
        !undef LIBRARY_SHELL_EXTENSION
        
        AccessControl::SetFileOwner "$INSTDIR\ShellExtX64.dll" "$USERNAME"
        AccessControl::GrantOnFile "$INSTDIR\ShellExtX64.dll" "$USERNAME" "GenericRead + GenericWrite"
  ${EndIf}

  ${UAC.CallFunctionAsUser} RunExplorer
   
  SetRebootFlag false
  StrCmp "CurrentUser" $MultiUser.InstallMode currentuser2
  SetShellVarContext all
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\MEGAsync.lnk" "$INSTDIR\MEGAsync.exe"
  CreateShortCut "$DESKTOP\MEGAsync.lnk" "$INSTDIR\MEGAsync.exe"
  WriteIniStr "$INSTDIR\MEGA Website.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\MEGA Website.lnk" "$INSTDIR\MEGA Website.url" "" "$INSTDIR\MEGAsync.exe" 1
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\${UNINSTALLER_NAME}"
  !insertmacro MUI_STARTMENU_WRITE_END
  goto modeselected2
currentuser2:
  ${UAC.CallFunctionAsUser} CreateMegaShortcuts
modeselected2:

SectionEnd

Function CreateMegaShortcuts
  SetShellVarContext current
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\MEGAsync.lnk" "$INSTDIR\MEGAsync.exe"
  CreateShortCut "$DESKTOP\MEGAsync.lnk" "$INSTDIR\MEGAsync.exe"
  WriteIniStr "$INSTDIR\MEGA Website.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\MEGA Website.lnk" "$INSTDIR\MEGA Website.url" "" "$INSTDIR\MEGAsync.exe" 1
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\${UNINSTALLER_NAME}"
  !insertmacro MUI_STARTMENU_WRITE_END
FunctionEnd

Section -AdditionalIcons

SectionEnd

Section -Post
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\MEGAsync.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\${UNINSTALLER_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\MEGAsync.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" ""
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  
  AccessControl::SetFileOwner "$INSTDIR\MEGA Website.url" "$USERNAME"
  AccessControl::GrantOnFile "$INSTDIR\MEGA Website.url" "$USERNAME" "GenericRead + GenericWrite"
  
  Delete "$INSTDIR\NSIS.Library.RegTool*.exe"
SectionEnd

Function un.onInit
StrCpy $APP_NAME "${PRODUCT_NAME}"

ReadIniStr $0 "$ExeDir\${MEGA_DATA}" UAC first
${IF} $0 <> 1
	;SetSilent silent
	InitPluginsDir
	WriteIniStr "$PluginsDir\${MEGA_DATA}" UAC first 1
	CopyFiles /SILENT "$EXEPATH" "$PluginsDir\${UNINSTALLER_NAME}"
	ExecWait '"$PluginsDir\${UNINSTALLER_NAME}" _?=$INSTDIR' $0
	SetErrorLevel $0
	Quit
${EndIf}

UAC::RunElevated
  ${Switch} $0
  ${Case} 0
    ${IfThen} $1 = 1 ${|} Quit ${|} ;User process. The installer has finished. Quit.
    ${IfThen} $3 <> 0 ${|} ${Break} ${|} ;Admin process, continue the installation
    ${If} $1 = 3 ;RunAs completed successfully, but with a non-admin user
      ;MessageBox mb_YesNo|mb_IconExclamation|mb_TopMost|mb_SetForeground "This requires admin privileges, try again" /SD IDNO IDYES uac_tryagain IDNO 0
      Quit
    ${EndIf}
  ${Case} 1223
    ;MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "This requires admin privileges, aborting!"
    Quit
  ${Default}
    MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "This installer requires Administrator privileges. Error $0"
    Quit
  ${EndSwitch}

!insertmacro MUI_UNGETLANGUAGE
FunctionEnd

Function un.UninstallSyncs
  ExecDos::exec "$INSTDIR\MEGAsync.exe /uninstall"
FunctionEnd

Section Uninstall
  ExecDos::exec /DETAILED "taskkill /f /IM MEGASync.exe"
  Sleep 1000
  ${UAC.CallFunctionAsUser} un.UninstallSyncs
  Sleep 1000

  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\${UNINSTALLER_NAME}"
  Delete "$INSTDIR\QtNetwork4.dll"
  Delete "$INSTDIR\QtGui4.dll"
  Delete "$INSTDIR\QtCore4.dll"
  Delete "$INSTDIR\QtSvg4.dll"
  Delete "$INSTDIR\QtXml4.dll"
  Delete "$INSTDIR\imageformats\qgif4.dll"
  Delete "$INSTDIR\imageformats\qico4.dll"
  Delete "$INSTDIR\imageformats\qjpeg4.dll"
  Delete "$INSTDIR\imageformats\qmng4.dll"
  Delete "$INSTDIR\imageformats\qsvg4.dll"
  Delete "$INSTDIR\imageformats\qtga4.dll"
  Delete "$INSTDIR\imageformats\qtiff4.dll"
  Delete "$INSTDIR\MEGAsync.exe"
  Delete "$INSTDIR\NSIS.Library.RegTool*.exe"

  !define LIBRARY_COM
  !define LIBRARY_SHELL_EXTENSION
  !insertmacro UnInstallLib REGDLL NOTSHARED NOREMOVE "$INSTDIR\ShellExtX32.dll"
  !undef LIBRARY_COM
  !undef LIBRARY_SHELL_EXTENSION
  
  GetTempFileName $0
  Delete $0
  Rename "$INSTDIR\ShellExtX32.dll" $0
  Delete /REBOOTOK $0
  
  ${If} ${RunningX64}
        !define LIBRARY_X64
        !define LIBRARY_COM
        !define LIBRARY_SHELL_EXTENSION
        !insertmacro UnInstallLib REGDLL NOTSHARED NOREMOVE "$INSTDIR\ShellExtX64.dll"
        !undef LIBRARY_X64
        !undef LIBRARY_COM
        !undef LIBRARY_SHELL_EXTENSION

        GetTempFileName $0
        Delete $0
        Rename "$INSTDIR\ShellExtX64.dll" $0
        Delete /REBOOTOK $0
  ${EndIf}
  
  SetShellVarContext current
  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\MEGA Website.lnk"
  Delete "$INSTDIR\MEGA Website.url"
  Delete "$DESKTOP\MEGAsync.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\MEGAsync.lnk"
  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i ${CSIDL_STARTUP}, i0)i.r0'
  Delete "$1\MEGAsync.lnk"
  RMDir "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR\imageformats"
  RMDir "$INSTDIR"
  
  SetShellVarContext all
  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\MEGA Website.lnk"
  Delete "$INSTDIR\MEGA Website.url"
  Delete "$DESKTOP\MEGAsync.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\MEGAsync.lnk"
  System::Call 'shell32::SHGetSpecialFolderPath(i $HWNDPARENT, t .r1, i ${CSIDL_STARTUP}, i0)i.r0'
  Delete "$1\MEGAsync.lnk"
  RMDir "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR\imageformats"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
  SetRebootFlag false
SectionEnd
