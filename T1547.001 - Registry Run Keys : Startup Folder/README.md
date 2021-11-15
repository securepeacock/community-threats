T1547.001 - Registry Run Keys / Startup Folder: Atomic Test 7

This compound action leverages PowerShell to add an lnk shortcut to the startup folder. This was a detection opprotunity laid out in Red Canary's Intelligence Insights: October 2021. 

Import into SCYTHE

Login to the SCYTHE instance where you want to import the Compound Action.
Click Threat Manager - Migrate Threats
Under "Import Threat" click “Choose File” and select the JSON file you downloaded from GitHub
Click Import and OK when complete
Click Threat Manager - Threat Catalog
Find the imported Compound Action and click the tag icon
Tag the MITRE ATT&CK Technique for the Compound Action
Upload the files in VFS folder into VFS/shared/T1547