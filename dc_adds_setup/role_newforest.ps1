# Promotes the server to a domain controller and creates a new forest named "LAB.PRI".
# -InstallDns installs the DNS Server role as part of the domain setup.
# -SafeModeAdministratorPassword sets the Directory Services Restore Mode (DSRM) password.
# -Confirm:$false suppresses the confirmation prompt for unattended execution.
Install-ADDSForest `
    -DomainName "<<DOMAIN>>" `
    -InstallDns `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "<<PASSWORD>>" -AsPlainText -Force) `
    -Confirm:$false