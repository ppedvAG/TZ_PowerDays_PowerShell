function New-TestFilesDir
{
[cmdletBinding()]
Param(
    [ValidateScript({Test-Path -Path $PSItem -IsValid})]
    [string]$Destinationpath,

    [ValidateRange(1,100)]
    [int]$FileCount = 9,

    [ValidateRange(1,100)]
    [int]$DirCount = 4,

    [switch]$Force

)


if((Test-Path -Path $Destinationpath))
{
    if($Force)
    {
        Remove-Item -Path $Destinationpath -Recurse -Force
    }
    else
    {
        Write-Host -ForegroundColor Red -Object "Ordner bereits vorhanden"
        exit        
    }
}

New-Item -Path $Destinationpath -ItemType Directory
New-TestFiles -Destinationpath $Destinationpath -FileCount $FileCount
for($i = 1; $i -le $DirCount;$i++)
{
    $DirPath = $Destinationpath +  "\Ordner" + ("{0:D3}" -f $i)
    New-Item -Path $DirPath -ItemType Directory
    New-TestFiles -Destinationpath $DirPath -FileCount $FileCount
}
}

function New-TestFiles
{
    param(
        $Destinationpath,
        $FileCount
    )
    for($j = 1; $j -le $FileCount; $j++)
    {
        $FileName = $Destinationpath + "\Datei" + ("{0:D3}" -f $j) + ".txt"
        New-Item -Path $FileName -ItemType File
    }

}
