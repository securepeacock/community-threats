#$Path = systeminfo 
#$Hosts=$Path|Select-String "Host Name:" 
#$OSName=$Path|Select-String "OS Name:"
#$RegisteredOwner=$Path|Select-String "Registered Owner:"
#$SystemBootTime=$Path|Select-String "System Boot Time:"
#$SystemModel=$Path|Select-String "System Model:"
#$SystemType=$Path|Select-String "System Type:"
#$SystemDirectory=$Path|Select-String "System Directory:"
#$TimeZone=$Path|Select-String "Time Zone:"
#$infos=$Hosts.ToString()+"`r`n"+$OSName.ToString()+"`r`n"+$RegisteredOwner.ToString()+"`r`n"+$SystemBootTime.ToString()+"`r`n"+$SystemModel.ToString()+"`r`n"+$SystemType.ToString()+"`r`n"+$SystemDirectory.ToString()+"`r`n"+$TimeZone.ToString()
#$infos | Out-File -FilePath  $FilePath
#Get-Date -Format "yyyy/dd/MM HH:mm" | Out-File -FilePath $FilePath -append
#ipconfig /all | findstr /C:"IPv4" /C:"Physical Address" >> $FilePath

systeminfo | Out-File -FilePath info -append -Encoding UTF8