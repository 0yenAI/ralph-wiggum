# Ralph Wiggum Package Build Script
# Author: Kai
# Date: 2025-12-29

$ErrorActionPreference = "Stop"

# Configuration
$ProjectName = "RalphWiggum_for_Gemini"
$SourceFiles = @("ralph_gemini.py", "README.md", "LICENSE", "booth_description.txt")
$OutputDir = "dist"
$DistFolder = "$OutputDir\$ProjectName"
$ZipFileName = "$OutputDir\$ProjectName.zip"

Write-Host "📦 Starting package build for $ProjectName..." -ForegroundColor Cyan

# 1. Clean up previous build
if (Test-Path $OutputDir) {
    Write-Host "   - Cleaning output directory..."
    Remove-Item -Path $OutputDir -Recurse -Force
}
New-Item -ItemType Directory -Path $DistFolder | Out-Null

# 2. Copy files
Write-Host "   - Copying files..."
foreach ($file in $SourceFiles) {
    if (Test-Path $file) {
        Copy-Item -Path $file -Destination $DistFolder
        Write-Host "     + $file copied." -ForegroundColor Green
    } else {
        Write-Warning "     ! File not found: $file"
    }
}

# 3. Create Zip Archive
Write-Host "   - Creating zip archive..."
Compress-Archive -Path "$DistFolder\*" -DestinationPath $ZipFileName

# 4. Cleanup temporary folder (optional, kept for inspection usually, but let's clean here)
# Remove-Item -Path $DistFolder -Recurse -Force

Write-Host "✅ Build Complete!" -ForegroundColor Cyan
Write-Host "   - Package: $ZipFileName"
Write-Host "   - Contents: $(Get-Item $ZipFileName).Length bytes"
