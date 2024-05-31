Feature: Validate log management

  Background:
    * url api.healthCheckBaseUrl
    * def registerPath = "/register"
    * def serviceHealthPath = "/health"
    * def deleteServicePath = "/delete/apiRestTest"
    * def responseSuccessfully = read("../database/response_successfully.json")
    * def responseError = read("../database/response_error.json")
    * def requestBody = read("../database/body.json")

  @AddAndDeleteServiceSuccessfully
  Scenario: Successfully add service to be monitored through health tests
    Given path registerPath
    And request { name : "apiRestTest", endpoint: "http://localhost:8090/api/v1/actuator/health", status: "active",frequency: 500, notification_emails: ["correo_ejemplo1@example.com"] }
    When method Post
    Then status 201
    Given path deleteServicePath
    When method Delete
    Then status 200

  @CheckServicehealthSuccessfully
  Scenario: check the health status of a registered service that is working well
    Given path serviceHealthPath + "/apiRest"
    When method Get
    Then status 200


  @CheckServicehealthWithError
  Scenario: check the health status of a registered service that is failing
    Given path serviceHealthPath + "/apiRestError"
    When method Get
    Then status 503

  @ListServicesSuccessfully
  Scenario: List all services that are being monitored
    Given path "/services"
    When method Get
    Then status 200


