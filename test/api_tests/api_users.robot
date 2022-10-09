*** Settings ***
Documentation     API users test suite.
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Library    SeleniumLibrary
Library    ../lib/ApiTest.py    ${TEST_ADDRESS}    api
Suite Setup    Initialize Database For Test 
Suite Teardown    Drop database By Python


*** Variables ***
@{USER_LIST}=    TestUserName
${CREATED_SUCCESS_MESSAGE}    Created
${USER_EXISTED_MESSAGE}    User exists
${EMPTY_USER_MESSAGE}    Username empty
${SHORT_PASSWORD_MESSAGE}    Password too short
${INVALID_PHONE_NUM_MESSAGE}    Password too short
${INVALID_USERNAME_MESSAGE}    Username wrong
${TEST_ROUTE}    users

*** Test Cases ***
User Receive Empty User List When First Make GET Request
    ${response}=    Get Request    ${TEST_ROUTE}
    Should Be Equal    ${response}[status]    ${STATUS}[success]
    Should Be Empty    ${response}[payload]

User Receive Success Message When Make POST Request With Correct User Infomation
    ${response}=    Post Request    ${TEST_ROUTE}    body=${VALID_USER_INFO}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[success]    ${CREATED_SUCCESS_MESSAGE}

User Receive Failed Message When Make POST Request With Existed Username
    ${response}=    Post Request    ${TEST_ROUTE}    body=${VALID_USER_INFO}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[failure]    ${USER_EXISTED_MESSAGE}

User Receive Failed Message When Make POST Request With Empty Username
    ${response}=    Post Request    ${TEST_ROUTE}    body=${EMPTY_USER_INFO}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[failure]    ${EMPTY_USER_MESSAGE}

User Receive Failed Message When Make POST Request With Short Password
    ${response}=    Post Request    ${TEST_ROUTE}    body=${SHORT_PASSWORD_USER}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[failure]    ${SHORT_PASSWORD_MESSAGE}

User Receive Failed Message When Make POST Request With Invalid Phone Number
    ${response}=    Post Request    ${TEST_ROUTE}    body=${INVALID_PHONE_NUM_USER}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[failure]    ${INVALID_PHONE_NUM_MESSAGE}

User Receive Failed Message When Make POST Request With Space Character in Username Field
    ${response}=    Post Request    ${TEST_ROUTE}    body=${SPACE_INCLUDE_USER}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[failure]    ${INVALID_USERNAME_MESSAGE}


