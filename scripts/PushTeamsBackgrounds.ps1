<#
	.SYNOPSIS
	Pulls images from the internet and add them to Microsoft Teams background 
	
	.DESCRIPTION
	Version: 0.1
	Pulls images from predefined locations in the internet.
	Then it adds them to Microsoft Teams background folder, making them available

	.NOTES
	Author: Robert Dyjas https://dyjas.cc

	Workflow:
	- Get image paths from an array
	- For each image:
		- Check if the file already exists
		- If not, download

	Standards:
	- 

	Features planned:
	- Remove previous images and their thumb file
	- Check modification date and update, if newer file appears

	Known issues:
	- 

	.EXAMPLE
	Push-TeamsBackgrounds.ps1
#>

#region User settings
$imageList = @(
	'https://h2.gifposter.com/bingImages/Dargavs_EN-US4957085337_1920x1080.jpg',
	'https://h2.gifposter.com/bingImages/BulgariaDevilBridge_EN-US4705163344_1920x1080.jpg'
)
#endregion User settings

#region Variables
$uploadsFolderPath = "$($env:APPDATA)\Microsoft\Teams\Backgrounds\Uploads\"
#endregion Variables

#region Processing
try {
	foreach ($image in $imageList) {
		<# For troubleshooting
		$image = $imageList[0]
		#>
		$fileName = $image.Split('/')[-1]
		$filePath = Join-Path $uploadsFolderPath $fileName
		if (-not (Test-Path $filePath)) {
			# Download the image
			Invoke-RestMethod -Method Get -Uri $image -OutFile $filePath
		}
	}
} catch {
	$e = $_
	Write-Error $e
}
#endregion Processing