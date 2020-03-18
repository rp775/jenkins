tools\chocolateyBeforeModify.ps1

https://github.com/chocolatey-community/chocolatey-coreteampackages


$programFiles = (${env:ProgramFiles}, ${env:ProgramFiles(x86)} -ne $null)[0]
$installDir = "$programFiles\OpenJDK"

$pathToUnInstall = "$installDir\openjdk-11.0.6_10\bin"

$statementTerminator = ";"

$actualPath = [System.Collections.ArrayList](Get-EnvironmentVariable -Name 'Path' -Scope 'Machine' -PreserveVariables).split($statementTerminator)

if ($actualPath -contains $pathToUnInstall)
{
	Write-Host "PATH environment variable contains $pathToUnInstall. Removing..."
	
	$actualPath.Remove($pathToUnInstall)	
	$newPath =  $actualPath -Join $statementTerminator

	$cmd = "Set-EnvironmentVariable -Name 'Path' -Value `'$newPath`' -Scope 'Machine'"

    if (Test-ProcessAdminRights) {
        Invoke-Expression $cmd
    } else {
        Start-ChocolateyProcessAsAdmin "$cmd"
    }
}



 tools\chocolateyinstall.ps1


$programFiles = (${env:ProgramFiles}, ${env:ProgramFiles(x86)} -ne $null)[0]
$installDir = "$programFiles\OpenJDK"

