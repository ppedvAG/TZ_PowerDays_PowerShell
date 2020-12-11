[cmdletBinding()]
param(
[string]$Logname = "Security",

[Parameter(Mandatory=$true)]
[ValidateScript({Test-Connection -ComputerName $PSItem -Count 2 -Quiet})]
[string]$Computername,

[ValidateSet(4624,4625,4634)]
[int]$EventId = 4624,

[ValidateRange(5,20)]
[int]$Newest = 3,
<#Validierung das Dateiname mit drei Zahlen beginnt, 
jede Zahl kann die Range 0 - 9 haben. Gefolgt von einem - welcher dann von 3 Buchstaben gefolgt wird. 
Die ersten beiden Zeichen können zwischen a-z liegen, das letzte zeichen muss zwischen a-m liegen. 
Und der Name muss mit .csv enden.
#>
[ValidatePattern("[0-9][0-9][0-9]-[a-z][a-z][a-m].csv")]
[string]$FileName = "empty",

[switch]$Force

)

#Befehlsverkettung mit Variablen
$output = Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest

#optionale Ausgabe als CSV
if($FileName -eq "empty")
{
    $output
}
else
{
    $filepath = ((Get-Location).Path + "\$FileName")
    $output | Export-Csv -Path $filepath -Force:$Force
    if(Test-Path -Path $filepath)
    {
        Write-Host "Datei erfolgreich exportiert unter folgendem Pfad: $filepath" -ForegroundColor Green
    }
    else
    {
        Write-Host "Export fehlgeschlagen" -ForegroundColor Red
    }
}
