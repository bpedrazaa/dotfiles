# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -ShowToolTips:$False
Set-PSReadLineOption -PredictionViewStyle ListView

$ScriptBlock = {
  Param([string]$line)
  $commands = @(
    "clear",
    "exit",
    "ll",
    "nvim $PROFILE",
    "nvim (Get-PSReadlineOption).HistorySavePath"
  )
  if (($line -match "^(cd|choco|git|ls|nvim|rm|scoop|scp|ssh|sudo|wezterm|z)") -or ($commands -contains $line)){
    return $false
  } else {
    return $true
  }
}
Set-PSReadLineOption -AddToHistoryHandler $ScriptBlock

# Icons
Import-Module -Name Terminal-Icons

# Change custom scheme
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\mod_theme.yaml" | Invoke-Expression

# Initialize zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
