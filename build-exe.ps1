<#
.SYNOPSIS
    CHARLES.AI Ultra v3.0 - EXE Builder
    Converts PowerShell script to standalone executable

.DESCRIPTION
    Automated build process:
    1. Checks PS2EXE module
    2. Installs if missing
    3. Compiles to .EXE with metadata
    4. Creates output in /builds directory
    5. Verifies executable integrity

.EXAMPLE
    .\build-exe.ps1

.AUTHOR
    Curtis Farrar | G6B Elite Gaming Systems

.VERSION
    1.0 | 2025-01-02
#>

param(
    [string]$Version = "3.0.0.0",
    [string]$OutputPath = "./builds",
    [switch]$IncludeIcon = $false,
    [string]$IconPath = $null,
    [switch]$OpenAfterBuild = $true,
    [switch]$Cleanup = $false
)

# ============================================================================
# CONSTANTS
# ============================================================================

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommandPath
$sourceScript = Join-Path $scriptRoot "charles-ai-ultra-core.ps1"
$outputDir = Join-Path $scriptRoot $OutputPath
$outputFile = Join-Path $outputDir "charles-ai-ultra-v$($Version -replace '\..+$').exe"

$BuildConfig = @{
    Title = "CHARLES.AI - Ultra Edition"
    Description = "Advanced AI Agent with Memory Management, Browser Automation & Encryption"
    Company = "G6B Elite Gaming Systems"
    Product = "CHARLES.AI"
    Version = $Version
    Copyright = "(C) 2025 Curtis Farrar - All Rights Reserved"
    Trademark = "CHARLES, OBELISK, CIVWATCH are trademarks of Curtis Farrar"
    Comment = "Enterprise-Grade AI Orchestration Platform"
}

# ============================================================================
# VALIDATION
# ============================================================================

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           CHARLES.AI BUILD SYSTEM v1.0                      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Check if source file exists
if (-not (Test-Path $sourceScript)) {
    Write-Host "❌ ERROR: Source script not found at $sourceScript" -ForegroundColor Red
    Write-Host "Expected: charles-ai-ultra-core.ps1" -ForegroundColor Yellow
    exit 1
}
Write-Host "✅ Source script found: charles-ai-ultra-core.ps1" -ForegroundColor Green

# Check admin privileges
$isAdmin = ([System.Security.Principal.WindowsIdentity]::GetCurrent().Groups -match "S-1-5-32-544") -ne $null
if (-not $isAdmin) {
    Write-Host "❌ WARNING: Admin privileges recommended for module installation" -ForegroundColor Yellow
    Write-Host "   Continuing with user-level installation..." -ForegroundColor Yellow
}
else {
    Write-Host "✅ Admin privileges detected" -ForegroundColor Green
}

# Create output directory
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    Write-Host "✅ Created output directory: $OutputPath" -ForegroundColor Green
}
else {
    Write-Host "✅ Output directory exists: $OutputPath" -ForegroundColor Green
}

# ============================================================================
# PS2EXE MODULE CHECK
# ============================================================================

Write-Host "`n[1/5] Checking PS2EXE module..." -ForegroundColor Cyan

$ps2exeModule = Get-Module -Name ps2exe -ErrorAction SilentlyContinue
if ($ps2exeModule) {
    Write-Host "✅ PS2EXE already loaded (v$($ps2exeModule.Version))" -ForegroundColor Green
}
else {
    Write-Host "Attempting to import ps2exe..." -ForegroundColor Yellow
    try {
        Import-Module ps2exe -ErrorAction Stop
        Write-Host "✅ PS2EXE module imported successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "PS2EXE not found. Installing..." -ForegroundColor Yellow
        try {
            Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force -ErrorAction SilentlyContinue
            Install-Module -Name ps2exe -Repository PSGallery -Force -ErrorAction Stop
            Import-Module ps2exe -ErrorAction Stop
            Write-Host "✅ PS2EXE installed and imported successfully" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ FATAL: Failed to install PS2EXE" -ForegroundColor Red
            Write-Host "Reason: $($_.Exception.Message)" -ForegroundColor Red
            Write-Host "`nManual installation: Install-Module -Name ps2exe -Force" -ForegroundColor Yellow
            exit 1
        }
    }
}

# ============================================================================
# COMPILATION
# ============================================================================

Write-Host "`n[2/5] Preparing compilation parameters..." -ForegroundColor Cyan

$compileParams = @{
    InputFile = $sourceScript
    OutputFile = $outputFile
    Title = $BuildConfig.Title
    Description = $BuildConfig.Description
    Company = $BuildConfig.Company
    Product = $BuildConfig.Product
    Version = $BuildConfig.Version
    Copyright = $BuildConfig.Copyright
    Trademark = $BuildConfig.Trademark
    Comment = $BuildConfig.Comment
}

