Feature: Validate Business Customer Rules in BLM

  Background:
    * url api.baseUrl
    * def usersPath = "/users"
    * def loginPath = "/users/login"
    * def passwordPath = "/users/password"
    * def responseSuccessfully = read("../database/response_successfully.json")
    * def responseError = read("../database/response_error.json")
    * def requestBody = read("../database/body.json")

  @GetUserListSuccessfully
  Scenario: Successfully get user list
    Given path usersPath
    When method Get
    Then status 200
    And match response contains responseSuccessfully.list

  @LoginSuccessfully
  Scenario: Successfully login
    Given path loginPath
    And request requestBody.loginRequest
    When method Post
    Then status 200
    And match response contains responseSuccessfully.loginResponse

  @LoginFailedUsernameInvalid
  Scenario Outline: Failed to login username invalid
    Given path loginPath
    And request requestBody.loginRequestUsernameInvalid
    When method Post
    Then status 404
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | POST:/users/login                      | Not found user                      |

  @LoginFailedpasswordInvalid
  Scenario Outline: Failed to login username invalid
    Given path loginPath
    And request requestBody.loginRequestPasswordInvalid
    When method Post
    Then status 401
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | POST:/users/login                      | Unauthorized: Incorrect password                    |

  @GetUserListSuccessfully
  Scenario: Successfully get user list
    Given path usersPath
    When method Get
    Then status 200
    And match response contains responseSuccessfully.list

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


  @UpdatePasswordFailedTokenMalformed
  Scenario Outline: Failed update password Token malformed
    Given path passwordPath
    And request requestBody.updatePasswordRequest
    And header Authorization = 'Bearer'
    When method Put
    Then status 401
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | PUT:/users/password                       | Token malformed                      |

  @UpdatePasswordFailedTokenExpired
  Scenario Outline: Failed update password Token Expired
    Given path passwordPath
    And request requestBody.updatePasswordRequest
    And header Authorization = 'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJwcnVlYmExIiwiaXNzIjoiaW5nZXNpcy51bmlxdWluZGlvLmVkdS5jbyIsImlhdCI6MTcxMjAzNjUyMSwiZXhwIjoxNzEyMDM2NTIyfQ.2Y-z7uC_P6Elpvv7hqzv76-xX-mSx3xMf_hlt2Csq68'
    When method Put
    Then status 401
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | PUT:/users/password                       | Expired token                        |


  @AddUserSuccessfully
  Scenario: Successfully add user
    Given path usersPath
    And request requestBody.userNew
    When method Post
    Then status 201
    * def id = response.user.id
    * karate.set('id', id)
    And match response contains responseSuccessfully.userNew
    Given path usersPath + '/' + id
    When method Delete

  @AddUserNotusernameFailed
  Scenario Outline: Failed add user not username
    Given path usersPath
    And request requestBody.userNewNotUsername
    When method Post
    Then status 400
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | POST:/users                    | The username field is required                    |
  @AddUserNotEmailFailed
  Scenario Outline: Failed add user not email
    Given path usersPath
    And request requestBody.userNewNotEmail
    When method Post
    Then status 400
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | POST:/users                    | The email field is required                  |

  @AddUserNotPasswordFailed
  Scenario Outline: Failed add user not password
    Given path usersPath
    And request requestBody.userNewNotPassword
    When method Post
    Then status 400
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | POST:/users                    | The password field is require                 |

  @DeleteUserSuccessfully
  Scenario: Successfully delete user
    Given path usersPath
    And request requestBody.userNew
    When method Post
    * def id = response.user.id
    * karate.set('id', id)
    And match response contains responseSuccessfully.userNew
    Given path usersPath + '/' + id
    When method Delete
    Then status 204


  @GetUserByIdSuccessfully
  Scenario: Successfully get user by ID
    Given path usersPath + '/660b711e8306ec2895e3b3c4'
    When method Get
    Then status 200
    And match response contains responseSuccessfully.userNew

  @GetUserByIdFailed
  Scenario Outline: Failed get user by ID
    Given path usersPath + '/1234567'
    When method Get
    Then status 404
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | GET:/users/1234567                      | Not found user                     |

  @UpdateUserSuccessfully
  Scenario: Successfully update user
    Given path usersPath
    And request requestBody.userUpdate
    When method Put
    Then status 200
    And match response contains responseSuccessfully.userNew

  @UpdateUserNotExistFailed
  Scenario Outline: failed update user not exist
    Given path usersPath
    And request requestBody.userUpdateFailed
    When method Put
    Then status 404
    And match response contains responseError
    Examples:
      | domain                                    | message                              |
      | PUT:/users                       | Not found user                     |


