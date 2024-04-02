Feature: Validate Business Customer Rules in BLM

  Background:
    * url api.baseUrl
    * path aliasPath = "/frontline-response/validate-business-rules"
    * def customer = api.customerId
    * def headers = read("../database/headers.json")
    * def responseSuccessfully = read("../database/response_successfully.json")
    * def responseError = read("../database/response_error.json")


  @GetValidateBusinessCustomerRules
  Scenario Outline: Successfully Validate Business Customer Rules
    Given headers headers.globals
    When method get
    Then status 200
    And match response contains responseSuccessfully.preapprovalCreditStudy

    Examples:
      | documentType | deviceId         | accountNumber | accountType      |
      | TIPDOC_FS001 | 4bf142c8221b5acc | 3501000003    | CUENTA_DE_AHORRO |

  @GetValidateBusinessCustomerRulesErrorDocumentType
  Scenario Outline: Error Validate Business Customer Rules document type
    Given headers headers.notDocumentType
    When method get
    Then status 400
    And match response contains responseError

    Examples:
      | documentNumber | deviceId         | accountNumber | accountType      | reason                              | domain                                      | code    | message                             |
      | 1999980969     | 4bf142c8221b5acc | 3501000003    | CUENTA_DE_AHORRO | Cabecera document-type es requerida | /frontline-response/validate-business-rules | CRB0073 | Cabecera document-type es requerida |

  @GetValidateBusinessCustomerRulesErrorDocumentNumber
  Scenario Outline: Error Validate Business Customer Rules document Number
    Given headers headers.notDocumentNumber
    When method get
    Then status 400
    And match response contains responseError

    Examples:
      | documentType | deviceId         | accountNumber | accountType      | reason                                | domain                                      | code    | message                               |
      | TIPDOC_FS001 | 4bf142c8221b5acc | 3501000003    | CUENTA_DE_AHORRO | Cabecera document-number es requerida | /frontline-response/validate-business-rules | CRB0072 | Cabecera document-number es requerida |


  @GetValidateBusinessCustomerRulesErrorDeviceId
  Scenario Outline: Error Validate Business Customer Rules device id
    Given headers headers.notDeviceId
    When method get
    Then status 400
    And match response contains responseError

    Examples:
      | documentNumber | documentType | accountNumber | accountType      | reason                          | domain                                      | code    | message                         |
      | 1999980969     | TIPDOC_FS001 | 3501000003    | CUENTA_DE_AHORRO | Cabecera device-id es requerida | /frontline-response/validate-business-rules | CRB0074 | Cabecera device-id es requerida |

  @GetValidateBusinessCustomerRulesErrorAccountNumber
  Scenario Outline: Error Validate Business Customer Rules account Number
    Given headers headers.notAccountNumber
    When method get
    Then status 400
    And match response contains responseError

    Examples:
      | documentNumber | documentType | deviceId         | accountType      | reason                               | domain                                      | code    | message                              |
      | 1999980969     | TIPDOC_FS001 | 4bf142c8221b5acc | CUENTA_DE_AHORRO | Cabecera account-number es requerida | /frontline-response/validate-business-rules | CRB0075 | Cabecera account-number es requerida |

  @GetValidateBusinessCustomerRulesErrorAccountType
  Scenario Outline: Error Validate Business Customer Rules daccount type
    Given headers headers.notAccountType
    When method get
    Then status 400
    And match response contains responseError

    Examples:
      | documentNumber | documentType | deviceId         | accountNumber | reason                             | domain                                      | code    | message                            |
      | 1999980969     | TIPDOC_FS001 | 4bf142c8221b5acc | 3501000003    | Cabecera account-type es requerida | /frontline-response/validate-business-rules | CRB0076 | Cabecera account-type es requerida |
