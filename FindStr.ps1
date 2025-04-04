param (
    [string]$Path,  # The path to search in
    [string]$String, # The string to search for
    [string[]]$FileType = $null # The file type to search in (e.g., "txt", "log"), default is null
)

if (-not $Path) {
    throw "The Path parameter cannot be null or empty."
}

if (-not $String) {
    throw "The String parameter cannot be null or empty."
}

if ($FileType) {
    Get-ChildItem -path $Path `
                  -Exclude "*.tlog", "*.obj", "*.pdb", "*.dll", "*.exe", "*.lib", "*.db", "*.db-shm", "*.db-wal", "*.suo" `
                  -Recurse | `
        Select-String -Pattern $String -Include $FileType | Select-Object Filename, Path
} else {
    Get-ChildItem -path $Path `
                  -Exclude "*.tlog", "*.obj", "*.pdb", "*.dll", "*.exe", "*.lib", "*.db", "*.db-shm", "*.db-wal", "*.suo" `
                  -Recurse | `
        Select-String -Pattern $String | Select-Object Filename, Path
}
