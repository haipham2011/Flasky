*** Settings ***
Documentation     API token test suite.
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Library    SeleniumLibrary
Library    ../lib/ApiTest.py    ${TEST_ADDRESS}    api
Suite Setup    Initialize Database For Test 
Suite Teardown    Drop database By Python


*** Variables ***
&{EMPTY_USERNAME_AUTHENTICATION}=    username=   password=${CORRECTED_USER_LOGIN}[password]
&{EMPTY_PASSWORD_AUTHENTICATION}=    username=${CORRECTED_USER_LOGIN}[username]   password=
${TEST_ROUTE}    auth/token

*** Test Cases ***
User Receive API Token When Request With Correct Authentication
    Create New User By API Method
    ${response}=    Get Request    ${TEST_ROUTE}    authentication=${CORRECTED_USER_LOGIN}
    Then Should Not Be Empty    ${response}[token]
    And Should Be Equal    ${response}[status]    ${STATUS}[success]

User Receive Failure Message When Request With Incorrect Username
    ${response}=    Get Request    ${TEST_ROUTE}    authentication=${EMPTY_USERNAME_AUTHENTICATION}  
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${INVALID_USER_MESSAGE}

User Receive Failure Message When Request With Incorrect Password
    ${response}=    Get Request    ${TEST_ROUTE}    authentication=${EMPTY_PASSWORD_AUTHENTICATION}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${INVALID_PASSWORD_MESSAGE}
