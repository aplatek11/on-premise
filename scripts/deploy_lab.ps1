$vmConfigs = Get-Content "V:\repositories\powershell\json\deploy_lab" | ConvertFrom-Json

foreach ($config in $vmConfigs) {
    Write-Host "Creating VM: $($config.VMName)"

New-VM -Name $config.VMName `
       -MemoryStartupBytes $config.MemoryStartupBytes `
       -Generation $config.Generation `
       -SwitchName $config.SwitchName `
       -Path $config.VMPath

Set-VMProcessor -VMName $config.VMName -Count $config.ProcessorCount

Set-VMMemory -VMName $config.VMName `
             -DynamicMemoryEnabled $config.DynamicMemoryEnabled `
             -StartupBytes $config.MemoryStartupBytes
    Set-VM -Name $config.VMName -AutomaticStartAction $config.AutomaticStartAction

    Set-VM -Name $config.VMName -AutomaticCheckpointsEnabled $config.AutomaticCheckpointsEnabled

    # Optional VHD creation
    #if ($config.VHDPath -and $config.VHDSizeBytes) {
    #    New-Item -ItemType Directory -Path (Split-Path $config.VHDPath) -Force | Out-Null
    #    New-VHD -Path $config.VHDPath -SizeBytes $config.VHDSizeBytes -Dynamic
    #    Add-VMHardDiskDrive -VMName $config.VMName -Path $config.VHDPath
    #}

    Write-Host "VM $($config.VMName) created successfully.`n"
}