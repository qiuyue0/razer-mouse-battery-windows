# ask for user input for the time interval (default = 60)
$default_time_interval = 60
$time_interval = Read-Host "Please enter a time interval (in minutes) for the notification (Press Enter for default: [$($default_time_interval)])"
$time_interval = ($default_time_interval, $time_interval)[[bool]$time_interval]

# install python packages
python.exe -m pip install -r ./requirements.txt

$pythonw_path =  (Get-Command -Name pythonw).Source
$script_path = (Split-Path -Parent $MyInvocation.MyCommand.Definition)  + '\viper_ultimate.pyw'
# set scheduled task, run script every 15 minutes
$action = New-ScheduledTaskAction -Execute $pythonw_path -Argument $script_path
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes $time_interval)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Viper Ultimate Battery Indicator" -Description "A Python script that shows the battery level of a Razer Viper Ultimate mouse as a tray notification every 60 minutes by default."