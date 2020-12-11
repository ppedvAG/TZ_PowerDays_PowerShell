
Get-EventLog -LogName Security | Where-Object EventId -eq 4624 | Select-Object -First 10
