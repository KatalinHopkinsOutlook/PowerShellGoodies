<#
To enable long filenames (long paths) in Windows using PowerShell, 
you can modify the registry setting that controls this feature. 
Here's the command:
#>

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1
