<#
.SYNOPSIS
    Configuration Helper Module for CharlesAI Ultra
.DESCRIPTION
    Provides functions for loading, saving, and managing configuration
#>

function Get-CharlesConfig {
    [CmdletBinding()]
    param(
        [string]$ConfigPath = "$env:APPDATA\CharlesAI\config.json"
    )
    
    if (Test-Path $ConfigPath) {
        try {
            $config = Get-Content $ConfigPath -Raw | ConvertFrom-Json
            return $config
        }
        catch {
            Write-Warning "Failed to load config from $ConfigPath: $_"
            return $null
        }
    }
    else {
        Write-Verbose "Config file not found at $ConfigPath. Creating default."
        return New-CharlesDefaultConfig
    }
}

function New-CharlesDefaultConfig {
    [CmdletBinding()]
    param()
    
    return [PSCustomObject]@{
        Version = "3.0.0"
        Agent = @{
            Name = "CHARLES"
            LogLevel = "INFO"
            MaxTokens = 10000
        }
        Browser = @{
            Headless = $false
            UserAgent = "CharlesAI/3.0"
        }
        API = @{
            PerplexityKey = ""
            OpenAIKey = ""
        }
        Vault = @{
            Enabled = $true
            EncryptionEnabled = $true
        }
    }
}

function Save-CharlesConfig {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [PSCustomObject]$Config,
        
        [string]$ConfigPath = "$env:APPDATA\CharlesAI\config.json"
    )
    
    $configDir = Split-Path $ConfigPath -Parent
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }
    
    try {
        $Config | ConvertTo-Json -Depth 10 | Set-Content $ConfigPath -Force
        Write-Verbose "Config saved to $ConfigPath"
        return $true
    }
    catch {
        Write-Error "Failed to save config: $_"
        return $false
    }
}

Export-ModuleMember -Function Get-CharlesConfig, New-CharlesDefaultConfig, Save-CharlesConfig