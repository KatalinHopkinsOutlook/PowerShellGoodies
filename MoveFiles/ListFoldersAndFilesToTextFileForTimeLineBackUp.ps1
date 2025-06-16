
#ListFoldersAndFilesToTextFile
#The script will list all folders and files in the given folder ($DirPath). 
#Output format:
#"ItemType|FullFileName|Extension |FileName|ParentFolder|FileCount| FullPath|Size Kb|Size MB|Size GB|LastWriteTime"
#File 	 Teams.zip 	 zip 	 Teams 	 TeamworkSolutionsDemoAssets 	0	 C:\Users\kahopkin\Documents\ISV Teams Project\Tenants\HR Talent - O365 Enterprise - M365x794031\TeamworkSolutionsDemoAssets\Teams.zip 	 16.86 KB 	 0.02 MB 	 0.00 GB 	05/10/20 11:07

#$DirPath = Folder to query
#$OutFile = Path|name to write
#$OutFileShort = Path|name to write w/ minimum columns



Function GetFiles 
{ 
    $Source = $DirPath = ""
    #$Source = $DirPath = "D:\Users\Katal\OneDrive"
    $DirPath = ""
    $DirPath = ""
    
    $Source = $DirPath = ""
    $Source = $DirPath = ""
    $Source = $DirPath = "C:\Users\katal\source\repos\JustApps\Exports"


    #$DirPath = 'C:\GitHub\_dtpExports\rg-dev-dtp\06-16-2022'
    #$DirPath = "C:\Users\kahopkin\OneDrive - Microsoft\Documents\Personal\Pets\Ghost"	
    #$DirPath = $Source= "C:\Users\kahopkin\OneDrive - Microsoft\Documents\Personal\Pets\Ghost\KatHopkins-Ghost-PGCase50-23VA\To Print"
    #$DirPath = $Source= "C:\Users\kahopkin\OneDrive - Microsoft\Documents\Personal\Pets\Ghost\KatHopkins-Ghost-PGCase50-23VA"
    
    
    #$Destination = ""
    $Destination = "C:\Users\katal\source\repos\JustApps"
    #$Destination = "D:\Users\Katal"
    #$Destination= "C:\Users\kahopkin\OneDrive - Microsoft\Videos\Camera Footage\Garage"	
    #$Destination = "C:\Users\kahopkin\OneDrive - Microsoft\Documents\Personal\Pets\Ghost\KatHopkins-Ghost-PGCase50-23VA"
    
    #$Destination = "C:\Kat\Pets\Ghost\KatHopkins-Ghost-PGCase50-23VA"


    $SourceFolder = Get-Item -Path $Source
    $SourceFolderName = $SourceFolder.Name
    $DestinationFolder = $Destination + "\" + $SourceFolderName
    $today = Get-Date -Format 'yyyy-MM-dd-HH-mm-ss'
    #$ExcelFileName = $Destination + "\" + $today + "_" + $SourceFolder.Name + ".xlsx"
    $ExcelFileName = $Source + "\" + $SourceFolder.Name + "_" + $today + ".xlsx"
    $TodayFolder  = (Get-Date -Format 'yyyy-MM-dd-HH-mm-ss')
    $SourceFolder = Get-Item -Path $Source
    $LogFile = $Destination + "\" + $SourceFolder.Name + "_" + $TodayFolder + ".log"
        
    $OutFile = $Destination + "\" + $SourceFolder.Name + "_" + "Contents.txt"

    $OutFileShort = $Destination + 'ResourcesShort.txt'
    #$OutFileShort = "'" + $OutFileShort + "'"
    #
    #If($debugFlag){	
        Write-Host -ForegroundColor Magenta "`n`$Source=" -NoNewline
        Write-Host -ForegroundColor White "`"$Source`""	
    
        Write-Host -ForegroundColor Magenta "`$SourceFolder=" -NoNewline
        Write-Host -ForegroundColor White "`"$SourceFolder`""
    
        Write-Host -ForegroundColor Green "`n`$Destination=" -NoNewline
        Write-Host -ForegroundColor White "`"$Destination`""
    
        Write-Host -ForegroundColor Green "`$DestinationFolder=" -NoNewline
        Write-Host -ForegroundColor White "`"$DestinationFolder`""

        Write-Host -ForegroundColor Cyan "`$OutFile=" -NoNewline
        Write-Host -ForegroundColor White "`"$OutFile`""
            
   
    $i = 0  
    $j = 0  
    
    "CreatedDate | LastWriteTime | FullFileName | ParentFolder | UnPack | Pack | FileCount | ItemType | FileName | Extension | FullPath | SizeKB | SizeMB | SizeGB" > $OutFile   

    #"RegDate|Date|Type|LastWriteTime|FullFileName|ParentFolder|Notes|FileCount|ItemType|FileName|Extension|FullPath|SizeKB|SizeMB|SizeGB" > $OutFile
    #"RegDate|Date|Type|LastWriteTime|FullFileName|ParentFolder|Notes|FileCount|ItemType|FileName|Extension|FullPath|SizeKB|SizeMB|SizeGB" > $OutFileShort


    #"RegDate|Date|Type|FileName|Extension|FullFileName|ParentFolder|FullPath" > $OutFile
    #"RegDate|Date|Type|ExcelFileName|FullFileName|ParentFolder|FullPath" > $OutFile
    
    #"RegDate|Date|Type|FileName|FullFileName|FileCount|ItemType|FileName|Extension|FullPath|ParentFolder|" > $OutFileShort

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
        $AppTarget = $dir.Directory.Parent.FullName
        #debugline:
        #$FullFileName +" - "+$LastWriteTime

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
            $FileNameWithExtension = $FileName + "." + $Extension
            #$FileCount = 0
            #debugline:
            #"File: "+ $FileName+"."+ $Extension #+ "-"+$LastWriteTime
            <#
            Write-Host -ForegroundColor Yellow "`$FullPath=" -NoNewline
            Write-Host -ForegroundColor Cyan "`"$FullPath`""
            #>

            Write-Host -ForegroundColor Green "#####################################"
            Write-Host -ForegroundColor Yellow "`$FileName=" -NoNewline
            Write-Host -ForegroundColor Cyan "`"$FileName`""
            
            Write-Host -ForegroundColor Yellow "`$Extension=" -NoNewline
            Write-Host -ForegroundColor Cyan "`"$Extension`""

            Write-Host -ForegroundColor Yellow "`$FileNameWithExtension=" -NoNewline
            Write-Host -ForegroundColor Cyan "`"$FileNameWithExtension`""
            #>
            
            #Copy-Item -Path $FullPath -Destination $Destination       
            
        }#else
        
       <#
        Write-Host -ForegroundColor Green "#####################################"
        Write-Host -ForegroundColor Yellow "`$FileName=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$FileName`""
            
        Write-Host -ForegroundColor Yellow "`$Extension=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$Extension`""

        Write-Host -ForegroundColor Yellow "`$FileNameWithExtension=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$FileNameWithExtension`""
        #>

        $charCount = $FileName.Length
        Write-Host -ForegroundColor White "FileName `$=charCount" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$charCount`""
        #$charCount
        
        #$Date=LEFT([@[ FullFi$sourleName ]],10)  
        <#
        $DateCol = $FileName.Substring(0,10)  
        Write-Host -ForegroundColor White "`$DateCol=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$DateCol`""
        $RegDate = $DateCol.split("-")[1] + "/" + $DateCol.split("-")[2] + "/" + $DateCol.split("-")[0]
        Write-Host -ForegroundColor White "`$RegDate=" -NoNewline
        Write-Host -ForegroundColor Green "`"$RegDate`""
#>
        #MID([@[ FullFileName ]],12,LEN([@[ FullFileName ]])-11)
        $charCount = $FileName.Length -11
        #Write-Host -ForegroundColor White "`$charCount=" -NoNewline
        #Write-Host -ForegroundColor Cyan "`"$charCount`""
        #$charCount
<#
        $ExcelFileName = $FileName.Substring(11, $charCount)
        Write-Host -ForegroundColor White "`$ExcelFileName=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$ExcelFileName`""
        #$ExcelFileName
#>
        #$Name=LEFT([@FileName],LEN([@FileName])-4)
        
        <#
        $charCount = $ExcelFileName.Length - 4
        Write-Host -ForegroundColor White "ExcelFileName `$charCount=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$charCount`""   
        #$charCount
        #>   

        
        #$AppTarget = $ParentDir + $FileName
      
        $Type = ""

        $TargetApp = $FileName + "_" + "Packed"

        <#
        $Unpack = "=CONCAT(""pac canvas unpack --msapp "",[@[ FullFileName ]],"" --sources """""", [@[ AppTarget ]], """""""")"        
        $Pack = "=CONCAT(""pac canvas pack --msapp "",[@[ FullFileName ]],"" --sources """""", [@[ AppTarget ]], """""""")"

        $Unpack = "=CONCAT(""pac canvas unpack --msapp "",[@[ FullFileName ]],"" --sources "", [@[ ParentFolder ]])"
        $Pack = "=CONCAT(""pac canvas pack --msapp "",[@[ FullFileName ]],"" --sources "", [@[ ParentFolder ]])"
        #>

        $Unpack = "=CONCAT(""pac canvas unpack --msapp ""," + $TargetApp + ","" --sources "", [@[ ParentFolder ]])"
                 $Pack = "=CONCAT(""pac canvas pack --msapp "",[@[ FullFileName ]],"" --sources "", [@[ ParentFolder ]])          $Pack = "=CONCAT(""pac canvas pack --msapp "",[@[ FullFileName ]],"" --sources "", [@[ ParentFolder ]])"
        Write-Host -ForegroundColor White "`$=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$`""
        Write-Host -ForegroundColor White "`$=" -NoNewline
        Write-Host -ForegroundColor Cyan "`"$`""
        #>
        #Reg Date|Date|Type|
        #"RegDate|Date|Type|FileName||Extension|FullFileName|ParentFolder|FullPath" > $OutFile
        #$RegDate + "|" + $DateCol + "|" + $Type + "|" + $ExcelFileName  + "|" + $FullFileName + "|" + $ParentFolder + "|" + $FullPath>> $OutFile
        #+ "|" + $FileName + "|" + $Extension + "|" + $FullFileName + "|" + $ParentFolder + "|" + $FullPath  + "|" + $ParentFolder  >> $OutFile
        #$ParentFolder + "|" + $ParentFolder + "|" + $ParentFolder + "|" + $DateCol + "|" + $FullFileName + "|" + $ParentFolder + "|" + $LastWriteTime  + "|" + $FullFileName + "|" + $ParentFolder + "|" + $Notes  + "|"  + "$FileName" + "|" + $Extension  + "|" + $SizeKB   + "|" + $SizeMB    + "|" + $SizeGB >> $OutFileShort
     $CreatedDate + " | " +$LastWriteTime  + " | " + $FullFileName + " | " + $AppTarget + " | " + $Unpack  + " | " + $Pack  + " | " + $FileCount + " | " + $ItemType + " | " + "$FileName" + " | " + $Extension + " | " + $FullPath + " | " + $SizeKB   + " | " + $SizeMB    + " | " + $SizeGB >> $OutFile                  
    $i++
  } #Foreach ($dir In $dirs)


    Write-Host -ForegroundColor Magenta "`n`$Source=" -NoNewline
    Write-Host -ForegroundColor White "`"$Source`""	
    
    Write-Host -ForegroundColor Magenta "`$SourceFolder=" -NoNewline
    Write-Host -ForegroundColor White "`"$SourceFolder`""
    
    Write-Host -ForegroundColor Green "`n`$Destination=" -NoNewline
    Write-Host -ForegroundColor White "`"$Destination`""
    
    Write-Host -ForegroundColor Green "`$DestinationFolder=" -NoNewline
    Write-Host -ForegroundColor White "`"$DestinationFolder`""

    Write-Host -ForegroundColor Cyan "`$OutFile=" -NoNewline
    Write-Host -ForegroundColor White "`"$OutFile`""
            

  #explorer $Destination

} # Function renameFiles  
# RUN SCRIPT 
GetFiles  

