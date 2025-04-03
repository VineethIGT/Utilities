# Utilities
Utility applications for work. 

# FindStr.ps1
PowerShell script that searches for a specific string within files in a given directory. It supports optional filtering by file type and excludes certain file types by default.

## Usage

```powershell
[FindStr.ps1] <location> <string> [filetype]
```

## Parameters

- `<location>`: The directory path to search in. This is a required parameter.
- `<string>`: The string to search for. This is a required parameter.
- `[filetype]`: (Optional) A specific file type to include in the search (e.g., `*.txt`).
