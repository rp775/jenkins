$ErrorActionPreference = 'Stop';

$packageName= 'microsoft-teams.install'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url32      = 'https://statics.teams.microsoft.com/production-windows/1.3.00.3564/Teams_windows.msi'
$url64      = 'https://statics.teams.microsoft.com/production-windows-x64/1.3.00.3564/Teams_windows_x64.msi'
$checksum32 = 'fb3d3e508582b406b93aaa3fb1d58debc5fccc1b1cbb9873c7351e057dd24db6'
$checksum64 = '360e5a2aa66633b496d01b50fa44870967bdd368b37a7aa29d52cfa5e350c4db'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url32
  url64bit      = $url64

  softwareName  = 'Teams Machine-Wide Installer'

  checksum      = $checksum32
  checksumType  = 'sha256'
  checksum64    = $checksum64
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs



chocolateybeforemodify.ps1


# To avoid "WARNING: This MSI requires uninstall prior to installing a different version.",
# we uninstall here

$ErrorActionPreference = 'Stop'; # stop on all errors
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Teams Machine-Wide Installer'
  fileType      = 'MSI' #only one of these: MSI or EXE (ignore MSU for now)
  # MSI
  silentArgs    = "/qn /norestart"
  validExitCodes= @(0, 3010, 1605, 1614, 1641) # https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | ForEach-Object { 
    $packageArgs['file'] = "$($_.UninstallString)"
    
    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    }

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | ForEach-Object {Write-Warning "- $($_.DisplayName)"}
}





$script                     = $MyInvocation.MyCommand.Definition
$packageName                = 'SkypeforBusinessRetail'
$configFile                 = Join-Path $(Split-Path -parent $script) 'configuration.xml'
$configFile64               = Join-Path $(Split-Path -parent $script) 'configuration64.xml'
$bitCheck                   = Get-ProcessorBits
$configurationFile          = if ($BitCheck -eq 64) { $configFile64 } else { $configFile }
$officetempfolder           = Join-Path $env:Temp 'chocolatey\SkypeforBusinessRetail'
$packageArgs                = @{
    packageName             = 'Office365DeploymentTool'
    fileType                = 'exe'
    url                     = 'https://download.microsoft.com/download/2/7/A/27AF1BE6-DD20-4CB4-B154-EBAB8A7D4A7E/officedeploymenttool_12130-20272.exe'
    checksum                = 'E94CA0062ED610CDED2399E22AD2CAB6377989CB0744CEED1CF3500C9810C45D'
    checksumType            = 'sha256'
    softwareName            = 'SkypeforBusinessEntryRetail*'
    silentArgs              = "/extract:`"$officetempfolder`" /log:`"$officetempfolder\SkypeforBusinessRetail.log`" /quiet /norestart"
    validExitCodes          = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

# Download and install the deployment tool
Install-ChocolateyPackage @packageArgs

# Use the deployment tool to download the setup files
$packageArgs['packageName'] = 'SkypeforBusinessRetail'
$packageArgs['file'] = "$officetempfolder\Setup.exe"
$packageArgs['silentArgs'] = "/download $configurationFile `"$officetempfolder\setup.exe`""
Install-ChocolateyInstallPackage @packageArgs

# Run the actual Office setup
$packageArgs['file'] = "$officetempfolder\Setup.exe"
$packageArgs['packageName'] = $packageName
$packageArgs['silentArgs'] = "/configure $configurationFile"
Install-ChocolateyInstallPackage @packageArgs

if (Test-Path "$officetempfolder") {
    Remove-Item -Recurse "$officetempfolder"
}




