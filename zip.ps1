param(
	[string]$ZipName = "tfc_grasswaterfix.zip"
)

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $scriptDir
try {
	if (Test-Path $ZipName) {
		Write-Host "Removing existing $ZipName..."
		Remove-Item $ZipName -Force -ErrorAction Stop
	}

	Write-Host "Creating $ZipName containing 'assets' and 'pack.mcmeta'..."
	& 7z a -tzip $ZipName assets pack.mcmeta | Out-Null
	if ($LASTEXITCODE -ne 0) {
		throw "7z failed with exit code $LASTEXITCODE"
	}

	Write-Host "Zip created: $ZipName"
} catch {
	Write-Error "Failed to create zip: $_"
	exit 1
} finally {
	Pop-Location
}

# Example usage:
# .\zip.ps1
# or from anywhere:
# powershell -ExecutionPolicy Bypass -File "path\to\zip.ps1"

