# This Read me will help with deploying a Domain Controller with Active Directory Domain services in your environment

Five files that will be used in order.
* dc_deploy.json
* dc_deploy.ps1
* dc_setup.ps1
* role_ad.ps1
* role_newforest.ps1

Understanding "dc_deploy.json"
This is the JSON file that the powershell script pulls all of the information to deploy your domain controller. Auto Check point is turned off. Also this setup is using a sys prepped hard drive disk so make sure that is set up prior. There are a few changes in the JSON file that need to be made before running.

Changes
VMPath -> Path where the Virtual machine is going to be depolyed
SwitchName -> Name of the switch going to be used
Name -> Name of the disk drive
Path -> The path and new name of the disk drive
ParentPath -> This is the sys prepped Disk Drive

Understanding dc_deploy.ps1
This is the powershell script that will deploy the Domain Controller. The only change that needs to be made is at the top of the script looking for the path that the JSON file is located.

Changes
$config = Get-Content "<<PATH>>" -> Replace <<PATH>> with the actual path to your JSON configuration file

Understanding dc_setup.ps1
The name of the Domain Controller will be changed to "DC". The network information will be set and the time zone will be set to Eastern Time zone unless need to be change. The time zone is at the bottom of the 

Changes
$nicName -> Change to the Name of the NIC that was deployed on the Virtual Machine
$ipAddress -> Change to the IP Address
$prefixLength -> Change to the integer of the Subnet Mask
$gateway -> Add the Default Gateway
<<TIME ZONE>> - Change to the time zone ID
<<TIME ZONE>> -> Change <<TIME ZONE>> to the same name that is set in. 

Understanding role_ad.ps1
This script will add the AD role to the server.

Understanding role_newforest.ps1
This script will promote the server to a DNS server.

Changes
<<DOMAIN>> -> The Domain Name you want to be set .
<<PASSWORD>> -> The safemode password that needs to be set.

Process
Once the values have been change. Run the "dc_deploy" powershell scipt to deploy the virtual machine. Once logged into the virtual machine. Run the "dc_setup" script inside of the virtual machine. Restart the virtual machine to make all the changes. Once logged back into the virtual machine, run the "role_ad" script to the add the AD role to the server. Lastly run the "role_newforest" script to deploy the server as a DNS server.