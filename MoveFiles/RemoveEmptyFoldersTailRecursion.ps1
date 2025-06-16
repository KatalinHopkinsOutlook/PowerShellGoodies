
# A script block (anonymous function) that will remove empty folders
# under a root folder, using tail-recursion to ensure that it only
# walks the folder tree once. -Force is used to be able to process
# hidden files/folders as well.
$tailRecursion = {
    param(
        $Path
    )
    foreach ($childDirectory in Get-ChildItem -Force -LiteralPath $Path -Directory) 
    {
        $Path = $childDirectory.FullName
        Write-Host -ForegroundColor Yellow "`$Path= "  -NoNewline
	    Write-Host -ForegroundColor White "`"$Path`""
        #& $tailRecursion -Path $childDirectory.FullName
        & $tailRecursion -Path $Path
    }
    
    $currentChildren = Get-ChildItem -Force -LiteralPath $Path
    $isEmpty = $currentChildren -eq $null
    
    if ($isEmpty) 
    {
        Write-Verbose "Removing empty folder at path '${Path}'." -Verbose
        Remove-Item -Force -LiteralPath $Path
    }
}

#invoke
#$Source ="\\DS224\DESKTOP-SL4OKMD"
$Source="\\DS224\MS-Surface-E6F1US5"
& $tailRecursion -Path $Source


#robocopy "C:\Kat\Flankspeed Exports" "D:\SurfaceBook3-E6F1US5\Kat" /E /COPYALL /DCOPY:DAT /MOVE /R:10 /W:3 /LOG:"D:\SurfaceBook3-E6F1US5\Kat\Flankspeed Exports_2024-08-02-14-33-18.log"