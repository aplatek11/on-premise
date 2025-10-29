# Rename the computer to 'DC'
try {
    Rename-Computer -NewName "DC" -Force -ErrorAction Stop
    Write-Host "Computer name successfully changed to 'DC'. A restart is required for the change to take effect."
} catch {
    Write-Error "Failed to rename computer: $_"
}

# Rename network adapter from 'Ethernet' to 'vinternal'
try {
    Rename-NetAdapter -Name "Ethernet" -NewName "vinternal" -ErrorAction Stop
    Write-Host "Adapter renamed from 'Ethernet' to 'vinternal'."
} catch {
    Write-Error "Failed to rename adapter: $_"
    return
}

# Define network settings
$nicName = "vinternal"
$ipAddress = "192.168.10.2"
$prefixLength = 24  # Subnet mask 255.255.255.0
$gateway = "192.168.10.1"
$dnsServer = "127.0.0.0"

try {
    # Remove existing IP settings
    Get-NetIPAddress -InterfaceAlias $nicName -ErrorAction SilentlyContinue | Remove-NetIPAddress -Confirm:$false
    Get-NetIPConfiguration -InterfaceAlias $nicName | Remove-NetRoute -Confirm:$false

    # Set static IP and gateway
    New-NetIPAddress -InterfaceAlias $nicName -IPAddress $ipAddress -PrefixLength $prefixLength -DefaultGateway $gateway -ErrorAction Stop
    Write-Host "IP address and gateway configured for '$nicName'."

    # Set DNS server
    Set-DnsClientServerAddress -InterfaceAlias $nicName -ServerAddresses $dnsServer -ErrorAction Stop
    Write-Host "DNS server set to $dnsServer for '$nicName'."
} catch {
    Write-Error "Failed to configure network settings: $_"
}

# Set time zone to Eastern Standard Time
try {
    Set-TimeZone -Id "Eastern Standard Time"
    Write-Host "Time zone set to Eastern Standard Time."
} catch {
    Write-Error "Failed to set time zone: $_"
}
