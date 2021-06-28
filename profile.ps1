Import-Module 'C:\Development\src\posh-git\src\posh-git.psd1'

function Set-PoshGitPrompt {
    # DefaultPromptPath bit from https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
    # Split-Path bit from https://superuser.com/a/446836
    $GitPromptSettings.DefaultPromptPath.Text = '$(Split-Path -leaf -path ($ExecutionContext.SessionState.Path.CurrentLocation))'
}

function Show-GitStatus{
    git status
}

function Show-GitLog {
    git log --oneline --all --graph
}

function Show-GitDiff {
    git diff
}

function Get-GitFetchAll{
    git fetch -all
}

function Get-GitPullOriginMaster{
    git pull origin master -r
}

function Get-GitAddAll{
    git add *
}

function Get-GitPushSetUpstream {
    param (
        [string]$branchName
    )
    git push -u origin $branchName
}

function Set-GitAliases {
    # Remove GL (Get-Location) forcefully
    if (Test-Path alias:gl) {
        Remove-Item alias:gl -Force
    }
	
    Set-Alias -Name gl -Value Show-GitLog -Scope Global
    Set-Alias -Name gd -Value Show-GitDiff -Scope Global
    Set-Alias -Name gs -Value Show-GitStatus -Scope Global
    Set-Alias -Name ga -Value Get-GitAddAll -Scope Global
    Set-Alias -Name gf -Value Get-GitFetchAll -Scope Global
    Set-Alias -Name gprm -Value Get-GitPullOriginMaster -Scope Global
}

Set-PoshGitPrompt
Set-GitAliases