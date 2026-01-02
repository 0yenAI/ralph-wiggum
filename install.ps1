# Ralph Wiggum Installation Script for Windows (Antigravity & GeminiCLI Support)
# This script sets up the project for use with slash commands in both IDE and Terminal.

$ProjectDir = Get-Location
$WorkflowsDir = Join-Path $ProjectDir ".agent\workflows"
$ScriptPath = Join-Path $ProjectDir "ralph_gemini.py"

Write-Host "🔧 Setting up Ralph Wiggum for Antigravity & GeminiCLI..." -ForegroundColor Cyan

# 1. Create workflows directory for Antigravity
if (-not (Test-Path $WorkflowsDir)) {
    New-Item -ItemType Directory -Path $WorkflowsDir -Force | Out-Null
    Write-Host "✅ Created .agent/workflows directory for Antigravity." -ForegroundColor Green
}

# 2. Check for Python
if (Get-Command python -ErrorAction SilentlyContinue) {
    $PythonVer = python --version
    Write-Host "✅ Found Python: $PythonVer" -ForegroundColor Green
}
else {
    Write-Host "❌ Python not found. Please install Python 3.8+ from https://python.org" -ForegroundColor Red
    exit 1
}

# 3. Add functions to PowerShell Profile for GeminiCLI (Terminal) support
# This allows using /ralph-loop and /cancel-ralph directly in the shell.
$ProfilePath = $PROFILE.CurrentUserAllHosts
if (-not (Test-Path $ProfilePath)) {
    $null = New-Item -Path (Split-Path $ProfilePath) -ItemType Directory -Force
    $null = New-Item -Type File -Path $ProfilePath -Force
}

$FunctionDefinitions = @"

# --- Ralph Wiggum Functions ---
function /ralph-loop {
    param(
        [Parameter(Mandatory=`$true, Position=0)]
        [string]`$prompt,
        [int]`$maxIterations = 50,
        [string]`$completionPromise
    )
    python "$ScriptPath" "`$prompt" --max-iterations `$maxIterations --completion-promise "`$completionPromise"
}

function /cancel-ralph {
    Write-Host "Stopping Ralph Loop..." -ForegroundColor Yellow
    Get-Process python | Where-Object { `$_.CommandLine -like "*ralph_gemini.py*" } | Stop-Process -Force
    Write-Host "✅ Cancelled." -ForegroundColor Green
}
# --- End Ralph Wiggum ---
"@

if ((Get-Content $ProfilePath) -notcontains "# --- Ralph Wiggum Functions ---") {
    Add-Content -Path $ProfilePath -Value $FunctionDefinitions
    Write-Host "✅ Added /ralph-loop and /cancel-ralph to your PowerShell Profile." -ForegroundColor Green
    Write-Host "💡 Please restart your terminal or run: . `$PROFILE" -ForegroundColor Yellow
}
else {
    Write-Host "ℹ️  Slash commands already exist in your PowerShell Profile." -ForegroundColor Gray
}

Write-Host "`n🚀 Setup Complete!" -ForegroundColor Cyan
Write-Host "Commands available in both Antigravity and GeminiCLI (Terminal):"
Write-Host "  /ralph-loop `"<prompt>`" --max-iterations <n> --completion-promise `"<text>`""
Write-Host "  /cancel-ralph"
Write-Host "`nEnjoy your autonomous loops! 🍩" -ForegroundColor Magenta
