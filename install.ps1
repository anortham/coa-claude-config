#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Install COA Claude Configuration

.DESCRIPTION
    This script installs the COA Claude team configuration by creating symbolic links
    and copying necessary files to the user's ~/.claude directory.

.PARAMETER Force
    Force installation even if ~/.claude already exists (will backup existing)

.PARAMETER NoBackup
    Skip backing up existing ~/.claude directory

.EXAMPLE
    .\install.ps1
    
.EXAMPLE
    .\install.ps1 -Force -NoBackup
#>

param(
    [switch]$Force,
    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

# Get paths
$claudeDir = "$env:USERPROFILE\.claude"
$configRepo = $PSScriptRoot
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'

Write-Host "🔧 COA Claude Configuration Installer" -ForegroundColor Cyan
Write-Host "Config Repository: $configRepo" -ForegroundColor Gray
Write-Host "Target Directory: $claudeDir" -ForegroundColor Gray

# Check if running as administrator for symlinks
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Warning "Not running as Administrator. Will copy files instead of creating symlinks."
    Write-Host "For symlinks, run PowerShell as Administrator." -ForegroundColor Yellow
}

# Backup existing configuration
if (Test-Path $claudeDir) {
    if (-not $Force) {
        $response = Read-Host "~/.claude directory exists. Continue? (y/N)"
        if ($response -notmatch '^[Yy]') {
            Write-Host "❌ Installation cancelled." -ForegroundColor Red
            exit 1
        }
    }
    
    if (-not $NoBackup) {
        $backupDir = "$claudeDir.backup.$timestamp"
        Write-Host "📦 Backing up existing ~/.claude to: $backupDir" -ForegroundColor Yellow
        Move-Item $claudeDir $backupDir
        Write-Host "✅ Backup created successfully" -ForegroundColor Green
    } else {
        Remove-Item $claudeDir -Recurse -Force
        Write-Host "🗑️  Removed existing ~/.claude directory" -ForegroundColor Yellow
    }
}

# Create ~/.claude directory
New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
Write-Host "📁 Created ~/.claude directory" -ForegroundColor Green

# Install configurations
try {
    if ($isAdmin) {
        # Create symbolic links (requires admin)
        Write-Host "🔗 Creating symbolic links..." -ForegroundColor Cyan
        
        New-Item -ItemType SymbolicLink -Path "$claudeDir\agents" -Target "$configRepo\agents" -Force | Out-Null
        Write-Host "  ✅ agents/" -ForegroundColor Green
        
        New-Item -ItemType SymbolicLink -Path "$claudeDir\commands" -Target "$configRepo\commands" -Force | Out-Null
        Write-Host "  ✅ commands/" -ForegroundColor Green
        
        Write-Host "🔗 Symbolic links created successfully" -ForegroundColor Green
    } else {
        # Copy directories (fallback)
        Write-Host "📂 Copying configuration directories..." -ForegroundColor Cyan
        
        Copy-Item "$configRepo\agents" "$claudeDir\agents" -Recurse -Force
        Write-Host "  ✅ agents/ (copied)" -ForegroundColor Green
        
        Copy-Item "$configRepo\commands" "$claudeDir\commands" -Recurse -Force  
        Write-Host "  ✅ commands/ (copied)" -ForegroundColor Green
        
        Write-Host "📂 Configuration directories copied successfully" -ForegroundColor Green
    }
    
    # Copy configuration files
    Write-Host "📄 Installing configuration files..." -ForegroundColor Cyan
    
    Copy-Item "$configRepo\settings.json" "$claudeDir\settings.json" -Force
    Write-Host "  ✅ settings.json" -ForegroundColor Green
    
    Copy-Item "$configRepo\CLAUDE.md" "$claudeDir\CLAUDE.md" -Force
    Write-Host "  ✅ CLAUDE.md" -ForegroundColor Green
    
    Copy-Item "$configRepo\claude-status.ps1" "$claudeDir\claude-status.ps1" -Force
    Write-Host "  ✅ claude-status.ps1" -ForegroundColor Green
    
    # Restore preserved files if backup exists
    $backupDir = "$claudeDir.backup.$timestamp"
    if (-not $NoBackup -and (Test-Path $backupDir)) {
        Write-Host "🔄 Restoring preserved files from backup..." -ForegroundColor Cyan
        
        # Restore credentials
        if (Test-Path "$backupDir\.credentials.json") {
            Copy-Item "$backupDir\.credentials.json" "$claudeDir\.credentials.json" -Force
            Write-Host "  ✅ .credentials.json" -ForegroundColor Green
        }
        
        # Restore status line settings
        if (Test-Path "$backupDir\statusline.json") {
            Copy-Item "$backupDir\statusline.json" "$claudeDir\statusline.json" -Force
            Write-Host "  ✅ statusline.json" -ForegroundColor Green
        }
        
        # Restore other user-specific files
        if (Test-Path "$backupDir\cclsp.json") {
            Copy-Item "$backupDir\cclsp.json" "$claudeDir\cclsp.json" -Force
            Write-Host "  ✅ cclsp.json" -ForegroundColor Green
        }
    }
    
    Write-Host ""
    Write-Host "🎉 Installation completed successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📋 Installed Components:" -ForegroundColor Cyan
    Write-Host "  • 7 TDD Team Agents (codebase-auditor, test-designer, etc.)" -ForegroundColor White
    Write-Host "  • 9 Commands (audit, tdd-fix, tdd-new, standup, etc.)" -ForegroundColor White
    Write-Host "  • Clean settings.json (hooks removed)" -ForegroundColor White
    Write-Host "  • Global development standards (CLAUDE.md)" -ForegroundColor White
    Write-Host "  • PowerShell status line script" -ForegroundColor White
    Write-Host ""
    Write-Host "🚀 Next Steps:" -ForegroundColor Cyan
    Write-Host "  1. Restart Claude Code to load new configurations" -ForegroundColor White
    Write-Host "  2. Try: /audit, /tdd-fix, /standup, etc." -ForegroundColor White
    Write-Host "  3. Use TDD team agents for development workflows" -ForegroundColor White
    
    if (-not $isAdmin) {
        Write-Host ""
        Write-Host "💡 Tip: For automatic updates via symlinks, re-run as Administrator" -ForegroundColor Yellow
    }
    
} catch {
    Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "📖 Documentation: See README.md for usage details" -ForegroundColor Gray