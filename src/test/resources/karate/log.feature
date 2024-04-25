Feature: Validate log management

  Background:
    * url api.logBaseUrl
    * def createlogPath = "/log"
    * def listLogPath = "/logs"
    * def responseSuccessfully = read("../database/response_successfully.json")
    * def responseError = read("../database/response_error.json")
    * def requestBody = read("../database/body.json")



  @AddLogSuccessfully
  Scenario: Successfully add log
    Given path createlogPath
    And request { application : "acceptance-test", type: "INFO", module: "feature",summary:"Log prueba", description: "Log generado desde las pruebas de aceptacion para comprobar su correcto funcionamiento" }
    When method Post
    Then status 201
    And match response contains responseSuccessfully.log

  @AddLogFailed
  Scenario Outline: Failed add log
    Given path createlogPath
    And request { type: "INFO", module: "feature",summary:"Log prueba", description: "Log generado desde las pruebas de aceptacion para comprobar su correcto funcionamiento" }
    When method Post
    Then status 404
    And match response contains responseError
    Examples:
    | domain                       | message                              |
    | POST:/log                    | A required attribute is missing      |

  @GelogListSuccessfully
  Scenario: Successfully get user list
    Given path listLogPath
    When method Get
    Then status 200
    And match each response == { id: '#string', application : '#string', type: '#string', timestamp: '#string',module: '#string',summary:'#string', description: '#string' }


  @GelogListSuccessfully
  Scenario: Successfully get user list
    Given path listLogPath+ '/acceptance-test'
    When method Get
    Then status 200
    And match each response == { id: '#string', application : '#string', type: '#string', timestamp: '#string',module: '#string',summary:'#string', description: '#string' }

