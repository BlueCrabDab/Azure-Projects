 
#DESCRIPTION 
#This RunBook enables you to vertically scale (up or down) an Azure SQL Database using Azure #Automation. 
#Using the provided runbook, can automatically schedule a database to a scale-up to a Premium/P1 database during peak hours (e.g., 7am to 6pm) and then scale-down the database to a Standard/S0 during non peak hours (e.g., 6pm-7am).

#PARAMETER ResourceGroupName
#Name of Resource Group where Azure SQL Database is located 
#Name of the Azure SQL Database server (Ex: MESA_ResourceGroup) 

#PARAMETER SqlServerName 
#Name of the Azure SQL Database server (Ex: MESA_Database_Server) 

#PARAMETER DatabaseName 
#Target Azure SQL Database name (Ex:MESA_Database_1)

#PARAMETER Edition 
#Desired Azure SQL Database edition {Basic,Standard,Premium}
#For more information on Editions/Performance levels 
#https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-dtu

#PARAMETER Tier 
#Desired performance level {Basic, S0, S1, S2, P1, P2, P3, etc} 

#Author:Joe Joyce  JJoyce@Microsoft.com
#Last Updated: 5.18.2018

workflow AzureSQLAutoScale
{
    param
    (
        #Resource Group Name
        [parameter(Mandatory=$true)]
        [string] $ResourceGroupName,

        # Name of the Azure SQL Database server 
        [parameter(Mandatory=$true)] 
        [string] $SqlServerName,

        # Target Azure SQL Database name 
        [parameter(Mandatory=$true)] 
        [string] $DatabaseName,

        # Desired Azure SQL Database edition {Basic, Standard, Premium}
        [parameter(Mandatory=$true)] 
        [string] $Edition,

        # Desired performance level {Basic, S0, S1, S2, P1, P2, P3, etc}
        [parameter(Mandatory=$true)] 
        [string] $Tier 
    )
    
    
    
       $Conn = Get-AutomationConnection -Name AzureRunAsConnection
        Connect-AzureRmAccount -ServicePrincipal -Tenant $Conn.TenantID `
        -ApplicationId $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint 
        Set-AzureRmSqlDatabase -DatabaseName $DatabaseName -ServerName $SQLServerName -ResourceGroupName $ResourceGroupName -Edition $Edition -RequestedServiceObjectiveName $Tier
    
}
