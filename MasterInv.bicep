//Master Initiative

// Azure Automation Account

resource symbolicname 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: 'arcautomationV1.0'
  location: 'US East2'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {}
  }
  properties: {
    disableLocalAuth: false
    encryption: {
      identity: {
        userAssignedIdentity: any()
      }
      keySource: 'Microsoft.Keyvault' 
      keyVaultProperties: {
        keyName: 'string'
        keyvaultUri: 'string'
        keyVersion: 'string'
      }
    }
    publicNetworkAccess: false
    sku: {
      capacity: 30
      family: 'string'
      name: 'Free'
    }
  }
}

// MDC LA Workspace

resource symbolicname 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: 'arcloganalyticworkspace'
  location: 'US East2'
  properties: {
    defaultDataCollectionRuleResourceId: 'string'
    features: {
      clusterResourceId: 'string'
      disableLocalAuth: true
      enableDataExport: false
      enableLogAccessUsingOnlyResourcePermissions: true
      immediatePurgeDataOn30Days: false
    }
    forceCmkForQuery: false
    publicNetworkAccessForIngestion: 'disabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 180
    sku: {
      capacityReservationLevel: int
      name: 'string'
    }
    workspaceCapping: {
      dailyQuotaGb: int
    }
  }
}

// Storage Account

resource symbolicname 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'arcstorageaccountV1.0'
  location: 'USeast2'
  sku: {
    name: 'arcblobstorageaccountv1.0'
  }
  kind: 'blob'
  extendedLocation: {
    name: 'USeast2'
    type: 'EdgeZone'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {}
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    allowCrossTenantReplication: false
    allowedCopyScope: 'AAD'
    allowSharedKeyAccess: false
    azureFilesIdentityBasedAuthentication: {
      activeDirectoryProperties: {
        accountType: 'string'
        azureStorageSid: 'string'
        domainGuid: 'string'
        domainName: 'string'
        domainSid: 'string'
        forestName: 'string'
        netBiosDomainName: 'string'
        samAccountName: 'string'
      }
      defaultSharePermission: 'string'
      directoryServiceOptions: 'string'
    }
    customDomain: {
      name: 'string'
      useSubDomainName: false
    }
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'standard'
    encryption: {
      identity: {
        federatedIdentityClientId: 'string'
        userAssignedIdentity: 'string'
      }
      keySource: 'string'
      keyvaultproperties: {
        keyname: 'string'
        keyvaulturi: 'string'
        keyversion: 'string'
      }
      requireInfrastructureEncryption: bool
      services: {
        blob: {
          enabled: bool
          keyType: 'string'
        }
        file: {
          enabled: bool
          keyType: 'string'
        }
        queue: {
          enabled: bool
          keyType: 'string'
        }
        table: {
          enabled: bool
          keyType: 'string'
        }
      }
    }
    immutableStorageWithVersioning: {
      enabled: true
      immutabilityPolicy: {
        allowProtectedAppendWrites: true
        immutabilityPeriodSinceCreationInDays: 180
        state: 'Unlocked'
      }
    }
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: true
    isSftpEnabled: false
    keyPolicy: {
      keyExpirationPeriodInDays: 365
    }
    largeFileSharesState: 'Enabled'
    minimumTlsVersion: 'TLS1_1'
    networkAcls: {
      bypass: 'Logging'
      defaultAction: 'Allow'
      ipRules: [
        {
          action: 'Allow'
          value: 'string'
        }
      ]
      resourceAccessRules: [
        {
          resourceId: 'string'
          tenantId: 'string'
        }
      ]
      virtualNetworkRules: [
        {
          action: 'Allow'
          id: 'string'
          state: 'Proceed'
        }
      ]
    }
    publicNetworkAccess: 'Disabled'
    routingPreference: {
      publishInternetEndpoints: false
      publishMicrosoftEndpoints: true
      routingChoice: 'InternetRouting'
    }
    sasPolicy: {
      expirationAction: 'Log'
      sasExpirationPeriod: '30.1.00.00'
    }
    supportsHttpsTrafficOnly: true
  }
}


// Azure Policy

 //This script is used to identify the status of resources 

 param policyAssignmentName string = 'audit-vm-manageddisks'
 param policyDefinitionID string = '/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d'
 
 resource assignment 'Microsoft.Authorization/policyAssignments@2021-09-01' = {
     name: policyAssignmentName
     scope: subscriptionResourceId('Microsoft.Resources/resourceGroups', resourceGroup().name)
     properties: {
         policyDefinitionId: policyDefinitionID
     }
 }
 
 output assignmentId string = assignment.id
