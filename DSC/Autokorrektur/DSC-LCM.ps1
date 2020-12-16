configuration WebServer-AutoKorrektur
{
    # Zum Abrufen der Knotenliste können Ausdrücke ausgewertet werden.
    # Beispiel: $AllNodes.Where("Role -eq Web").NodeName
    node $AllNodes.NodeName
    {
        LocalConfigurationManager
        {
            #ApplyOnly : Nur Anwenden der Konfiguration sonst nichts weiteres
            #ApplyAndMonitor: Anwenden der Konfiguration und regelmäßiges prüfen ob der Zustand noch zur Konfiguration passt. Wie manuelles ausführen des Test-DSCConfiguration
            #Standardwert ist hierfür alle 15 Minuten, kann angepasst werden mit ConfigurationModeFrequencyMins 
            #ApplyAndAutoCorrect: Anwenden der Konfiguration und prüfen im Intervall des ConfigurationModeFrequencyMins. Sollte der Zustand nicht passen wird versucht der Sollzustand wieder herzustellen
            ConfigurationMode = "ApplyAndAutoCorrect"            
            ConfigurationModeFrequencyMins = 15
        }

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
WebServer-AutoKorrektur -OutputPath C:\TZ_PowerDays_PowerShell\DSC\Autokorrektur\Config -ConfigurationData C:\TZ_PowerDays_PowerShell\DSC\Autokorrektur\WebServerConfig.psd1

#Start-DscConfiguration -Path C:\TZ_PowerDays_PowerShell\DSC\Autokorrektur\Config -Verbose -Wait