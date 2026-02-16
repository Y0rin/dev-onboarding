# ==============================================================================
# Script: Setup-JDKEnvironment.ps1
# Purpose: Automates setting JAVA_HOME and updating System PATH for Android Dev
# Requirement: MUST Run as Administrator
# ==============================================================================

# 1. Define your exact JDK installation path here
$jdkPath = "C:\devtools\jdk17" 

if (Test-Path $jdkPath) {
    # 2. Set the JAVA_HOME System Environment Variable
    [Environment]::SetEnvironmentVariable("JAVA_HOME", $jdkPath, "Machine")
    Write-Host "Success: JAVA_HOME set to $jdkPath" -ForegroundColor Green

    # 3. Retrieve the current System PATH
    $oldPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $jdkBin = "$jdkPath\bin"

    # 4. Safely append the JDK bin directory to the PATH if it doesn't already exist
    if ($oldPath -notmatch [regex]::Escape($jdkBin)) {
        # Ensure the path ends with a semicolon before appending
        if (!$oldPath.EndsWith(";")) { $oldPath += ";" }
        
        $newPath = $oldPath + $jdkBin
        [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
        Write-Host "Success: Added $jdkBin to System PATH." -ForegroundColor Green
    } else {
        Write-Host "Notice: JDK bin is already present in the System PATH." -ForegroundColor Yellow
    }
    
    Write-Host "`nSetup Complete! IMPORTANT: You must close and reopen your terminal for the changes to take effect." -ForegroundColor Cyan
} else {
    Write-Host "Error: Could not find JDK at $jdkPath. Please verify the folder exists and update the script." -ForegroundColor Red
}