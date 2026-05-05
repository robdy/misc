$simplePrompt = {function prompt { "PS> "}}
$advPrompt = {function Prompt {
  if ((Get-History).count -ge 1) {
  $executionTime = ((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Totalmilliseconds
  $timeString = "$([math]::Round($executionTime,0)) ms | "
  if ($executionTime -ge 1000)     { $timeString = "$([math]::Round($executionTime/1000,0)) s | " }
  if ($executionTime -ge 60000)    { $timeString = "$([math]::Round($executionTime/60000,0)) m | " }
  if ($executionTime -ge 3600000 ) { $timeString = "$([math]::Round($executionTime/3600000,0)) h | " }
  
  $promptString = ($timeString + $(Get-Location) + ">")
  Write-Host $promptString -NoNewline -ForegroundColor cyan
  return " "
  } else {
    $promptString = ("0 ms | " + $(Get-Location) + ">")
    Write-Host $promptString -NoNewline -ForegroundColor cyan
    return " "
  }
}}

. $advPrompt

# Default param values
$PSDefaultParameterValues = @{
  "Connect-ExchangeOnline:ShowBanner" = $false
  "Connect-MgGraph:NoWelcome" = $true
  "Install-Module:Scope" = "CurrentUser"
}
