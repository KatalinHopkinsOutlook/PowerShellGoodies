#ListFoldersAndFilesToTextFile
#The script will list all folders and files in the given folder ($DirPath). 
#Output format:
#"ItemType|FullFileName|Extension |FileName|ParentFolder|FileCount| FullPath|Size Kb|Size MB|Size GB|LastWriteTime"
#File 	 Teams.zip 	 zip 	 Teams 	 TeamworkSolutionsDemoAssets 	0	 C:\Users\kahopkin\Documents\ISV Teams Project\Tenants\HR Talent - O365 Enterprise - M365x794031\TeamworkSolutionsDemoAssets\Teams.zip 	 16.86 KB 	 0.02 MB 	 0.00 GB 	05/10/20 11:07

#$DirPath = Folder to query
#$LogFile = Path|name to write
#$LogFileShort = Path|name to write w/ minimum columns



Function GetFiles 
{ 
    Param(
		[Parameter(Mandatory = $true)] [String]$Source
		,[Parameter(Mandatory = $true)] [String]$Destination
		,[Parameter(Mandatory = $true)] [String]$LogFile
		
	)    

    $SourceFolder = Get-Item -Path $Source
    $SourceFolderName = $SourceFolder.Name
    $DestinationFolder = $Destination + "\" + $SourceFolderName
    $today = Get-Date -Format 'yyyy-MM-dd-HH-mm-ss'
    #$ExcelFileName = $Destination + "\" + $today + "_" + $SourceFolder.Name + ".xlsx"
    $ExcelFileName = $Source + "\" + $SourceFolder.Name + "_" + $today + ".xlsx"
    $TodayFolder  = (Get-Date -Format 'yyyy-MM-dd-HH-mm-ss')
    
    $LogFileShort = $Destination + 'ResourcesShort.txt'
    #$LogFileShort = "'" + $LogFileShort + "'"
    #
    <#If($debugFlag){	
        Write-Host -ForegroundColor Magenta "`n`$Source=" -NoNewline
        Write-Host -ForegroundColor White "`"$Source`""	
    
        Write-Host -ForegroundColor Magenta "`$SourceFolder=" -NoNewline
        Write-Host -ForegroundColor White "`"$SourceFolder`""
    
        Write-Host -ForegroundColor Green "`n`$Destination=" -NoNewline
        Write-Host -ForegroundColor White "`"$Destination`""
    
        Write-Host -ForegroundColor Green "`$DestinationFolder=" -NoNewline
        Write-Host -ForegroundColor White "`"$DestinationFolder`""

        Write-Host -ForegroundColor Cyan "`$LogFile=" -NoNewline
        Write-Host -ForegroundColor White "`"$LogFile`""
            #>
   
    #"RegDate|Date|Type|LastWriteTime|FullFileName|ParentFolder|Notes|FileCount|ItemType|FileName|Extension|FullPath|SizeKB|SizeMB|SizeGB" > $LogFile
    #"RegDate|Date|Type|LastWriteTime|FullFileName|ParentFolder|Notes|FileCount|ItemType|FileName|Extension|FullPath|SizeKB|SizeMB|SizeGB" > $LogFileShort


    #"RegDate|Date|Type|FileName|Extension|FullFileName|ParentFolder|FullPath" > $LogFile
    #"RegDate|Date|Type|ExcelFileName|FullFileName|ParentFolder|FullPath" > $LogFile
    
    #"RegDate|Date|Type|FileName|FullFileName|FileCount|ItemType|FileName|Extension|FullPath|ParentFolder|" > $LogFileShort

    # Loop through all directories 
    $dirs = Get-ChildItem -Path $Source -Recurse|Sort-Object #| Where-Object { $_.PSIsContainer -eq $true } #|Sort-Object 

    #get # of folders and files:
    $FolderCount = (Get-ChildItem -Path $Source -Recurse -Directory|Measure-Object).Count
    $FileCount = (Get-ChildItem -Path $Source -Recurse -File|Measure-Object).Count
    "# of folders= "+ $FolderCount
    "# of FileCount= "+ $FileCount
   
      Foreach ($dir In $dirs) 
      { 
        
        $FullPath =  $dir.FullName
        $FileName = $dir.BaseName        
        $ParentFolder = Split-Path (Split-Path $dir.FullName -Parent) -Leaf
        $Extension = $dir.Extension
        #'Extension: ' + $Extension
        $CreatedDate = $dir.CreationTime.ToString("MM/dd/yyyy HH:mm:ss")
        $LastWriteTime = $dir.LastWriteTime
        $LastWriteTime = $LastWriteTime.ToString("MM/dd/yyyy HH:mm:ss")
        $FullFileName = Split-Path $dir.FullName -Leaf -Resolve
        $ParentDir = $dir.Directory.FullName + "\"
        $ParentFolder = $AppTarget = $dir.Directory.Parent.FullName + "\" + $FileName
        #$AppTarget = $ParentDir + $FileName
        #debugline:
        #$FullFileName +" - "+$LastWriteTime

        $TargetApp = $FileName + "_" + "Packed.msapp"


        $isDir = (Get-Item $FullPath) -is [System.IO.DirectoryInfo]
        $subFolder = Get-ChildItem -Path $dir.FullName -Recurse -Force|Where-Object { $_.PSIsContainer -eq $false } |Measure-Object -property Length -sum|Select-Object Sum    
        # Set default value for addition to file name 
        $Size = $subFolder.sum 
        $SizeKB =  "{0:N2}"-f ($Size / 1KB) + " KB"
        $SizeMB =  "{0:N2}"-f ($Size / 1MB) + " MB"
        $SizeGB =  "{0:N2}"-f ($Size / 1GB) + " GB"
        
        if($isDir)  
        {
            $Extension="Folder"
            $ItemType = "Folder"
            $FileCount = (Get-ChildItem -Path $DirPath -Recurse -File|Measure-Object).Count
            #debugline:
            # "Folder["+$i+"]"+$FileName + " count: " + $FileCount         
            $Source = $FullPath
            Write-Host -ForegroundColor Magenta "`n`$Source=" -NoNewline
            Write-Host -ForegroundColor White "`"$Source`""	
            $FolderCount = (Get-ChildItem -Path $Source -Recurse -Directory|Measure-Object).Count
            $FileCount = (Get-ChildItem -Path $Source -Recurse -File|Measure-Object).Count
            "# of folders= "+ $FolderCount
            "# of FileCount= "+ $FileCount
            
            GetFiles -Source $Source -Destination $Destination -LogFile $LogFile
        }
        else
        {
            $startIndex = ($dir.Extension.length)-3            
            
            if($Extension.length -eq 3)
            {
               # '[69]Extension: ' + $dir.Extension + ' Ext Length: ' + $dir.Extension.length + ', startIndex: ' + $startIndex
                $startIndex = ($dir.Extension.length)-3
                #'Extension: ' + $Extension + ' Ext Length: ' + $dir.Extension.length + ', startIndex: ' + $startIndex
                $Extension = $dir.Extension.substring($startIndex,3)
               # $Extension
            }
            if($Extension.length -eq 4)
            {
               # '[69]Extension: ' + $dir.Extension + ' Ext Length: ' + $dir.Extension.length + ', startIndex: ' + $startIndex
                $startIndex = ($dir.Extension.length)-4
                #'Extension: ' + $Extension + ' Ext Length: ' + $dir.Extension.length + ', startIndex: ' + $startIndex
                $Extension = $dir.Extension.substring($startIndex,4)
               # $Extension
            }            
            
            $ItemType = "File"
            $charCount = $FileName.Length
           
            $charCount = $FileName.Length -11
          
            
            $Unpack = " =CONCAT(""pac canvas unpack --msapp "",TRIM([@[FullFileName]]),"" --sources "", TRIM([@[ParentFolder]]))"
            $Pack = " =CONCAT(""pac canvas pack --msapp "", CONCAT(TRIM([@[FileName]]), ""_Packed"", "".msapp"") ,"" --sources "", TRIM([@[ParentFolder]]))"

                
            If($Extension -eq ".msapp" -or $ItemType -eq "Folder")
            {
                $CreatedDate + "|" +
                $LastWriteTime  + "|" +
                $FullFileName + "|" +
                $FileName + "|" +
                $Extension + "|" +
                $ParentFolder + "|" +
                $Unpack  + "|" +
                $Pack  + "|" +
                $FullPath + "|" +
                $FileCount + "|" +
                $ItemType + "|" +
                $SizeKB   + "|" +
                $SizeMB    + "|" +
                $SizeGB >> $LogFile                  
            } #If($Extension -eq ".msapp" -or $ItemType -eq "Folder")          
        }#else if type is file
    $i++
  } #Foreach ($dir In $dirs)


    Write-Host -ForegroundColor Magenta "`n[$i}:`n`$Source=" -NoNewline
    Write-Host -ForegroundColor White "`"$Source`""	
    
    Write-Host -ForegroundColor Magenta "`$SourceFolder=" -NoNewline
    Write-Host -ForegroundColor White "`"$SourceFolder`""
    
    Write-Host -ForegroundColor Green "`n`$Destination=" -NoNewline
    Write-Host -ForegroundColor White "`"$Destination`""
    
    Write-Host -ForegroundColor Green "`$DestinationFolder=" -NoNewline
    Write-Host -ForegroundColor White "`"$DestinationFolder`""

    Write-Host -ForegroundColor Cyan "`$LogFile=" -NoNewline
    Write-Host -ForegroundColor White "`"$LogFile`""
            

  #explorer $Destination

} # Function renameFiles  
# RUN SCRIPT 

 $i = 0  
$j = 0  

$Source = $DirPath = ""
#$Source = $DirPath = "D:\Users\Katal\OneDrive"
$DirPath = ""
$DirPath = ""
    
$Source = $DirPath = ""
$Source = $DirPath = ""
$Source = $DirPath = "C:\Users\katal\source\repos\JustApps\2025-06-12"

    
#$Destination = ""
$Destination = "C:\Users\katal\source\repos\JustApps\2025-06-12"
#$Destination = "D:\Users\Katal"
$SourceFolder = Get-Item -Path $Source
$LogFile = $Destination + "\" + $SourceFolder.Name + "_" + $TodayFolder + ".log"
        
$LogFile = $Destination + "\" + $SourceFolder.Name + "_" + "Contents.txt"
"CreatedDate|LastWriteTime|FullFileName|FileName|Extension|ParentFolder|UnPack|Pack|FullPath|FileCount|ItemType|SizeKB|SizeMB|SizeGB" > $LogFile   

GetFiles -Source $Source -Destination $Destination -LogFile $LogFile

