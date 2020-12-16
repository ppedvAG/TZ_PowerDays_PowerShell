[cmdletBinding()]
param
(
    [Parameter(Mandatory=$true)]
    [string]$Input1
)

Write-Verbose -Message "Vor erster Ausgabe. Folgender Wert wurde übergeben. Input1: $Input1"
$Fortschritt += "Schritt1"
Write-Host -Object $Input1 -ForegroundColor Magenta
$Fortschritt += "Schritt2"
Write-Debug -Message "Vor zweiter Ausgabe"
Write-Host -Object $Input1 -ForegroundColor DarkYellow
$Fortschritt += "Schritt3"
Write-Host -Object $Input1 -ForegroundColor Cyan
$Fortschritt