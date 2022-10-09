*** Settings ***
Documentation     API username test suite.
Resource    ../resources/setup.robot
Resource    ../resources/common_variables.robot
Resource    ../resources/common_keywords.robot
Library    SeleniumLibrary
Library    ../lib/ApiTest.py    ${TEST_ADDRESS}    api
Suite Setup    Initialize Database For Test 
Suite Teardown    Drop database By Python


*** Variables ***
${SUCCESS_MESSAGE}    retrieval succesful
${TOKEN_REQUIRED_MESSAGE}    Token authentication required
${INVALID_TOKEN}    Invalid Token
${WRONG_USER_MESSAGE}    Wrong username
&{VALID_USER_MODIFY}    firstname="Modified FirstName"    lastname="Modified LastName"    phone="987654321"
&{INVALID_USERNAME_MODIFY}    username="Modified Username"    password=${CORRECTED_USER_LOGIN}[password]    firstname="Modified FirstName"    lastname="Modified LastName"    phone="987654321"
&{INVALID_PASSWORD_MODIFY}    username=${CORRECTED_USER_LOGIN}[username]    password="Modified password"    firstname="Modified FirstName"    lastname="Modified LastName"    phone="987654321"
&{EMPTY_INFO_MODIFY}    firstname=""    lastname=""    phone=""
${UPDATED_MESSAGE}    Updated
${UPDATED_NOT_ALLOW_MESSAGE}    Field update not allowed
&{MODIFIED_USER_LOGIN}    username=${INVALID_USERNAME_MODIFY}[username]    password=${INVALID_USERNAME_MODIFY}[password]
&{MODIFIED_PASSWORD_LOGIN}    username=${INVALID_PASSWORD_MODIFY}[username]    password=${INVALID_PASSWORD_MODIFY}[password]
${WRONG_TOKEN}    WrongToken
@{EDITABLE_FIELDS}=    firstname    lastname    phone
${TEST_ROUTE}    users


*** Keywords ***
Assert User Info Fields To Expected Result
    [Arguments]    ${response}    ${expectedInfo}
    FOR    ${field}    IN    @{EDITABLE_FIELDS}
        Should Be Equal    ${response}[payload][${field}]    ${expectedInfo}[${field}]
    END
    
Assert User Info Fields Not To Empty
    [Arguments]    ${response}   
    FOR    ${field}    IN    @{EDITABLE_FIELDS}
        Should Not Be Empty    ${response}[payload][${field}]
    END


*** Test Cases ***
User Should Not Get Information When User Not Existed
    ${response}=    Get Request    ${TEST_ROUTE}/${VALID_USER_INFO}[username]
    Then Should Be Equal    ${response}[status]    ${STATUS}[failure]
    And Should Be Equal    ${response}[message]    ${TOKEN_REQUIRED_MESSAGE}

User Get Information When Make Request With Token
    Given Create New User By API Method
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Get Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    token=${token}
    Then Assert Message And Status To Expected Result    ${response}     ${STATUS}[success]    ${SUCCESS_MESSAGE}
    And Assert User Info Fields To Expected Result    ${response}    ${VALID_USER_INFO}

User Should Not Get Information When Username Is Wrong
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Get Request    ${TEST_ROUTE}/${WRONG_USER_LOGIN}[username]    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${WRONG_USER_MESSAGE}

User Should Not Get Information When Token Is Wrong
    ${response}=    Get Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    token=${WRONG_TOKEN}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${INVALID_TOKEN}

User Should Modify Information When Token Is Correct
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Put Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    body=${VALID_USER_MODIFY}    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[success]    ${UPDATED_MESSAGE}

    # Verify again if user info is updated in database by getting information of that user with GET request
    ${response}=    Get Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[success]    ${SUCCESS_MESSAGE}
    And Assert User Info Fields To Expected Result    ${response}    ${VALID_USER_MODIFY}

User Should Not Modify Information When Token Is Wrong
    ${response}=    Put Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    body=${VALID_USER_MODIFY}    token=${WRONG_TOKEN}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${INVALID_TOKEN}

    # Verify again if user info is updated in database by getting information of that user with GET request
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Get Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[success]    ${SUCCESS_MESSAGE}
    And Assert User Info Fields To Expected Result    ${response}    ${VALID_USER_MODIFY}

User Should Not Modify Username Even Token Is Correct
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Put Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    body=${INVALID_USERNAME_MODIFY}    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${UPDATED_NOT_ALLOW_MESSAGE}
    
    # Verify again if user info is updated in database by getting information of that user with GET request
    ${token}=    Get Request    auth/token    authentication=${MODIFIED_USER_LOGIN}
    Then Assert Message And Status To Expected Result    ${token}    ${STATUS}[failure]    ${INVALID_USER_MESSAGE}

User Should Not Modify Password Even Token Is Correct
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Put Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    body=${INVALID_PASSWORD_MODIFY}    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${UPDATED_NOT_ALLOW_MESSAGE}

    # Verify again if user info is updated in database by getting information of that user with GET request
    ${token}=    Get Request    auth/token    authentication=${MODIFIED_PASSWORD_LOGIN}
    Then Assert Message And Status To Expected Result    ${token}    ${STATUS}[failure]    ${INVALID_PASSWORD_MESSAGE}

User Should Not Put Empty Fields Even Token Is Correct
    ${token}=    Get Token By API Method    ${CORRECTED_USER_LOGIN}
    ${response}=    Put Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    body=${EMPTY_INFO_MODIFY}    token=${token}
    Then Assert Message And Status To Expected Result    ${response}    ${STATUS}[failure]    ${UPDATED_NOT_ALLOW_MESSAGE}

    # Verify again if user info is updated in database by getting information of that user with GET request
    ${response}=    Get Request    ${TEST_ROUTE}/${CORRECTED_USER_LOGIN}[username]    token=${token}
    Then Assert User Info Fields Not To Empty    ${response}    