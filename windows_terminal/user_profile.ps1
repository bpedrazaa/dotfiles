Import-Module posh-git
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/gruvbox.omp.json" | Invoke-Expression

Import-Module PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -ShowToolTips:$False
Set-PSReadLineOption -PredictionViewStyle ListView

$ScriptBlock = {
    Param([string]$line)
    $allowedCommands = @(
      'ls',
      'clear',
      'exit'
    )
    if (($line -match '^(git|docker|ssh|scp|choco|nvim|cd)') -or ($allowedCommands -contains $line)){
        return $false
    } else {
        return $true
    }
}
Set-PSReadLineOption -AddToHistoryHandler $ScriptBlock

Import-Module -Name Terminal-Icons

function tc{
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [string]$FolderPath = $PWD,
        [Parameter(Mandatory = $false, Position = 1)]
        [Alias('r')]
        [switch]$RightPane
    )
    if($RightPane){
        $pane = "R"
    }
    else{
        $pane = "L"
    }

    & "C:\Program Files\Totalcmd\TOTALCMD64.EXE" /O /T /$pane="$FolderPath"
}
