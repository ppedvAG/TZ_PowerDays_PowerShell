<#
.Synopsis
   Dieses cmdlet erstellt TestFiles
.DESCRIPTION
   Mit diesem cmdlet können Sie an einem beliebigen Pfad eine TestFiles Struktur erstellen
.EXAMPLE
   New-TestFilesDir -Destinationpath C:\Testfiles

   Diese cmdlet erstelltden Ordner C:\TestFiles wenn er nicht vorhanden ist. Und erzeugt innerhalb eine TestFilesSTruktur mit 4 Ordnern und jeweilig 9 Dateien.
.EXAMPLE
   Ein weiteres Beispiel für die Verwendung dieses Cmdlets
.PARAMETER Destinationpath
    Dieser Parameter ist ein Pflicht Parameter und setzt den Zielpfad fest.
#>
function New-TestFilesDir
{

[cmdletBinding()]
Param(
    [ValidateScript({Test-Path -Path $PSItem -IsValid})]
    [Parameter(Mandatory=$true)]
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

function Out-Voice
{
[cmdletBinding()]
param(
    
    [Parameter(Mandatory=$true)]
    [ValidateLength(1,100)]
    [string]$inputtext
)
    $AudioService = Get-Service -Name Audiosrv
    if($AudioService.Status -ne "Running")
    {
        $AudioService.Start()
        $i = 0 #initialisieren der ZählerVariable
        do
        {
            Start-Sleep -Seconds 1     #Pausieren der Skriptausführung um eine 1 Sekunde
     
            $i++ #erhöhen der Zählervariable 1 um den Wert 1
            Write-Verbose -Message "Warte seit $i Sekunden auf den DienstStart" 
            if($i -gt 15)
            { #Wenn der Dienst 15 Sekunden lang nicht gestartet werden konnte wird ein Terminierender Fehler ausgegeben
                throw -Message "Der Dienst konnte nicht gestartet werden"
            }

            $AudioService.Refresh() #aktualisieren des Status der Dienstinstanz innerhalb der Variable
        }until($AudioService.Status -eq "Running")
    }
    
    Add-Type -AssemblyName System.Speech   #laden der System.Speech Assembly aus dem .Net System
    $SpeechSynthesizer = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer  #Initialisieren einer neuer Instanz des Speech Synthesizer
    $SpeechSynthesizer.Rate = 0 #Setzen der Rate. Range -10 bis 10
    #$SpeechSynthesizer.Speak($inputtext) #Ausgabe der Voice Ausgabe, Shell is blockiert während der Ausgabe
    $SpeechSynthesizer.SpeakAsync($inputtext) #Ausgabe wir a Synchron ausgegeben in einem eigenen "Thread" sodass die Shell während der Ausgabe nicht blockiert wird    
}