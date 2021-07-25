$appname = "Cisco Webex Meetings"
$32bit = get-itemproperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | Select-Object DisplayName, DisplayVersion, UninstallString, PSChildName | Where-Object { $_.DisplayName -match "^*$appname*"}
$64bit = get-itemproperty 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | Select-Object DisplayName, DisplayVersion, UninstallString, PSChildName | Where-Object { $_.DisplayName -match "^*$appname*"}
$32bitvalue = $32bit.UninstallString -replace 'msiexec.exe /i',''
$64bitvalue = $64bit.UninstallString -replace 'msiexec.exe /i',''
 
if ($64bit -eq "" -or $64bit.count -eq 0) {
 
    switch ($32bit.DisplayName.count) {
        0 {Write-Host "Cannot find the uninstall string" -ForegroundColor Red}
        1 {
            if ($32bit -match "msiexec.exe") {
				Start-Process msiexec -ArgumentList "/q /x $32bitvalue" -Wait
            }
            else
            {
                $32bitvalue
            }
            }
        default { Write-Host "Please Narrow Down Your Search" -ForegroundColor Red }
    }
}
else {
  
    switch ($64bit.DisplayName.count) {
        0 {Write-Host "Cannot find the uninstall string" -ForegroundColor Red}
        1 {
            if ($64bit -match "msiexec.exe") {
                Start-Process msiexec -ArgumentList "/q /x $64bitvalue" -Wait
            }
            else
            {
                $64bitvalue
            }
            }
        default { Write-Host "Please Narrow Down Your Search" -ForegroundColor Red }
    }
}