<#
#ExportFolderPathsToFile
#The script will list all folders and files in the given folder ($Source). 
#Output format:
#"ItemType|FullFileName|Extension |FileName|ParentFolder|FileCount| FullPath|Size Kb|Size MB|Size GB|LastWriteTime"
#$Source = Folder to query
#$LogFile = Path|name to write
#$LogFileShort = Path|name to write w/ minimum columns

#>
Function ExportFolderPathsToFile 
{ 	
	$ScriptLocation = Get-Location
	$ScriptPath = $ScriptLocation.Path
	$ScriptName = ""
	$ScriptName = "ExportFolderPathsToFile.ps1"
	#$Source = "D:\Users\Katal\OneDrive\Documents"
	#$Source = "D:\Users\Katal"
	#$Source = "D:\Users\Katal\OneDrive\MS-Surface-E6F1US5"
	#$Source = "C:\Users\Katal\OneDrive"
	
	$Source = "\\DS224\MS-Surface-E6F1US5"
	#$Source="\\DS224\MS-Surface-E6F1US5\Documents"
	#$Source = "\\DS224\kahopkin\OneDrive - Microsoft"
	#$Source = "\\DS224\MS-Surface-E6F1US5\kahopkin"
	
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\AppData"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\Application Data"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\Local Settings"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\OneDrive-Live\OneDrive"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\OneDrive-Outlook\OneDrive"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\OneDrive-Outlook\OneDrive\Documents"				
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\PowerShellProTools"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\Recent"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\Saved Games"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\Searches"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\SendTo"
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\source"

	$Source = "\\DS224\Documents"
	#$Source = "\\DS224\Chief Architect"
	
	#$Source="\\DS224\MS-Surface-E6F1US5\kahopkin\OneDrive-Outlook\OneDrive\MS-Surface-E6F1US5"
	#$Source="\\DS224\MS-Surface-E6F1US5\Personal"
	
	#$Destination = "D:\Users\Katal"
	#$Destination = ""
	#$Destination = ""
	

	#$Destination = "D:\Users\Katal"
	#$Destination = ""
	#$Destination = ""

	$SourceFolder = Get-Item -Path $Source
	$SourceFolderName = $SourceFolder.Name

	#$LogFile = $Destination + '\ResourcesLong.txt'
	#$LogFile = $Destination + '\FileNames.txt'
	#$LogFile = $Destination +  '\' + $SourceFolderName + '_FolderNames.ps1'
	$LogFile = $Source +  '\' + $SourceFolderName + '_FolderNames.ps1'
	#$LogFileShort = $Destination + '\' + $SourceFolderName + 'ResourcesShort.txt'

	$i = 0  
	#$j = 0  
	
	$StartTime = Get-Date -Format 'yyyy/MM/dd HH:mm:ss'

	Write-Host -ForegroundColor Magenta "`n`$StartTime= "  -NoNewline
	Write-Host -ForegroundColor White "$StartTime"

	"<#" > $LogFile
	"`$ScriptPath=" + $ScriptPath >> $LogFile
	"`$ScriptName= " + $ScriptName >> $LogFile
	"Today's Date: " + $StartTime >> $LogFile
	"Folders in : "  +  $Source + """" >> $LogFile

	"`n`$Source=" +	 "`"$Source`""	>> $LogFile
	#"`$Destination=" + "`"$Destination`"" >> $LogFile
	"`$LogFile=" + "`"$LogFile`"" >> $LogFile	
	

	
	Write-Host -ForegroundColor Yellow "`n`$ScriptPath=" -NoNewline
	Write-Host -ForegroundColor White "`"$ScriptPath`""	
	
	Write-Host -ForegroundColor Yellow "`n`$ScriptName=" -NoNewline
	Write-Host -ForegroundColor White "`"$ScriptName`""	

	Write-Host -ForegroundColor Yellow "`n`$Source=" -NoNewline
	Write-Host -ForegroundColor White "`"$Source`""	

	#Write-Host -ForegroundColor Cyan "`$Destination=" -NoNewline
	#Write-Host -ForegroundColor White "`"$Destination`""
	
	Write-Host -ForegroundColor Cyan "`$LogFile=" -NoNewline
	Write-Host -ForegroundColor White "`"$LogFile`"`n"


	
    # Loop through all directories 
    #$dirs = Get-ChildItem -Path $Source -Recurse | Sort-Object | Where-Object { $_.PSIsContainer -eq $true }  
    <#
    $dirs = Get-ChildItem -Path $Source -Recurse | Sort-Object | Where-Object { $_.PSIsContainer -eq $true }  				
	$psCommand =  "`n `$dirs=Get-ChildItem -Path `$Source -Recurse | Sort-Object | Where-Object { `$_.PSIsContainer -eq $true } "     
	#>

    $dirs = Get-ChildItem -Path $Source | Sort-Object | Where-Object { $_.PSIsContainer -eq $true }  				
	$psCommand =  "`n`$dirs=Get-ChildItem -Path `$Source | Sort-Object | Where-Object { `$_.PSIsContainer -eq $true }"

    Write-Host -ForegroundColor Green $psCommand
	$psCommand >> $LogFile

	$psCommand =  "`$dirs=Get-ChildItem -Path " + $Source + " | Sort-Object | Where-Object { `$_.PSIsContainer -eq $true }"
	Write-Host -ForegroundColor Cyan $psCommand
	$psCommand >> $LogFile
	
	
	<#
	#get # of folders and files:
	$FolderCount = (Get-ChildItem -Path $Source -Recurse -Directory|Measure-Object).Count
	$FileCount = (Get-ChildItem -Path $Source -Recurse -File|Measure-Object).Count
#>
	$EndTime = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
	$Duration = New-TimeSpan -Start $StartTime -End $EndTime

<#
	Write-Host -ForegroundColor Yellow "`$FolderCount= "  -NoNewline
	Write-Host -ForegroundColor White "$FolderCount"


	Write-Host -ForegroundColor Yellow "`$FileCount= "  -NoNewline
	Write-Host -ForegroundColor White "$FileCount"
#>
	Write-Host -ForegroundColor Cyan "`$EndTime= "  -NoNewline
	Write-Host -ForegroundColor White "$EndTime"

	Write-Host -ForegroundColor Green "`$Duration= "  -NoNewline
	Write-Host -ForegroundColor White "$Duration`n"


	"#`$FolderCount=" + "`"$FolderCount`"" >> $LogFile
	"#`$FileCount=" + "`"$FileCount`"" >> $LogFile
	
	"#`$StartTime=" + "`"$StartTime`"" >> $LogFile
	"#`$EndTime=" + "`"$EndTime`"" >> $LogFile
	"#`$Duration=" + "`"$Duration`"" >> $LogFile
	
	"`n#>`n" >> $LogFile
	

	Foreach ($dir In $dirs) 
	{ 
							
			$FullPath =  $dir.FullName
			$FileName = $dir.BaseName        
			$ParentFolder = Split-Path (Split-Path $dir.FullName -Parent) -Leaf
			$Extension = $dir.Extension
			#'Extension: ' + $Extension
			$LastWriteTime = $dir.LastWriteTime
			$LastWriteTime = $LastWriteTime.ToString("yyyy/MM/dd HH:mm")
			$FullFileName = Split-Path $dir.FullName -Leaf -Resolve
			Write-Host -ForegroundColor Yellow "#`$Source=" -NoNewline
			Write-Host -ForegroundColor Cyan "`"$FullPath`""
			$psSource = "#`$Source=""" + $FullPath + """"

			#$FullPath >> $LogFile
			$psSource >> $LogFile

			$i++
	} #Foreach ($dir In $dirs)

	
	#explorer $Destination
	explorer $LogFile

  	$EndTime = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
	$Duration = New-TimeSpan -Start $StartTime -End $EndTime


	Write-Host -ForegroundColor Green "`n`$Source=" -NoNewline
	Write-Host -ForegroundColor White "`"$Source`""	

	#Write-Host -ForegroundColor Cyan "`$Destination=" -NoNewline
	#Write-Host -ForegroundColor White "`"$Destination`""
	
	Write-Host -ForegroundColor Cyan "`$LogFile=" -NoNewline
	Write-Host -ForegroundColor White "`"$LogFile`"`n"



	Write-Host -ForegroundColor Magenta "`$StartTime= "  -NoNewline
	Write-Host -ForegroundColor White "$StartTime"

	Write-Host -ForegroundColor Cyan "`$EndTime= "  -NoNewline
	Write-Host -ForegroundColor White "$EndTime"

	Write-Host -ForegroundColor Green "`$Duration= "  -NoNewline
	Write-Host -ForegroundColor White "$Duration"

	"`n`$Source=" +	 "`"$Source`""	>> $LogFile
	#"`n`$Destination=" + "`"$Destination`"" >> $LogFile
	"`n`$LogFile=" + "`"$LogFile`"" >> $LogFile	

	"<#`n#`$EndTime=" + "`"$EndTime`"" >> $LogFile
	"`n#`$Duration=" + "`"$Duration`"" >> $LogFile
	
	"`n#>`n" >> $LogFile
} #Function ExportFolderPathsToFile   


# RUN SCRIPT 
ExportFolderPathsToFile