# T1610 - Deploy Container

Adversaries may deploy a container into an environment to facilitate execution or evade defenses. Two methods are documented for this technique.

## ISO Deployment of SCYTHE (Windows) Payload

This procedure uses the Folder2Iso project to build an ISO that can be mounted on a Windows system. If the ISO was downloaded from the Internet, it will bypass the Mark of the Web warning. Opening the Reports shortcut will execute the SCYTHE DLL payload.

1. Copy the files in the VFS folder to a working directory on a Windows system.
2. Create a new SCYTHE campaign, download a 32-bit or 64-bit DLL with Entry-point function name of "`PlatformClientMain`".
3. Rename it DOCUMENTS.dll and put it in the /ISO/Folder2Iso of the working directory.
4. Open a Windows command prompt and cd to the working directory.
5. Run `Folder2Iso.exe "Folder2Iso" "%USERPROFILE%\Downloads\NOBELIUM.iso" "NOBELIUM" 0 0 0 "None"`. This will take all the content of the Folder2Iso folder and create an ISO of it.
6. Send the ISO file, host it on a web server, double click it, or `powershell Mount-DiskImage -ImagePath "%USERPROFILE%\Downloads\NOBELIUM.iso"` to mount.
7. Double clicking the Reports shortcut will launch the DOCUMENTS.dll SCYTHE Campaign.

## Docker Deployment of SCYTHE (Linux) Payload

The Dockerfile has an example of how to deploy a SCYTHE payload in a Docker container. Credit to Adam Mashinchi for documenting this procedure.

Assumes:

- Host running the Docker container is Ubuntu (tested with 18.04.5)
- SCYTHE Linux Campaign is created and Payload (64 bit ELF) downloaded to Ubuntu system as "`scythe_linux_payload.out`"
- `Dockerfile` in same directory (as above file)

Example Usage:

```
$ cp ~/Downloads/CampaignName_scythe_client64.out ./scythe_linux_payload.out
$ docker build -t scythe-payload .
$ docker run -d scythe-payload
```