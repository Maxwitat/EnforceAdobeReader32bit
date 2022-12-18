# Remove Adobe versions and install 32bit versions
# Covers only German and Englich
# Frank Maxwitat, Dec. 2022

$LittleLogFile = "c:\windows\Logs\CleanAdobe.log"
$Clean32bit = $false
'Adobe Cleanup starting...' | Out-File $LittleLogFile -Append

#32bit deutsch
if($Clean32bit){
$UninstallString = Get-ChildItem -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -like "Adobe Acrobat Reader - Deutsch"} | Select-Object -ExpandProperty UninstallString
if($UninstallString -ne $null){
    Start-Process -FilePath "$env:windir\System32\msiexec.exe" -ArgumentList "/msi /x $($UninstallString.Replace('MsiExec.exe /I','')) /qn /l*v c:\windows\logs\Adobe_Acrobat_DC_uninstall.log" -wait
    'Cleaned 32bit deutsch' | Out-File $LittleLogFile -Append
}
}

#64bit deutsch
$UninstallString = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -like "Adobe Acrobat Reader - Deutsch"} | Select-Object -ExpandProperty UninstallString

if($UninstallString -ne $null){
    Start-Process -FilePath "$env:windir\System32\msiexec.exe" -ArgumentList "/msi /x $($UninstallString.Replace('MsiExec.exe /I','')) /qn /l*v c:\windows\logs\Adobe_Acrobat_DC_uninstall.log" -wait
    'Cleaned 64bit deutsch' | Out-File $LittleLogFile -Append
}


#32bit english
if($Clean32bit){
$UninstallString = Get-ChildItem -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -like "Adobe Acrobat Reader - English"} | Select-Object -ExpandProperty UninstallString

if($UninstallString -ne $null){
    Start-Process -FilePath "$env:windir\System32\msiexec.exe" -ArgumentList "/msi /x $($UninstallString.Replace('MsiExec.exe /I','')) /qn /l*v c:\windows\logs\Adobe_Acrobat_DC_uninstall.log" -wait
    'Cleaned 32bit english' | Out-File $LittleLogFile -Append
}
}

#64bit english
$UninstallString = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | Get-ItemProperty | Where-Object {$_.DisplayName -like "Adobe Acrobat Reader - English"} | Select-Object -ExpandProperty UninstallString

if($UninstallString -ne $null){
    Start-Process -FilePath "$env:windir\System32\msiexec.exe" -ArgumentList "/msi /x $($UninstallString.Replace('MsiExec.exe /I','')) /qn /l*v c:\windows\logs\Adobe_Acrobat_DC_uninstall.log" -wait
    'Cleaned 64bit english' | Out-File $LittleLogFile -Append
}

'Adobe Cleanup completed' | Out-File $LittleLogFile -Append

#Set registry values to prevent 64 bit update

'Setting reg values to prevent update to 64bit - HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Acrobat Reader\DC' | Out-File $LittleLogFile -Append

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown" -Name "bUpdateToSingleApp" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown" -Name "bUpdateToSingleApp" -Value 0

#Run setup

Try{
    Start-Process $PSScriptRoot\setup.exe -ArgumentList '/sAll /ini .\setup.ini /rs' -Wait
    'Setup completed' | Out-File $LittleLogFile -Append
}
Catch{
    'Setup failed' | Out-File $LittleLogFile -Append
    $_ | Out-File $LittleLogFile -Append    
}