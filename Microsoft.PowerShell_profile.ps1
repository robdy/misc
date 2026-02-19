$simplePrompt = {function prompt { "PS> "}}
$advPrompt = {function Prompt {
  if ((Get-History).count -ge 1) {
  $executionTime = ((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Totalmilliseconds
  $time = [math]::Round($executionTime,2)
  $promptString = ("$time ms | " + $(Get-Location) + ">")
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
