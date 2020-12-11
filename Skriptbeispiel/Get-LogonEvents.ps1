
param(
$Logname,
$Computername,
$EventId,
$Newest

)

#Befehlsverkettung mit Variablen
Get-EventLog -LogName $Logname -ComputerName $Computername | Where-Object EventId -eq $EventId | Select-Object -First $Newest
