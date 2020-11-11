$Path = Read-Host –Prompt “Enter target path”
$LogPath = Read-Host -Prompt “Enter log save path”
$SearchDepth = Read-Host -Prompt "Enter search depth"


function Get-Groups{
    param(
    $i
    )
    $acls = (Get-Acl).AccessToString
    $groups = ""

    $i = $acls.Split()

    foreach($j in $i){
        
        $j = $j + " "
        
        $groups = $groups + $j

}

return $groups

}

$dirs = Get-ChildItem $Path -Depth $SearchDepth -Force -Recurse -Attributes Directory
$progress = 0

$dirs 
$totalcount = $dirs.Count
foreach($i in $dirs){
    $i | Select-Object Name,@{Name="Owner";Expression={(Get-ACL $_.Fullname).Owner}},@{Name="Groups";Expression={Get-Groups $i}},CreationTime,LastAccessTime | Export-Csv -Path $LogPath\FileFolderOwner.csv -NoTypeInformation -Encoding utf8 -Force -Append -Verbose | Write-Output
    $progress += 1
    $p = ($progress/$totalcount)*100 
    $p = [math]::Round($p)
    $status = "Processsing: " + $p + "%"
    Write-Progress -Activity "Retrieving folder permissions" -PercentComplete $p -Status $status
    }





    
exit
#C:\Users\1151455\Documents
#C:\Users\1151455\Documents
#\\us\sas\Information Technology\SAS DML\Software Titles
