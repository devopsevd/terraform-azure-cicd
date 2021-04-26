Feature: Ensure that permitted instance size is used as node

  Scenario: Ensure that only the permitted instance size Standard_A1_v2 is used as a node
    Given I have azurerm_linux_virtual_machine defined
    Then it must contain size
    And its value must match the "Standard_A1_v2" regex