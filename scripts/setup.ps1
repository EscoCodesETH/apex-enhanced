# APEX Enhanced Setup Script for Windows
# Automatically configures APEX for your AI coding assistant

$ErrorActionPreference = "Stop"

Write-Host "🚀 APEX Enhanced Setup" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host ""

# Function to create directory if it doesn't exist
function Create-DirectoryIfNotExists {
    param($Path)
    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
        Write-Host "✓ Created $Path" -ForegroundColor Green
    } else {
        Write-Host "→ $Path already exists" -ForegroundColor Yellow
    }
}

# Function to copy file if it doesn't exist
function Copy-FileIfNotExists {
    param($Source, $Destination)
    if (!(Test-Path $Destination)) {
        Copy-Item $Source $Destination
        Write-Host "✓ Installed $Destination" -ForegroundColor Green
    } else {
        Write-Host "→ $Destination already exists (skipping)" -ForegroundColor Yellow
    }
}

# Check if we're in a git repository
if (Test-Path .git) {
    Write-Host "✓ Git repository detected" -ForegroundColor Green
} else {
    Write-Host "⚠ Not in a git repository (some features may be limited)" -ForegroundColor Yellow
}
Write-Host ""

# Detect AI tool
Write-Host "Detecting AI tool configuration..." -ForegroundColor Blue
$Tool = "none"

if (Test-Path .claude) {
    $Tool = "claude"
    Write-Host "✓ Claude project detected" -ForegroundColor Green
} elseif (Test-Path .cursorrules) {
    $Tool = "cursor"
    Write-Host "✓ Cursor project detected" -ForegroundColor Green
} elseif (Test-Path .github\copilot) {
    $Tool = "copilot"
    Write-Host "✓ GitHub Copilot detected" -ForegroundColor Green
} elseif (Test-Path .continue\config.json) {
    $Tool = "continue"
    Write-Host "✓ Continue.dev detected" -ForegroundColor Green
}

if ($Tool -eq "none") {
    Write-Host ""
    Write-Host "Which AI tool are you using?" -ForegroundColor Cyan
    Write-Host "1) Claude Projects"
    Write-Host "2) Cursor"
    Write-Host "3) GitHub Copilot"
    Write-Host "4) Continue.dev"
    Write-Host "5) Other/Manual setup"
    $choice = Read-Host "Select (1-5)"
    
    switch ($choice) {
        1 { $Tool = "claude" }
        2 { $Tool = "cursor" }
        3 { $Tool = "copilot" }
        4 { $Tool = "continue" }
        5 { $Tool = "manual" }
        default { Write-Host "Invalid choice" -ForegroundColor Red; exit 1 }
    }
}

Write-Host ""
Write-Host "Setting up APEX Enhanced for $Tool..." -ForegroundColor Blue
Write-Host ""

# Get the directory where the script is located
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplateDir = Join-Path $ScriptDir "..\templates"

# Setup based on tool
switch ($Tool) {
    "claude" {
        Create-DirectoryIfNotExists ".claude"
        Create-DirectoryIfNotExists ".claude\commands"
        Copy-FileIfNotExists "$TemplateDir\.claude\apex.md" ".claude\apex.md"
        Copy-FileIfNotExists "$TemplateDir\.claude\commands\apex-feature.md" ".claude\commands\apex-feature.md"
        Copy-FileIfNotExists "$TemplateDir\.claude\commands\apex-task.md" ".claude\commands\apex-task.md"
        Copy-FileIfNotExists "$TemplateDir\.claude\commands\apex-review.md" ".claude\commands\apex-review.md"
        Copy-FileIfNotExists "$TemplateDir\.claude\commands\apex-commit.md" ".claude\commands\apex-commit.md"
    }
    
    "cursor" {
        Copy-FileIfNotExists "$TemplateDir\cursor\.cursorrules" ".cursorrules"
        Write-Host "ℹ Cursor will automatically load .cursorrules" -ForegroundColor Blue
    }
    
    "copilot" {
        Create-DirectoryIfNotExists ".github"
        Create-DirectoryIfNotExists ".github\copilot"
        Copy-FileIfNotExists "$TemplateDir\.github\copilot\instructions.md" ".github\copilot\instructions.md"
    }
    
    "continue" {
        Write-Host "⚠ Continue.dev support is community-maintained" -ForegroundColor Yellow
        Write-Host "Please see the documentation for manual setup"
    }
    
    "manual" {
        Write-Host "For manual setup, copy the appropriate files from:"
        Write-Host "$TemplateDir"
        Write-Host ""
        Write-Host "Available configurations:"
        Write-Host "- Claude: .claude\apex.md and commands\"
        Write-Host "- Cursor: cursor\.cursorrules"
        Write-Host "- Copilot: .github\copilot\instructions.md"
    }
}

Write-Host ""
Write-Host "✨ APEX Enhanced setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Restart your AI tool to load the new configuration"
Write-Host "2. Try: 'Implement a simple feature using APEX Enhanced'"
Write-Host "3. Check the docs at: https://github.com/yourusername/apex-enhanced"
Write-Host ""
Write-Host "Quick commands:" -ForegroundColor Cyan
Write-Host "- Start feature: 'implement [feature] with APEX'"
Write-Host "- Show progress: 'show APEX task progress'"
Write-Host "- Code review: 'review with APEX Sandi Metz principles'"
Write-Host "- Smart commit: 'create APEX commit'"
Write-Host ""
Write-Host "Happy coding with APEX Enhanced! 🚀" -ForegroundColor Blue