$hostnm = $Env:computername;

$logs = get-eventlog system -ComputerName $hostnm -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-7);

$res = @();

ForEach ($log in $logs){

  if($log.instanceid -eq 7001) {$type = "Logon"}

  Elseif ($log.instanceid -eq 7002){$type="Logoff"}

  Else {Continue} $res += New-Object PSObject -Property @{Time = $log.TimeWritten; User = (New-Object System.Security.Principal.SecurityIdentifier $Log.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])}};

$res | Out-File ($Env:temp + "\logs1.txt")