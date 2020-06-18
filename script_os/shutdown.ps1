#Get arguments
$action = $args[0]
$time = $args[1] -as [int]

#Check if command is help
If ($action -eq "--help"){
    Write-Output "`nUsage : .\statemodif.ps1 -[l (lock) , sd (shutdown)] [number of second before execution]`nNumber of second before execution is 0 if nothing is entered"
    exit
} 

#Check if time is valid
If ($time -is [int]){
    #Action detection
    If ($action -eq "-l"){ 
        Write-Output "Computer will be locked in $time seconds."
        Start-Sleep -s $time
        rundll32.exe user32.dll,LockWorkStation
    } ElseIf($action -eq "-sd"){
        Write-Output "Computer will shutdown in $time seconds."
        Start-Sleep -s $time
        Stop-Computer -ComputerName localhost
    } Else {
        Write-Output "No valid command, type .\statemodif.ps1 --help for documentation"
    }
} Else {
    Write-Output "Time period not valid"
}