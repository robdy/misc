[CmdletBinding()]
param (
    [Parameter()]
    [int]
    # Number of images to download, max = 8
    # https://stackoverflow.com/questions/10639914/is-there-a-way-to-get-bings-photo-of-the-day?answertab=trending#comment77239594_23150436
    $Number = 1
)
# Get image of the day
$myPicturesFolderPath = [Environment]::GetFolderPath("MyPictures")
$wallpaperFolderPath = Join-Path $myPicturesFolderPath "BingWallpapers"
if (-not (Test-Path $wallpaperFolderPath)) {
    New-Item -ItemType Directory -Path $wallpaperFolderPath | Out-Null
}
try {
    # Get image URL
    # idx > skip; n > number of images to list
    $HPimageRes = Invoke-RestMethod -Uri "https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=$Number" -ErrorAction 'Stop'

    # Download last image
    for ($i=0; $i -lt $Number; $i++) {
        $imageData = $HPimageRes.images[$i]
        $imageUrl = $imageData.url
        $imageTimeStamp = $imageData.startdate
        $imageName = "$imageTimeStamp.jpg"
        $imagePath = Join-Path $wallpaperFolderPath $imageName
        if (Test-Path $imagePath) {
            Write-Verbose "Image already exists $imageName"
            continue
        }
        Invoke-RestMethod -Uri "https://bing.com/$imageUrl" -OutFile $imagePath
        }
} catch {
    $e = $_
    Write-Error $e
}
