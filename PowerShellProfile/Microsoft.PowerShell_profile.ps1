function Set-DefaultShellColors
{
    param(
    )
    $Host.UI.RawUI.WindowTitle = "KursShell"
    $Host.Ui.RawUI.BackgroundColor = "White"
    $Host.UI.RawUI.ForegroundColor = "Black"

    
    if((Get-Command Set-PSReadlineOption).Version.Major -lt 2)
    {   #Ausführung bis einschließlich Windows10 1803 und Windows Server 2016
        Set-PSReadlineOption -TokenKind Command -ForegroundColor DarkBlue
        Set-PSReadlineOption -TokenKind Variable -ForegroundColor DarkCyan
        Set-PSReadlineOption -TokenKind Comment -ForegroundColor Green
        Set-PSReadlineOption -TokenKind Number -ForegroundColor Magenta
    }
    else
    {#Ausführung ab Windows 10 1809 und Windows Server 2019. Da dort die Modulversion 2 verwendet wird
        Set-PSReadlineOption -Colors @{"Parameter" = [ConsoleColor]::Blue
                               "Command"   = [Consolecolor]::DarkBlue
                               "Number"    = [Consolecolor]::DarkRed
                               "Member"    = [ConsoleColor]::Gray
                               "String"    = [Consolecolor]::DarkGreen
                               "Comment"   = [ConsoleColor]::Green
                               "Keyword"   = [ConsoleColor]::Magenta
                               "None"      = [ConsoleColor]::Black
                               "Operator"  = [ConsoleColor]::DarkMagenta
                               "Type"      = [ConsoleColor]::Cyan
                               "Variable"  = [ConsoleColor]::DarkCyan}
                                    
     }
     cls
}

function prompt
{
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

    if($principal.IsInRole($adminRole))
    {
        $Userrole = "[Admin]"
    }
    else
    {
        $Userrole = "[User]"
    }
    
    $promptlevel = ">"
    for($i = 0;$i -lt $NestedPromptLevel; $i++)
    {
        $promptlevel += ">"
    }

    
    "[$((Get-Date).ToShortTimeString())] $UserRole Location: $(Get-Location)" + [System.Environment]::NewLine + "PS [$((Get-History).Count + 1)]$promptlevel"
}

Set-DefaultShellColors

