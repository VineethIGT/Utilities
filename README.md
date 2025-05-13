# Utilities
Utility applications for work. 

# FindStr.ps1
PowerShell script that searches for a specific string within files in a given directory. It supports optional filtering by file type, exclusion of certain file types, recursive search, case-insensitive search, and displaying context lines around matches.

## Usage

```powershell
.\FindStr.ps1 -pattern <string> [-path <directory>] [-include <filetypes>] [-exclude <filetypes>] [-ignoreCase] [-recursive] [-context] [-contextLines <number>] [-countOnly]
```

## Parameters

- `-pattern <string>`: The string or pattern to search for. This is a required parameter.
- `-path <directory>`: (Optional) The directory path to search in. Defaults to the current directory.
- `-include <filetypes>`: (Optional) File patterns to include in the search (e.g., `*.txt`, `*.cs`). Defaults to all files.
- `-exclude <filetypes>`: (Optional) File patterns to exclude from the search (e.g., `*.min.js`, `*.log`).
- `-ignoreCase`: (Optional) Perform a case-insensitive search.
- `-recursive`: (Optional) Search recursively in subdirectories.
- `-context`: (Optional) Display context lines around the match.
- `-contextLines <number>`: (Optional) Number of context lines to display. Defaults to 2.
- `-countOnly`: (Optional) Only display the count of matches.

## Examples

- Basic search:
  ```powershell
  .\FindStr.ps1 -pattern "someKeyword"
  ```

- Search with multiple file types:
  ```powershell
  .\FindStr.ps1 -pattern "someKeyword" -include @("*.cs", "*.js") -recursive
  ```

- Exclude certain files:
  ```powershell
  .\FindStr.ps1 -pattern "someKeyword" -exclude @("*.min.js", "*.generated.cs") -recursive
  ```

- Show context lines:
  ```powershell
  .\FindStr.ps1 -pattern "someKeyword" -context -contextLines 3
  ```

- Count only:
  ```powershell
  .\FindStr.ps1 -pattern "someKeyword" -countOnly
  ```