$packageArgs = @{
    PackageName      = $env:ChocolateyPackageName
    UnzipLocation    = $targetDir = $installDir
    Url64            = 'https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.6%2B10/OpenJDK11U-jdk_x64_windows_11.0.6_10.zip'
    Checksum64       = '260435A628E3B63502D1DACB3220AF7CEC7EF032F72ABE1FF52B89D9CD470739'
    ChecksumType64   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyEnvironmentVariable 'JAVA_HOME' $targetDir\openjdk-11.0.6_10 'Machine'
# The full path instead of the %JAVA_HOME% is needed so it can be removed with the Chocolatey Uninstall
Install-ChocolateyPath $targetDir\openjdk-11.0.6_10\bin -PathType 'Machine'




$programFiles = (${env:ProgramFiles}, ${env:ProgramFiles(x86)} -ne $null)[0]
$installDir = "$programFiles\OpenJDK"

Uninstall-ChocolateyEnvironmentVariable 'JAVA_HOME' 'Machine'
rm -r "$installDir\openjdk-11.0.6_10"





Spring Tool Suite 3.9.6
install
$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$ant_home = Join-Path $package 'apache-ant-1.10.5'
$ant_bat = Join-Path $ant_home 'bin/ant.bat'

Install-ChocolateyZipPackage `
    -PackageName 'ant' `
    -Url 'https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.5-bin.zip' `
    -Checksum '2E48F9E429D67708F5690BC307232F08440D01EBE414059292B6543971DA9C7CD259C21533B9163B4DD753321C17BD917ADF8407D03245A0945FC30A4E633163' `
    -ChecksumType 'SHA512' `
    -UnzipLocation $package

Install-ChocolateyEnvironmentVariable `
    -VariableName 'ANT_HOME' `
    -VariableValue $ant_home `
    -VariableType 'Machine'

Install-BinFile -Name 'ant' -Path $ant_bat

Update-SessionEnvironment

uninstall

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = $(Join-Path $DesktopPath "STS.lnk")

if ($(Test-Path $ShortcutPath) -eq $true) {
    Remove-Item -Path $ShortcutPath
}


ANT

$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$ant_home = Join-Path $package 'apache-ant-1.10.5'
$ant_bat = Join-Path $ant_home 'bin/ant.bat'

Install-ChocolateyZipPackage `
    -PackageName 'ant' `
    -Url 'https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.5-bin.zip' `
    -Checksum '2E48F9E429D67708F5690BC307232F08440D01EBE414059292B6543971DA9C7CD259C21533B9163B4DD753321C17BD917ADF8407D03245A0945FC30A4E633163' `
    -ChecksumType 'SHA512' `
    -UnzipLocation $package

Install-ChocolateyEnvironmentVariable `
    -VariableName 'ANT_HOME' `
    -VariableValue $ant_home `
    -VariableType 'Machine'

Install-BinFile -Name 'ant' -Path $ant_bat

Update-SessionEnvironment

UNINSTALL

$tools = Split-Path $MyInvocation.MyCommand.Definition
$package = Split-Path $tools
$ant_home = Join-Path $package 'apache-ant-1.10.5'
$ant_bat = Join-Path $ant_home 'bin/ant.bat'

Uninstall-BinFile -Name 'ant' -Path $ant_bat





$packageArgs = @{
  PackageName = 'AdoptOpenJDK8jre'
  Url = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jre_x86-32_windows_hotspot_8u242b08.msi'
  Url64bit = 'https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jre_x64_windows_hotspot_8u242b08.msi'
  Checksum = 'B6EA823E2CFE8EEA0FE7B9AED2D6594342B31164FBF71627122483C4608253EC'
  ChecksumType = 'sha256'
  Checksum64 = 'B1C486CA9FB9632BBA9DD70778C7B371D5EE84CFBFAF6BD59A3E5CFD310A4F74'
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = "INSTALLLEVEL=3 /quiet"
}

Install-ChocolateyPackage @packageArgs



$packageArgs = @{
  PackageName = 'AdoptOpenJDK11jre'
  Url = 'https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.6%2B10/OpenJDK11U-jre_x86-32_windows_hotspot_11.0.6_10.msi'
  Url64bit = 'https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.6%2B10/OpenJDK11U-jre_x64_windows_hotspot_11.0.6_10.msi'
  Checksum = '3D5B4E1AEB153CD09FCD16E4318B299FA5240C9A631C928D5C29829263680AFD'
  ChecksumType = 'sha256'
  Checksum64 = 'D550FBC8348D84DDB15B2DEAF322DC3433B933444EAF086FF1A8185E36FFA863'
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = "INSTALLLEVEL=3 /quiet"
}

Install-ChocolateyPackage @packageArgs



$packageArgs = @{
  PackageName = 'AdoptOpenJDKopenj9jre'
  Url = ''
  Url64bit = 'https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8_openj9-0.18.0/OpenJDK13U-jre_x64_windows_openj9_windowsXL_13.0.2_8_openj9-0.18.0.msi'
  Checksum = ''
  ChecksumType = ''
  Checksum64 = '0A5A4386E7F1F9A008408BC6CB899B959ED4DA1912B41BADC3DE3D3FFAD18C62'
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = "INSTALLLEVEL=3 /quiet"
}

Install-ChocolateyPackage @packageArgs




$packageArgs = @{
  PackageName = 'AdoptOpenJDKjre'
  Url = 'https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jre_x86-32_windows_hotspot_13.0.2_8.msi'
  Url64bit = 'https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jre_x64_windows_hotspot_13.0.2_8.msi'
  Checksum = 'A210D4BC779FC0E9A03A7532CC711211351F7D1F5C3CB1B1BCAEBC35406A800B'
  ChecksumType = 'sha256'
  Checksum64 = '6FE327787FC81F84CA16296A9EDBACE713D5B04657234CB9431AB45BDA7DF2DC'
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = "INSTALLLEVEL=3 /quiet"
}

Install-ChocolateyPackage @packageArgs




$packageArgs = @{
  PackageName = 'AdoptOpenJDK11jre'
  Url = 'https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.6%2B10/OpenJDK11U-jre_x86-32_windows_hotspot_11.0.6_10.msi'
  Url64bit = 'https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.6%2B10/OpenJDK11U-jre_x64_windows_hotspot_11.0.6_10.msi'
  Checksum = '3D5B4E1AEB153CD09FCD16E4318B299FA5240C9A631C928D5C29829263680AFD'
  ChecksumType = 'sha256'
  Checksum64 = 'D550FBC8348D84DDB15B2DEAF322DC3433B933444EAF086FF1A8185E36FFA863'
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = "INSTALLLEVEL=3 /quiet"
}

Install-ChocolateyPackage @packageArgs



Uninstall-ChocolateyEnvironmentVariable 'JAVA_HOME' 'Machine'
rm -r 'C:\Program Files\AdoptOpenJDK\jdk-12.0.2+10-jre'

$pathToUnInstall = 'C:\Program Files\AdoptOpenJDK\jdk-12.0.2+10-jre\bin'
$pathType = 'Machine'

if ($env:PATH.ToLower().Contains($pathToUnInstall.ToLower()))
{
	$statementTerminator = ";"
	Write-Host "PATH environment variable contains $pathToUnInstall. Removing..."
	$actualPath = [System.Collections.ArrayList](Get-EnvironmentVariable -Name 'Path' -Scope $pathType).split($statementTerminator)

	$actualPath.Remove($pathToUnInstall)	
	$newPath =  $actualPath -Join $statementTerminator

	if ($pathType -eq [System.EnvironmentVariableTarget]::Machine) {
		if (Test-ProcessAdminRights) {
			Set-EnvironmentVariable -Name 'Path' -Value $newPath -Scope $pathType
		} else {
			$psArgs = "UnInstall-ChocolateyPath -pathToUnInstall `'$originalPathToUnInstall`' -pathType `'$pathType`'"
			Start-ChocolateyProcessAsAdmin "$psArgs"
		}
	} else {
		Set-EnvironmentVariable -Name 'Path' -Value $newPath -Scope $pathType
	}
}

$AdoptOpenJDKDirectory = 'C:\Program Files\AdoptOpenJDK'
If ((Get-ChildItem -Force $AdoptOpenJDKDirectory) -eq $Null) {
    rmdir $AdoptOpenJDKDirectory 
}





$packageName = $env:ChocolateyPackageName
$targetDir   = 'C:\Program Files\AdoptOpenJDK'
$url64       = 'https://github.com/AdoptOpenJDK/openjdk12-binaries/releases/download/jdk-12.0.2%2B10/OpenJDK12U-jre_x64_windows_hotspot_12.0.2_10.zip'
$checksum64  = 'c03fdbced77d74557d2ede7a120b09e2573dde7527a4c019458b6f20920aa632'

Install-ChocolateyZipPackage $packageName $url64 $targetDir
Install-ChocolateyEnvironmentVariable 'JAVA_HOME' $targetDir\jdk-12.0.2+10-jre 'Machine'
# The full path instead of the %JAVA_HOME% is needed so it can be removed with the Chocolatey Uninstall
Install-ChocolateyPath 'C:\Program Files\AdoptOpenJDK\jdk-12.0.2+10-jre\bin' -PathType 'Machine'






INSTALL

$ErrorActionPreference = 'Stop';

$packageName = 'SpringToolSuite'
$packageVersion = '3.9.6'
$archiveFolderToUnzip = "sts-bundle\sts-$packageVersion.RELEASE"
$unzipLocation = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"

$url        = "https://download.springsource.com/release/STS/3.9.6.RELEASE/dist/e4.9/spring-tool-suite-3.9.6.RELEASE-e4.9.0-win32.zip"
$checksum32 = "1f136696cf2982cdd089e89bf997d1b2472e7297"
$url64      = "https://download.springsource.com/release/STS/3.9.6.RELEASE/dist/e4.9/spring-tool-suite-3.9.6.RELEASE-e4.9.0-win32-x86_64.zip"
$checksum64 = "59de36dcbd94c56ce544c7551c324b4be295e8a3"

$DesktopPath = [Environment]::GetFolderPath("Desktop")

Install-ChocolateyZipPackage -PackageName $packageName `
    -UnzipLocation $unzipLocation `
    -Url $url `
    -Url64bit $url64 `
    -Checksum $checksum32 `
    -Checksum64 $checksum64 `
    -SpecificFolder "$archiveFolderToUnzip\*" `
    -checksumType64 "sha1"

Install-ChocolateyShortcut `
    -ShortcutFilePath $(Join-Path $DesktopPath "STS.lnk") `
    -TargetPath $(Join-Path $(Join-Path $unzipLocation $archiveFolderToUnzip) "STS.exe")
    
    UINSTALL
    
    $DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = $(Join-Path $DesktopPath "STS.lnk")

if ($(Test-Path $ShortcutPath) -eq $true) {
    Remove-Item -Path $ShortcutPath
}
