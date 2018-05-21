# Azure SQL Auto Scale Run Book

This is a script I wrote to perform a scale up or down of an Azure SQL Database using the AzureRMSQLDatabase command. This can be used with Azure Automation via PowerShell Workflow Runbooks. When I had a request to get this to work I found that many of the published Run Books used the older command which did not recognize what some of the different database tiers were in Azure SQL. This script uses service principle for the authorization automatically. 

You can run this via PowerShell or in a Runbook. You could also add this to an Azure Function that triggers it based on a performance metric. This script gives you the basics needed to either expand the use case or simply add it to Azure Automation and scale it based on a schedule. An example would be scale up to a Premium P1 during business hours and then scale down to a Standard S6 during non-business hours.

## Prerequisites

You will need an Azure Automation account. Please make sure to update the Azure modules once created, before executing the Runbook. If you don't update the Azure modules you will get an error if using an older version.

## Creation Steps

1. Create an Azure Automation Account
2. Create a Runbook named "AzureSQLAutoScale"
3. Choose PowerShell Workflow as the type
4. Edit the Runbook and paste the code from this project


## Parameters

There are a few parameters I call in this script you will need to input for. These fields are case sensitive.

Resource Group Name - name of the resource group where your Azure SQL Database is deployed. (example: MESA_ResourceGroup)

Azure SQL Server Name - name of the Azure SQL Server where your Database is deployed. (example: MESA_Database_Server)

Azure SQL Database Name - name of the Azure SQL Database you are scaling. (example: MESA_Database_1)

Edition - the Azure SQL Database edition you are choosing. (Basic, Standard, Premium)

Tier - the tier of the Database you are choosing based on the edition you selected. (Basic, S0, S1, S2, S3, S4, P1, P2, P3, P4, etc)

More information about Azure SQL Database Editions and tiers can be found here: https://docs.microsoft.com/en-us/azure/sql-database/sql-database-service-tiers-dtu