# Add icon if provided
if ($IncludeIcon -and $IconPath -and (Test-Path $IconPath)) {
    $compileParams.Icon = $IconPath
    Write-Host "✅ Icon will be embedded: $IconPath" -ForegroundColor Green
}

Write-Host "✅ Compilation parameters ready" -ForegroundColor Green
Write-Host "   Version: $($BuildConfig.Version)" -ForegroundColor Gray
Write-Host "   Output: $outputFile" -ForegroundColor Gray
Write-Host "   Company: $($BuildConfig.Company)" -ForegroundColor Gray

# Execute compilation
Write-Host "`n[3/5] Compiling to executable..." -ForegroundColor Cyan
Write-Host "   This may take 30-60 seconds..." -ForegroundColor Gray

try {
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    ConvertTo-Exe @compileParams -Verbose:$false
    
    $stopwatch.Stop()
    Write-Host "✅ Compilation completed in $($stopwatch.Elapsed.TotalSeconds)s" -ForegroundColor Green
}
catch {
    Write-Host "❌ COMPILATION FAILED" -ForegroundColor Red
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# ============================================================================
# VERIFICATION
# ============================================================================

Write-Host "`n[4/5] Verifying executable..." -ForegroundColor Cyan

if (-not (Test-Path $outputFile)) {
    Write-Host "❌ Executable not found at: $outputFile" -ForegroundColor Red
    exit 1
}

$exeSize = (Get-Item $outputFile).Length
$exeSizeMB = [Math]::Round($exeSize / 1MB, 2)
Write-Host "✅ Executable verified" -ForegroundColor Green
Write-Host "   File: $outputFile" -ForegroundColor Gray
Write-Host "   Size: $exeSizeMB MB" -ForegroundColor Gray

# Get file info
if ($null -ne (Get-Command Get-Item -ErrorAction SilentlyContinue)) {
    $fileInfo = Get-Item $outputFile
    Write-Host "   Modified: $($fileInfo.LastWriteTime)" -ForegroundColor Gray
    Write-Host "   MD5: $((Get-FileHash $outputFile -Algorithm MD5).Hash.Substring(0, 16))..." -ForegroundColor Gray
}

# ============================================================================
# BUILD MANIFEST
# ============================================================================

Write-Host "`n[5/5] Creating build manifest..." -ForegroundColor Cyan

$manifest = @{
    BuildDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Version = $BuildConfig.Version
    ExecutablePath = $outputFile
    ExecutableSize = "$exeSizeMB MB"
    SourceFile = $sourceScript
    BuildTool = "PS2EXE"
    PowerShellVersion = $PSVersionTable.PSVersion.ToString()
    BuildMetadata = $BuildConfig
}

$manifestFile = Join-Path $outputDir "build-manifest-$($BuildConfig.Version).json"
$manifest | ConvertTo-Json | Set-Content -Path $manifestFile -Force
Write-Host "✅ Manifest created: build-manifest-$($BuildConfig.Version).json" -ForegroundColor Green

# ============================================================================
# SUCCESS SUMMARY
# ============================================================================

Write-Host "`n╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                   ✅ BUILD SUCCESSFUL ✅                      ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Green

Write-Host "`nExecutable ready for distribution:" -ForegroundColor Green
Write-Host "  📑 Location: $outputFile" -ForegroundColor Cyan
Write-Host "  📌 Size: $exeSizeMB MB" -ForegroundColor Cyan
Write-Host "  🔗 Version: $($BuildConfig.Version)" -ForegroundColor Cyan
Write-Host "  🔐 Signature: Charles AI Ultra" -ForegroundColor Cyan

Write-Host "`nNext steps:" -ForegroundColor Yellow
Write-Host "  1. Set environment variables (see SETUP_GUIDE.md)" -ForegroundColor Yellow
Write-Host "  2. Double-click .EXE to launch" -ForegroundColor Yellow
Write-Host "  3. Agree to execution policy prompt" -ForegroundColor Yellow
Write-Host "  4. Click 'Launch Browser' to initialize" -ForegroundColor Yellow

# Optional: Open executable location
if ($OpenAfterBuild) {
    Write-Host "`nOpening output directory..." -ForegroundColor Gray
    Start-Process -FilePath "explorer.exe" -ArgumentList $outputDir
}

# Optional: Cleanup old builds
if ($Cleanup) {
    Write-Host "`nCleaning up old builds..." -ForegroundColor Gray
    Get-ChildItem -Path $outputDir -Filter "*.exe" |
        Where-Object { $_.Name -ne (Split-Path -Leaf $outputFile) } |
        Remove-Item -Force
    Write-Host "✅ Cleanup complete" -ForegroundColor Green
}

Write-Host "`n" -ForegroundColor Gray
