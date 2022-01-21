$Dir="C:/Windows/Temp/"
#ftp server
$ftp = "ftp://<IP Address>/incoming/"
$user = "<username>"
$pass = "<password>"
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)
#list every sql server trace file
foreach($item in (dir $Dir "*.7z")){
   "Uploading $item..."
   $uri = New-Object System.Uri($ftp+$item.Name)
   $webclient.UploadFile($uri, $item.FullName)
}

