# Advanced Search Script (advanced-search.ps1)

param(
    # The search pattern to look for in files (required).
    [Parameter(Mandatory=$true)]
    [string]$pattern,

    # The directory path to search in (default is the current directory).
    [Parameter(Mandatory=$false)]
    [string]$path = ".",

    # File patterns to include in the search (default is all files).
    [Parameter(Mandatory=$false)]
    [string[]]$include = @("*.*"),

    # File patterns to exclude from the search.
    [Parameter(Mandatory=$false)]
    [string[]]$exclude = @(),

    # Perform a case-insensitive search if specified.
    [Parameter(Mandatory=$false)]
    [switch]$ignoreCase,

    # Search recursively in subdirectories if specified.
    [Parameter(Mandatory=$false)]
    [switch]$recursive,

    # Display context lines around the match if specified.
    [Parameter(Mandatory=$false)]
    [switch]$context,

    # Number of context lines to display (default is 2).
    [Parameter(Mandatory=$false)]
    [int]$contextLines = 2,

    # Only display the count of matches if specified.
    [Parameter(Mandatory=$false)]
    [switch]$countOnly
)

# Function to check if a file should be excluded
function ShouldExcludeFile($file) {
    foreach ($pattern in $exclude) {
        if ($file.Name -like $pattern) {
            return $true
        }
    }
    return $false
}

# Function to display context lines
function ShowContext($file, $lineNumber, $contextLines) {
    $content = Get-Content $file.FullName
    $start = [Math]::Max(1, $lineNumber - $contextLines)
    $end = [Math]::Min($content.Count, $lineNumber + $contextLines)

    Write-Host "`nContext for $($file.FullName):$lineNumber" -ForegroundColor Cyan
    for ($i = $start; $i -le $end; $i++) {
        $prefix = if ($i -eq $lineNumber) { ">" } else { " " }
        Write-Host ("{0,4}{1} {2}" -f $i, $prefix, $content[$i-1])
    }
}

$searchParams = @{
    Path = $path
    Include = $include
}

if ($recursive) {
    $searchParams.Recurse = $true
}

$files = Get-ChildItem @searchParams | Where-Object {
    !$_.PSIsContainer -and !(ShouldExcludeFile $_)
}

$totalMatches = 0

foreach ($file in $files) {
    $selectStringParams = @{
        Path    = $file.FullName
        Pattern = $pattern
    }

    if ($ignoreCase) {
        $selectStringParams.IgnoreCase = $true
    }

    $matches = Select-String @selectStringParams
    $totalMatches += $matches.Count

    if (!$countOnly -and $matches) {
        foreach ($match in $matches) {
            Write-Host "`n$($match.Path):$($match.LineNumber)" -ForegroundColor Yellow -NoNewline

            if ($context) {
                ShowContext $file $match.LineNumber $contextLines
            }
        }
    }
}

Write-Host "`nTotal matches found: $totalMatches" -ForegroundColor Green

# Example usage:

# Basic search
#.\FindStr.ps1 -pattern "someKeyword"

# Search with multiple file types
#.\FindStr.ps1 -pattern "someKeyword" -include @("*.cs","*.js") -recursive

# Exclude certain files
#.\FindStr.ps1 -pattern "someKeyword" -exclude @("*.min.js","*.generated.cs") -recursive

# Show context lines
#.\FindStr.ps1 -pattern "someKeyword" -context -contextLines 3

# Count only
#.\FindStr.ps1 -pattern "someKeyword" -countOnly