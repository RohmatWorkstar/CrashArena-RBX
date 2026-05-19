$inputFile = "C:\Users\hary\.gemini\antigravity\brain\97645e54-0c84-461b-a650-7ef58c8a22dc\.system_generated\steps\34\output.txt"
$outputDir = "C:\Users\hary\.gemini\antigravity\scratch\CrashArena"

$jsonStr = Get-Content -Raw -Path $inputFile -Encoding UTF8
$data = ConvertFrom-Json $jsonStr

$tree = $data.tree
$scripts = $data.scripts

$tree | ConvertTo-Json -Depth 10 | Set-Content -Path "$outputDir\tree.json" -Encoding UTF8

foreach ($script in $scripts) {
    $path = $script.path
    $source = $script.source
    
    $parts = $path -split '\.'
    $filename = $parts[-1] + ".lua"
    
    if ($parts.Length -gt 1) {
        $dirParts = $parts[0..($parts.Length - 2)]
        $dirPath = Join-Path $outputDir "scripts"
        foreach ($part in $dirParts) {
            $dirPath = Join-Path $dirPath $part
        }
    } else {
        $dirPath = Join-Path $outputDir "scripts"
    }
    
    if (-not (Test-Path $dirPath)) {
        New-Item -ItemType Directory -Force -Path $dirPath | Out-Null
    }
    
    $filePath = Join-Path $dirPath $filename
    Set-Content -Path $filePath -Value $source -Encoding UTF8
}

Write-Host "Successfully extracted scripts and tree."
