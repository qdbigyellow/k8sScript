minikube stop
minikube delete
Remove-Item -Recurse -Force C:\Users\bigyellow\.minikube\

Remove-VMSwitch -Name externalSwitch

## Import-Module Hyper-V
## $ethernet = Get-NetAdapter -Name ethernet
## $wifi = Get-NetAdapter -Name wi-fi
New-VMSwitch -Name externalSwitch -NetAdapterName $ethernet.Name -AllowManagementOS $true -Notes 'Parent OS, VMs, LAN'
##New-VMSwitch -Name WiFiExternalSwitch -NetAdapterName $wifi.Name -AllowManagementOS $true -Notes 'Parent OS, VMs, wifi'
##New-VMSwitch -Name privateSwitch -SwitchType Private -Notes 'Internal VMs only'
##New-VMSwitch -Name internalSwitch -SwitchType Internal -Notes 'Parent OS, and internal VMs'

minikube start --vm-driver hyperv --hyperv-virtual-switch=externalSwitch