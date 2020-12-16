@{
    AllNodes = @(
        @{
            NodeName = "Member1"
            WindowsFeatures = @(
                @{
                    Name = "Web-Server"
                    Ensure = "Present"
                 },
                 @{
                    Name = "Web-Mgmt-Tools"
                    Ensure = "Present"
                 }
            )
          }
    )
}
# Speichert ConfigurationData in einer Datei mit der Dateierweiterung "PSD1".
#Vorteil mehr Dynamik da die eigentliche Konfiguration ausgegert wird