# Domain Controller Deployment Guide

This README will help you deploy a Domain Controller with Active Directory Domain Services in your environment.

---

## 📁 Files Used (in order)

1. `client_deploy.json`
2. `client_deploy.ps1`
3. `client_setup.ps1`
4. `client_domainjoin.ps1`

---

## 🧩 Understanding `dc_deploy.json`

This JSON file provides configuration values for deploying your Domain Controller. It disables automatic checkpoints and assumes you're using a sysprepped hard disk. Ensure the disk is prepared before proceeding.

### Required Changes

| Key         | Description                                                  |
|-------------|--------------------------------------------------------------|
| `VMPath`    | Path where the virtual machine will be deployed              |
| `SwitchName`| Name of the virtual switch to be used                        |
| `Name`      | Name of the disk drive                                       |
| `Path`      | Path and new name of the disk drive                          |
| `ParentPath`| Path to the sysprepped disk drive                            |

---

## ⚙️ Understanding `dc_deploy.ps1`

This PowerShell script deploys the Domain Controller using the JSON configuration file.

### Required Change

Update the path to your JSON file:

```powershell
$config = Get-Content "<<PATH>>"
