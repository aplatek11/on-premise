# Load and parse the VM deployment configuration from the JSON file into a PowerShell object
$config = Get-Content "V:\repositories\powershell\json\deploy_client.json" | ConvertFrom-Json

# Create VM
New-VM -Name $config.VMName `
       -MemoryStartupBytes $config.MemoryStartupBytes `
       -Generation $config.Generation `
       -SwitchName $config.SwitchName `
       -Path $config.VMPath

# Configure processor and memory
Set-VMProcessor -VMName $config.VMName -Count $config.ProcessorCount

Set-VMMemory -VMName $config.VMName `
             -DynamicMemoryEnabled $config.DynamicMemoryEnabled `
             -StartupBytes $config.MemoryStartupBytes

# Set auto-start and checkpoint behavior
Set-VM -Name $config.VMName -AutomaticStartAction $config.AutomaticStartAction
Set-VM -Name $config.VMName -AutomaticCheckpointsEnabled $config.AutomaticCheckpointsEnabled

# Enable TPM if requested
if ($config.Security.EnableTPM) {
    try {
        Enable-VMTPM -VMName $config.VMName
        Write-Host "Trusted Platform Module enabled for '$($config.VMName)'."
    } catch {
        Write-Error "Failed to enable TPM: $_"
    }
}

# Create and attach differencing disk
if ($config.DifferencingDisk) {
    $disk = $config.DifferencingDisk

    # Ensure parent exists
    if (-not (Test-Path $disk.ParentPath)) {
        throw "Parent VHD not found: $($disk.ParentPath)"
    }

    # Create differencing disk
    New-VHD -Path $disk.Path -ParentPath $disk.ParentPath -Differencing

    # Attach to SCSI controller
    Add-VMHardDiskDrive -VMName $config.VMName `
                        -ControllerType $disk.ControllerType `
                        -ControllerNumber $disk.ControllerNumber `
                        -ControllerLocation $disk.ControllerLocation `
                        -Path $disk.Path
}

Write-Host "VM '$($config.VMName)' deployed successfully with TPM and differencing disk attached."