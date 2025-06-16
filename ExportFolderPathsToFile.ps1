#ListFoldersAndFilesToTextFile
#The script will list all folders and files in the given folder ($Source). 
#Output format:
#"ItemType|FullFileName|Extension |FileName|ParentFolder|FileCount| FullPath|Size Kb|Size MB|Size GB|LastWriteTime"


#$Source = Folder to query
#$OutFile = Path|name to write
#$OutFileShort = Path|name to write w/ minimum columns

Function GetFiles 
{ 
				
				$Source = "D:\Users\Katal\OneDrive"
				#$Source = ""
				#$Source = ""
				#$Source = ""
				#$Source = ""
				#$Source = ""
				#$Source = ""
				#$Source = ""
				
				#$Source = 'C:\GitHub\_dtpExports\rg-dev-dtp\06-16-2022'
				#$Source = "C:\Users\kahopkin\OneDrive - Microsoft\Documents"	
								
				$Destination = "D:\Users\Katal"
				#$Destination = ""
				#$Destination = ""
				#$Destination = ""

				#$Destination= "C:\Users\kahopkin\OneDrive - Microsoft\Videos\Camera Footage\Garage"	
								
				#$Destination = "C:\Users\kahopkin\OneDrive - Microsoft\Documents"	

				#$OutFile = $Destination + '\ResourcesLong.txt'
				$OutFile = $Destination + '\FileNames.txt'
				$OutFileShort = $Destination + 'ResourcesShort.txt'

				$i = 0  
				$j = 0  
				
				"FullFileName" > $OutFile			

				#get # of folders and files:
				#$FolderCount = (Get-ChildItem -Path $Source -Recurse -Directory|Measure-Object).Count
				#$FileCount = (Get-ChildItem -Path $Source -Recurse -File|Measure-Object).Count


				$FolderCount = (Get-ChildItem -Path $Source  -Directory|Measure-Object).Count
				#$FileCount = (Get-ChildItem -Path $Source  -File|Measure-Object).Count

				#"# of folders= "+ $FolderCount
				#"# of FileCount= "+ $FileCount
				Write-Host -ForegroundColor Green "`$Source=" -NoNewline
				Write-Host -ForegroundColor White "`"$Source`""	

				Write-Host -ForegroundColor Yellow "`$FolderCount= "  -NoNewline
				Write-Host -ForegroundColor White "$FolderCount"

				#Write-Host -ForegroundColor Yellow "`$FileCount= "  -NoNewline
				#Write-Host -ForegroundColor White "$FileCount"

				Write-Host -ForegroundColor Cyan "`$Destination=" -NoNewline
				Write-Host -ForegroundColor White "`"$Destination`""

			# Loop through all directories 
				#$dirs = Get-ChildItem -Path $Source -Recurse | Sort-Object | Where-Object { $_.PSIsContainer -eq $true }  
				$dirs = Get-ChildItem -Path $Source | Sort-Object | Where-Object { $_.PSIsContainer -eq $true }  
				
		Foreach ($dir In $dirs) 
		{ 
								
				$FullPath =  $dir.FullName
				$FileName = $dir.BaseName        
				$ParentFolder = Split-Path (Split-Path $dir.FullName -Parent) -Leaf
				$Extension = $dir.Extension
				#'Extension: ' + $Extension
				$LastWriteTime = $dir.LastWriteTime
				$LastWriteTime = $LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
				$FullFileName = Split-Path $dir.FullName -Leaf -Resolve
				Write-Host -ForegroundColor Yellow "`$FullPath=" -NoNewline
				Write-Host -ForegroundColor Cyan "`"$FullPath`""
				$FullPath >> $OutFile							
				$i++
		} #Foreach ($dir In $dirs)

		#explorer $Destination

} #Function GetFiles   


# RUN SCRIPT 
GetFiles