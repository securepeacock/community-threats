# T1553.005 - Subvert Trust Controls: Mark-of-the-Web Bypass

Adversaries may abuse specific file formats, such as ISO, to evade Mark-of-the-Web (MOTW) controls. 

1. Copy the ISO file in the VFS folder to your SCYTHE server VFS:/shared/ISO
2. Inport and tag the imported Compound Action in your Threat Catalog as T1553.005
3. Create a new campaign and select the T1553.005 compound action

## ISO Deployment of SCYTHE (Windows) Payload

The below procedure uses the Folder2Iso project to build an ISO that can be mounted on a Windows system. If the ISO was downloaded from the Internet, it will bypass the Mark of the Web warning. Opening the Reports shortcut will execute the SCYTHE DLL payload.

1. Create a new SCYTHE campaign, download a 32-bit or 64-bit DLL with Entry-point function name of "`PlatformClientMain`".
2. Download the contents of the src directory to a working directory on your Windows system
3. Rename the DLL to DOCUMENTS.dll and put it in the /ISO/Folder2Iso of the working directory.
4. Open a Windows command prompt and cd to the working directory.
5. Run `Folder2Iso.exe "Folder2Iso" "%USERPROFILE%\Downloads\NOBELIUM.iso" "NOBELIUM" 0 0 0 "None"`. This will take all the content of the Folder2Iso folder and create an ISO of it.
6. Send the ISO file, host it on a web server, double click it, or `powershell Mount-DiskImage -ImagePath "%USERPROFILE%\Downloads\NOBELIUM.iso"` to mount.
7. Double clicking the Reports shortcut will launch the DOCUMENTS.dll SCYTHE Campaign.