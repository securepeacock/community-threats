function Enum-UsersFolders($PathEnum)
{
    $foldersArr = 'Desktop','Downloads','Documents','AppData/Roaming','AppData/Local'

    Get-ChildItem -Path $PathEnum'/c$' -ErrorAction SilentlyContinue
    Get-ChildItem -Path $PathEnum'/c$/Program Files' -ErrorAction SilentlyContinue
    Get-ChildItem -Path $PathEnum'/c$/Program Files (x86)' -ErrorAction SilentlyContinue

    foreach($Directory in Get-ChildItem -Path $PathEnum'/c$/Users' -ErrorAction SilentlyContinue) {

        foreach($SeachDir in $foldersArr) {
            Get-ChildItem -Path $PathEnum'/c$/Users/'$Directory'/'$SeachDir -ErrorAction SilentlyContinue
        }
    }
}

