[cmdletBinding()]
param(
[string]$Logname = "Security",

[Parameter(Mandatory=$true)]
[string]$Computername,

[int]$EventId = 4624,

[int]$Newest = 5

)

#Befehlsverkettung mit Variablen
Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest
