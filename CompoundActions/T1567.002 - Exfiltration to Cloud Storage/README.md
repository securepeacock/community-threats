# T1567.002 - Exfiltration to Cloud Storage
This compound action exfiltrates data using rclone to your chosen cloud storage service.

## Import into SCYTHE
1. Login to the SCYTHE instance where you want to import the Compound Action.
2. Click Threat Manager - Migrate Threats
3. Under "Import Threat" click “Choose File” and select the JSON file you downloaded from GitHub
4. Click Import and OK when complete
5. Click Threat Manager - Threat Catalog
6. Find the imported Compound Action and click the tag icon 
7. Tag the MITRE ATT&CK Technique for the Compound Action

## Preparation
1. Create an account in the desired cloud service supported by rclone: https://rclone.org/overview/
2. Run rclone.exe config on your own test system to configure the cloud service you will exfiltrate data to: ```rclone.exe config```
3. On your SCYTHE instance, create a folder VFS:/shared/rclone
4. Upload the rclone.conf from your test system (%USERPROFILE%\.config\rclone\rclone.conf) to VFS:/shared/rclone
