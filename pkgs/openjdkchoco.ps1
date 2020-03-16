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
