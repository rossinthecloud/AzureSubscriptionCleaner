# Login
Login-AzAccount 

# Get a list of all Azure subscriptions that the user can access and allow them to select one to be cleared
$SubscriptionId = (Get-AzSubscription | select Name, State, SubscriptionId, TenantId | Out-GridView -Title "Select Azure Subscription To Clear" -PassThru).SubscriptionId
Get-AzSubscription -SubscriptionId $SubscriptionId | Select-AzSubscription

# Warning confirmation
Write-Warning "Are you sure you want to DELETE EVERYTHING in Azure Subscription with ID $SubscriptionId" -WarningAction Inquire

# Get all resources and delete them
Get-AzResource | ForEach { Remove-AzResource -ResourceId $_.ResourceId -Force -Confirm:$False }

