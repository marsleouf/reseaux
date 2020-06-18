Write-Host Get average ping latency to 8.8.8.8 server...`n
# Get the average ping latency
$rep_time = (Test-Connection -ComputerName "8.8.8.8" -Count 4  | measure-Object -Property ResponseTime -Average).average 

# Get basics information about the computer
$name = $env:computername
$main_ip = ((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
$os_name = $system.Caption
$os_version = $system.Version
$lastboot = Get-CimInstance -ClassName win32_operatingsystem | Select-Object -ExpandProperty lastbootuptime

#Get RAM and Disk usage
$total_ram = [math]::Round($system.TotalVisibleMemorySize / 1000000, 1)
$free_ram = [math]::Round($system.FreePhysicalMemory / 1000000, 1)
$used_ram = [math]::Round(($total_ram - $free_ram), 1)

$total_disk = [math]::Round($disk.Size / 1000000000)
$free_disk = [math]::Round($disk.FreeSpace / 1000000000, 1)
$used_disk = [math]::Round(($total_disk - $free_disk), 1)

#Get user list
$users = Get-WmiObject Win32_UserAccount
$users = $users.Name

Write-Host ----------------------------------------
Write-Host $name footprint report :
Write-Host ----------------------------------------`n
Write-Host OS : $os_name
Write-Host OS version : $os_version
Write-Host Last bootup time : $lastboot`n
Write-Host RAM :
Write-Host `t- Total : $total_ram Go
Write-Host `t- Used : $used_ram Go
Write-Host `t- Free : $free_ram Go
Write-Host Disk :
Write-Host `t- Total : $total_disk Go
Write-Host `t- Used : $used_disk Go
Write-Host `t- Free : $free_disk Go
Write-Host User list :
foreach ($user in $users) {
   Write-Host `t- $user
}

Write-Host `n- Main IP : $main_ip/24
Write-Host `t- 8.8.8.8 average ping time : $rep_time ms