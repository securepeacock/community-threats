function Get-InstalledPrograms {
  [CmdletBinding()]
  param (
    [Parameter()]
    [string]
    $DisplayName
  )
  Get-ItemProperty -Path @(
    'HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*',
    'HKCU:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*',
    'HKLM:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*',
    'HKCU:\\Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*'
  ) -ErrorAction SilentlyContinue | Where-Object {
     -not $PSBoundParameters.ContainsKey('DisplayName') -or (
      $_.PSObject.Properties.Name -contains 'DisplayName' -and $_.DisplayName -like $DisplayName
    );
  } | Select-Object DisplayName| Sort-Object -Property DisplayName;
}