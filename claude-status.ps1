# Enhanced Claude Code Status Line Script
$input_json = [Console]::In.ReadToEnd()
$data = $input_json | ConvertFrom-Json

$model = if ($data.model.display_name) { $data.model.display_name } else { 'Claude' }
$currentPath = if ($data.cwd) { $data.cwd } else { (Get-Location).Path }

# Get additional system info
$timestamp = Get-Date -Format "HH:mm"
$userName = $env:USERNAME

# Start building colorful statusline
Write-Host "[" -ForegroundColor DarkGray -NoNewline
Write-Host $model -ForegroundColor Cyan -NoNewline
Write-Host "] " -ForegroundColor DarkGray -NoNewline

# Show current directory with shortened path
$shortPath = if ($currentPath.Length -gt 50) { 
    "..." + $currentPath.Substring($currentPath.Length - 47) 
} else { 
    $currentPath 
}
Write-Host $shortPath -ForegroundColor Yellow -NoNewline

# Git information with colors
if (Test-Path .git) {
    $branch = git branch --show-current 2>$null
    if ($branch) {
        Write-Host " (" -ForegroundColor DarkGray -NoNewline
        Write-Host "git:" -ForegroundColor DarkGray -NoNewline
        Write-Host $branch -ForegroundColor Green -NoNewline
        
        $status = git status --porcelain 2>$null
        if ($status) {
            # Count changes
            $modified = ($status | Where-Object { $_ -match "^ M" }).Count
            $added = ($status | Where-Object { $_ -match "^A " }).Count
            $deleted = ($status | Where-Object { $_ -match "^ D" }).Count
            $untracked = ($status | Where-Object { $_ -match "^\?\?" }).Count
            
            if ($modified -gt 0) { Write-Host " ~$modified" -ForegroundColor Yellow -NoNewline }
            if ($added -gt 0) { Write-Host " +$added" -ForegroundColor Green -NoNewline }
            if ($deleted -gt 0) { Write-Host " -$deleted" -ForegroundColor Red -NoNewline }
            if ($untracked -gt 0) { Write-Host " ?$untracked" -ForegroundColor Magenta -NoNewline }
        } else {
            Write-Host " clean" -ForegroundColor Green -NoNewline
        }
        Write-Host ")" -ForegroundColor DarkGray -NoNewline
    }
}

# Show time and user info
Write-Host " [" -ForegroundColor DarkGray -NoNewline
Write-Host $timestamp -ForegroundColor White -NoNewline
Write-Host "|" -ForegroundColor DarkGray -NoNewline
Write-Host $userName -ForegroundColor Blue -NoNewline
Write-Host "] " -ForegroundColor DarkGray -NoNewline

# Final prompt
Write-Host ">" -ForegroundColor Cyan -NoNewline