#MS-Surface-E6F1US5
$Source="\\DS224\MS-Surface-E6F1US5"
$Destination="C:\GitHub"

Get-ChildItem -Directory -Recurse -Path $Source | Where-Object { (Get-ChildItem -Path $_.FullName -Force).Count -eq 0 } | Remove-Item -Force