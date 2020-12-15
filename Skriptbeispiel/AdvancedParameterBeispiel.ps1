<#
.SYNOPSIS 
    Kurzbeschreibung
#>
[cmdletBinding(PositionalBinding=$false)]
param(
    [Parameter(Mandatory=$true,ParameterSetName="Set1",ValueFromPipeline=$true)]
    [Parameter(Mandatory=$false,ParameterSetName="Set2",ValueFromPipeline=$true)] 
    [string]$param1,

    [Parameter(Mandatory=$true,ParameterSetName="Set2",ValueFromPipelineByPropertyName=$true)]
    [Parameter(Mandatory=$false,ParameterSetName="Set3",ValueFromPipelineByPropertyName=$true)]    
    [string]$param2,

    [Parameter(Mandatory=$true,ParameterSetName="Set3",ValueFromPipelineByPropertyName=$true)]
    [string]$param3
)