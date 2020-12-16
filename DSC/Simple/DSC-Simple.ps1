configuration WebServerConfiguration-Simple
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node ("Member1")
    {
        # Ressourcenanbieter aufrufen
        # Beispiel: WindowsFeature, File
        WindowsFeature WebServer
        {
           Ensure = "Present"
           Name   = "web-Server"
        }

        WindowsFeature ManagementTools
        {
            Ensure = "Present"
            Name = "WEb-Mgmt-Tools"
        }     
    }
}

#Diese Konfiguration muss ausgeführt werden um sie in den Speicher zu laden und anschließend die MOF Files zu generieren. 
#WebServerConfiguration-Simple -OutputPath C:\TZ_PowerDays_PowerShell\DSC\Simple\DSCConfig

#Angewandt kann diese Konfiguration dann mit folgendem cmdlet. Optional mit -Wait . "Blockiert" die Shell bis die Ausführung fertig ist.
#Start-DscConfiguration -Path C:\TZ_PowerDays_PowerShell\DSC\Simple\DSCConfig -Verbose