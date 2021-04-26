Feature: Ensure that Storage account type is Standard_LRS

  Scenario: Ensure that VM storage acccount type is Standard_LRS
    Given I have azurerm_linux_virtual_machine defined
    Then it must contain storage_account_type
    And its value must match the "Standard_LRS" regex