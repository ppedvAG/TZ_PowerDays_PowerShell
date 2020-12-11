[cmdletBinding()]
param(
$Logname,

[Parameter(Mandatory=$true)]
$Computername,

$EventId,

$Newest

)

#Befehlsverkettung mit Variablen
Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest
