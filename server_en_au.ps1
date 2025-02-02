# Script to define regional settings on Azure Virtual Machines deployed from the market place
# ORIGINAL Author: Alexandre Verkinderen
# Blogpost: https://mscloud.be/configure-regional-settings-and-windows-locales-on-azure-virtual-machines/
# 
######################################33

#variables
$regionalsettingsURL = "https://github.com/MBS-Pete/Server/blob/d406f7012db5106902b64c53bda70d7092512965/AURegion.xml"
$RegionalSettings = "D:\AURegion.xml"

#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
Set-WinSystemLocale en-AU
Set-WinUserLanguageList -LanguageList en-AU -Force
Set-Culture -CultureInfo en-AU
Set-WinHomeLocation -GeoId 12
Set-TimeZone -Name "E. Australia Standard Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 40
Restart-Computer
