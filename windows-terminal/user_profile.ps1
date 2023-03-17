# Prompt
Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\gruvbox2.omp.json" | Invoke-Expression

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Icons
Import-Module -Name Terminal-Icons
