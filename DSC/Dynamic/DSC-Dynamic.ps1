configuration WebServer-Dynamic
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node $AllNodes.NodeName
    {
       foreach($feature in $Node.WindowsFeatures)
       {
            WindowsFeature $feature.Name
            {
                Name = $feature.Name
                Ensure = $feature.Ensure
            }
       }      
    }
}

#Ausführen des "Konfig" Skriptes wieder notwendig um die Konfig in den Speicher zu laden
#Hier wird dann auch die psd1 mit angegeben
WebServer-Dynamic -OutputPath C:\TZ_PowerDays_PowerShell\DSC\Dynamic\Config -ConfigurationData C:\TZ_PowerDays_PowerShell\DSC\Dynamic\WebServerConfig.psd1

Start-DscConfiguration -Wait -Verbose -Path C:\TZ_PowerDays_PowerShell\dsc\Dynamic\Config