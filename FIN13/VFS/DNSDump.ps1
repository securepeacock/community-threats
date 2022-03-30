Import-Module DnsServer
$results = Get-DnsServerZone | `% {
    $zone = $_.zonename
    Get-DnsServerResourceRecord $zone |
    Where-Object { $_.RecordType -in 'CNAME', 'A' } |
    Select-Object -Property @(
        @{ Name       = 'ZoneName'
           Expression = { $zone }
         }
        'HostName'
        'RecordType'
        @{ Name       = 'RecordData'
           Expression = {
                if ($_.RecordData.IPv4Address.IPAddressToString) {
                    $_.RecordData.IPv4Address.IPAddressToString
                } else {
                    $_.RecordData.NameServer.ToUpper()
                }
            }
         }
    )
}

$results | Export-Csv  -NoTypeInformation  ($Env:temp + "\addcat.csv")  -Append