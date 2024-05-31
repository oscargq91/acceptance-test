Feature: Validate log management

  Background:
    * url api.gatewayUrl
    * def infoPath = "/api-gateway/info"
    * def loginPath = "/users/login"
    * def passwordPath = "/users/password"
    * def responseSuccessfully = read("../database/response_successfully.json")
    * def responseError = read("../database/response_error.json")
    * def requestBody = read("../database/body.json")



  @updateInfoSuccessfully
  Scenario: Successfully login and update user and profile
    * def loginRequest = requestBody.loginRequest
    * def updateRequest = requestBody.requestInfo
    Given path loginPath
    And request loginRequest
    When method Post
    Then status 200
    * def token = response.token
    * karate.set('token', token)
    And match response contains responseSuccessfully.loginResponse
    Given path infoPath
    And request updateRequest
    And header Authorization = karate.get('token')
    When method Put
    Then status 200

  @getInfoSuccessfully
  Scenario: Successfully login and update user and profile
    * def loginRequest = requestBody.loginRequest
    Given path loginPath
    And request loginRequest
    When method Post
    Then status 200
    * def token = response.token
    * karate.set('token', token)
    And match response contains responseSuccessfully.loginResponse
    Given path infoPath
    And header Authorization = karate.get('token')
    When method Get
    Then status 200


  @LoginAndUpdatePasswordSuccessfully
  Scenario: Successfully login and update password
    * def loginRequest = requestBody.loginRequest
    * def updatePasswordRequest = requestBody.updatePasswordRequest
    Given path loginPath
    And request loginRequest
    When method Post
    Then status 200
    * def token = response.token
    * karate.set('token', token)
    And match response contains responseSuccessfully.loginResponse
    Given path passwordPath
    And request updatePasswordRequest
    And header Authorization = karate.get('token')
    When method Put
    Then status 200
    And match response contains responseSuccessfully.updatePasswordResponse

  @LoginSuccessfully
  Scenario: Successfully login and update password
    * def loginRequest = requestBody.loginRequest
    Given path loginPath
    And request loginRequest
    When method Post
    Then status 200



