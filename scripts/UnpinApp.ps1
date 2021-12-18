<#
	.SYNOPSIS
	Unpins provided applications from the taskbar

	.DESCRIPTION
	Version: 0.1
	Unpins provided applications from the taskbar

	.NOTES
	Author: Robert Dyjas https://dyjas.cc
	Function based on StackOverflow answer:
	https://stackoverflow.com/a/45152368/9902555

	Known issues:
	-
	.EXAMPLE
	UnpinApp.ps1 -AppNames "Internet Explorer", "Microsoft Edge"
#>

param(
	[Parameter(ValueFromPipeline = $true)]
	[string[]]
	$AppNames
)

begin {
	# https://stackoverflow.com/a/45152368/9902555
	function Unpin-App([string]$appname) {
		((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() |
		Where-Object { $_.Name -eq $appname }).Verbs() | Where-Object { $_.Name.replace('&', '') -match 'Unpin from taskbar' } | ForEach-Object { $_.DoIt() }
	}
} process {
	foreach ($AppName in $AppNames) {
		Unpin-App $AppName
	}
}